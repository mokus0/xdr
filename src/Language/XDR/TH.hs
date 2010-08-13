{-# LANGUAGE GADTs, TemplateHaskell #-}
module Language.XDR.TH where

import Codec.Binary.XDR.Format as Fmt
import Language.XDR as Syn

import qualified Data.ByteString.Lazy.Char8 as BL
import qualified Data.Map as M
import Data.Monoid
import Language.Haskell.TH
import Text.PrettyPrint.HughesPJClass

data Erasure f where
    Erasure :: f a -> Erasure f

newtype Env k t = Env [Scope k t]

emptyEnv :: Env Constant t
emptyEnv = Env [initScope]

initScope :: Scope Constant t
initScope = Scope consts M.empty
    where consts = M.fromList [(BL.pack "TRUE", 1), (BL.pack "FALSE", 0)]

data Scope k t = Scope
    { constDefs :: M.Map Identifier k
    , typeDefs  :: M.Map Identifier t
    }

lookupConst :: Env k t -> Identifier -> Maybe k
lookupConst (Env env) ident = getFirst $ mconcat [First (M.lookup ident (constDefs scope)) | scope <- env]

lookupType :: Env k t -> Identifier -> Maybe t
lookupType (Env env) ident = getFirst $ mconcat [First (M.lookup ident (typeDefs scope)) | scope <- env]

lookupVal env (Lit val) = Just val
lookupVal env (Var var) = lookupConst env var

getVal env val = case lookupVal env val of
    Nothing -> fail ("unknown constant: " ++ show (pPrint val))
    Just v  -> [| fromIntegral v |]

-- |Translates a 'Declaration' to a Template Haskell 'Exp' defining
-- a 'Fmt' representing the encoding described.
declarationToFmt :: Env Constant Declaration -> Declaration -> Q Exp
declarationToFmt env (BasicDec typeSpec ident mult) = case mult of
    Nothing -> typeSpecToFmt env typeSpec
    Just (Fixed val)            -> [| ArrayF $(typeSpecToFmt env typeSpec) $(getVal env val)        |]
    Just (Variable Nothing)     -> [| ArrayV $(typeSpecToFmt env typeSpec) Nothing                  |]
    Just (Variable (Just val))  -> [| ArrayV $(typeSpecToFmt env typeSpec) (Just $(getVal env val)) |]
declarationToFmt env (OpaqueDec ident mult) = case mult of
    Fixed val           -> [| OpaqueF $(getVal env val)        |]
    Variable Nothing    -> [| OpaqueV Nothing                  |]
    Variable (Just val) -> [| OpaqueV (Just $(getVal env val)) |]
declarationToFmt env (StringDec ident mult) = case mult of
    Nothing    -> [| String Nothing                  |]
    (Just val) -> [| String (Just $(getVal env val)) |]
declarationToFmt env (OptionalDec typeSpec ident) = [| Maybe $(typeSpecToFmt env typeSpec) |]
declarationToFmt env (VoidDec) = [| Void |]

typeSpecToFmt :: Env Constant Declaration -> TypeSpecifier -> Q Exp
typeSpecToFmt env (Syn.Int   Signed)    = [| Fmt.Int    |]
typeSpecToFmt env (Syn.Int   Unsigned)  = [| Fmt.UInt   |]
typeSpecToFmt env (Syn.Hyper Signed)    = [| Fmt.Hyper  |]
typeSpecToFmt env (Syn.Hyper Unsigned)  = [| Fmt.UHyper |]
typeSpecToFmt env (Syn.Float)           = [| Fmt.Float  |]
typeSpecToFmt env (Syn.Double)          = [| Fmt.Double |]
typeSpecToFmt env (Syn.Bool)            = [| Fmt.Bool   |]
-- Enum
-- Struct
-- Union
typeSpecToFmt env (Syn.TypeVar ident)   = case lookupType env ident of
    Nothing     -> fail ("typeSpecToFmt: type not found: " ++ show (BL.unpack ident))
    Just dec    -> declarationToFmt env dec
