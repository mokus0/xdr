{-# LANGUAGE GADTs, TemplateHaskell #-}
module Language.XDR.TH where

import Codec.Binary.XDR.Format as Fmt
import Language.XDR as Syn

import Control.Monad
import qualified Data.ByteString.Lazy.Char8 as BL
import Data.Char
import qualified Data.Map as M
import Data.Maybe
import Data.Monoid
import Language.Haskell.TH
import Text.PrettyPrint.HughesPJClass

-- WARNING!!!
-- This is a big ugly ball of code.  Do not read if you value your sanity!
-- For preference, read just enough of it to understand what it's _trying_ to
-- do, come up with a better idea of what it _should_ do, and implement _that_
-- from scratch.

importXDR :: FilePath -> Q [Dec]
importXDR path = runIO (BL.readFile path) >>= xdrToFmts

xdrToFmts :: BL.ByteString -> Q [Dec]
xdrToFmts src = do
    parsed <- either fail return (parseXDR xdr src)
    xdrToHs emptyEnv simpleTHEnv parsed

data THEnv t = THEnv
    { declareType       :: THEnv t -> Env -> Declaration -> Q [Dec]
    , declareConst      :: THEnv t -> Env -> Identifier  -> Q Exp -> Q [Dec]
    , getType           :: THEnv t -> Env -> Identifier  -> Q t
    , getConst          :: THEnv t -> Env -> Identifier  -> Q Exp
    }

newtype Env = Env [Scope]

emptyEnv :: Env
emptyEnv = Env [initScope]

initScope = Scope consts M.empty
    where consts = M.fromList [(BL.pack "TRUE", 1), (BL.pack "FALSE", 0)]

data Scope = Scope
    { constDefs :: M.Map Identifier Constant
    , typeDefs  :: M.Map Identifier Declaration
    }

lookupConst (Env env) ident = getFirst $ mconcat [First (M.lookup ident (constDefs scope)) | scope <- env]

lookupType (Env env) ident = getFirst $ mconcat [First (M.lookup ident (typeDefs scope)) | scope <- env]

lookupVal env (Lit val) = Just val
lookupVal env (Var var) = lookupConst env var

getVal thEnv env (Lit val) = litE (integerL val)
getVal thEnv env (Var var) = getConst thEnv thEnv env var

declaredSymbol (BasicDec    _ ident _) = return ident
declaredSymbol (OpaqueDec     ident _) = return ident
declaredSymbol (StringDec     ident _) = return ident
declaredSymbol (OptionalDec _ ident)   = return ident
declaredSymbol VoidDec                 = mzero

definedSymbol :: Definition -> Maybe Identifier
definedSymbol (TypeDef def) = declaredSymbol (typeDefToDeclaration def)
definedSymbol (ConstDef (ConstantDef ident _)) = Just ident

definedSymbols :: [Definition] -> [Identifier]
definedSymbols = catMaybes . map definedSymbol

getConstDefs defs = M.fromList [(ident, val) | ConstDef (ConstantDef ident val) <- defs]
getTypeDefs  defs = M.fromList [(ident, dec) | TypeDef def <- defs, let dec = typeDefToDeclaration def, ident <- declaredSymbol dec]

typeDefToDeclaration (BasicDef dec)         = dec
typeDefToDeclaration (EnumDef   ident body) = BasicDec (Syn.Enum   body) ident Nothing
typeDefToDeclaration (StructDef ident body) = BasicDec (Syn.Struct body) ident Nothing
typeDefToDeclaration (UnionDef  ident body) = BasicDec (Syn.Union  body) ident Nothing

xdrToHs (Env env) extEnv defs = do
    let localScope = Scope
            { constDefs = getConstDefs defs
            , typeDefs  = getTypeDefs  defs
            }
        localEnv = Env (localScope : env)
    
    fmap concat $ sequence
        [ case def of
            TypeDef def -> do
                let dec = typeDefToDeclaration def
                declareType extEnv extEnv localEnv dec
            ConstDef (ConstantDef ident val) -> do
                declareConst extEnv extEnv localEnv ident (litE (integerL val))
        | def <- defs
        ]
    
simpleTHEnv = THEnv
    { declareType   = \self env dec -> do
        case declaredSymbol dec of
            Nothing -> return []
            Just ident -> do
                let decName = mkName (BL.unpack ident)
                    fmtExp = declarationToFmt self env dec
                thDec <- valD (varP decName) (normalB fmtExp) []
                return [thDec]
                
    , declareConst  = \self env ident val -> do
        let decName = mkName (BL.unpack ident)
        thSig <- sigD decName [t| Num a => a |]
        thDec <- valD (varP decName) (normalB val) []
        return [thSig, thDec]
    , getConst = \self env ident -> nameE (BL.unpack ident)
    , getType  = \self env ident -> nameE (BL.unpack ident)
    }

nameE [] = fail "nameE: empty name"
nameE name@(c:_)
    | isUpper c = conE (mkName name)
    | otherwise = varE (mkName name)


-- |Translates a 'Declaration' to a Template Haskell 'Exp' defining
-- a 'Fmt' representing the encoding described.  Part of 'simpleTHEnv'.
declarationToFmt :: THEnv Exp -> Env -> Declaration -> Q Exp
declarationToFmt thEnv env (BasicDec typeSpec ident mult) = case mult of
    Nothing -> typeSpecToFmt thEnv env typeSpec
    Just (Fixed   val)  -> [| ArrayF $(typeSpecToFmt thEnv env typeSpec) $(getVal thEnv env val)        |]
    Just (Bounded val)  -> [| ArrayV $(typeSpecToFmt thEnv env typeSpec) (Just $(getVal thEnv env val)) |]
    Just Unbounded      -> [| ArrayV $(typeSpecToFmt thEnv env typeSpec) Nothing                        |]
declarationToFmt thEnv env (OpaqueDec ident mult) = case mult of
    Fixed   val -> [| OpaqueF $(getVal thEnv env val)        |]
    Bounded val -> [| OpaqueV (Just $(getVal thEnv env val)) |]
    Unbounded   -> [| OpaqueV Nothing                        |]
declarationToFmt thEnv env (StringDec ident mult) = case mult of
    Nothing    -> [| String Nothing                        |]
    (Just val) -> [| String (Just $(getVal thEnv env val)) |]
declarationToFmt thEnv env (OptionalDec typeSpec ident) = [| Maybe $(typeSpecToFmt thEnv env typeSpec) |]
declarationToFmt thEnv env (VoidDec) = [| Void |]

typeSpecToFmt :: THEnv Exp -> Env -> TypeSpecifier -> Q Exp
typeSpecToFmt thEnv env (Syn.Int   Signed)    = [| Fmt.Int    |]
typeSpecToFmt thEnv env (Syn.Int   Unsigned)  = [| Fmt.UInt   |]
typeSpecToFmt thEnv env (Syn.Hyper Signed)    = [| Fmt.Hyper  |]
typeSpecToFmt thEnv env (Syn.Hyper Unsigned)  = [| Fmt.UHyper |]
typeSpecToFmt thEnv env (Syn.Float)           = [| Fmt.Float  |]
typeSpecToFmt thEnv env (Syn.Double)          = [| Fmt.Double |]
typeSpecToFmt thEnv env (Syn.Bool)            = [| Fmt.Bool   |]
typeSpecToFmt thEnv env (Syn.Enum enumBody)   = do
    let tagToVal = [(getConst thEnv thEnv env tag, getVal thEnv env val) | (tag, val) <- enumBody]
        valToTag = [(val, tag) | (tag, val) <- tagToVal]
        
        liftKVList []           = [| [] |]
        liftKVList ((k,v):rest) = [| ($k,$v) : $(liftKVList rest) |]
    
    [| let valMap = M.fromList $(liftKVList valToTag)
           tagMap = M.fromList $(liftKVList tagToVal)
        in Fmt.Enum (flip M.lookup valMap) (flip M.lookup tagMap) |]

-- Struct
-- Union
typeSpecToFmt thEnv env (Syn.TypeVar ident)   = case lookupType env ident of
    Nothing     -> getType thEnv thEnv env ident
    Just dec    -> declarationToFmt thEnv env dec
