{-# LANGUAGE ParallelListComp #-}
module Language.XDR.Pretty (pPrintXDR) where

import Language.XDR.Syntax

import Data.List
import qualified Data.ByteString.Lazy.Char8 as BL
import Text.PrettyPrint.HughesPJ
import Text.PrettyPrint.HughesPJClass

blText = text . BL.unpack

instance Pretty Multiplicity where
    pPrint (Fixed val) = brackets (pPrint val)
    pPrint (Variable val) = cat [char '<', maybe space pPrint val, char '>']

instance Pretty Declaration where
    pPrint (BasicDec    typeSpec ident mult) = sep [pPrint typeSpec, blText ident, maybe empty pPrint mult]
    pPrint (OpaqueDec            ident mult) = sep [text "opaque",   blText ident, pPrint mult]
    pPrint (StringDec            ident mult) = sep [text "string",   blText ident, pPrint (Variable mult)]
    pPrint (OptionalDec typeSpec ident)      = sep [pPrint typeSpec, char '*',     blText ident]
    pPrint VoidDec = text "void"

instance Pretty Value where
    pPrint (Lit c) = pPrint c
    pPrint (Var v) = blText v

instance Pretty Signedness where
    pPrint Signed   = empty
    pPrint Unsigned = text "unsigned"

instance Pretty TypeSpecifier where
    pPrint (Int   signedness) = pPrint signedness <+> text "int"
    pPrint (Hyper signedness) = pPrint signedness <+> text "hyper"
    pPrint Float    = text "float"
    pPrint Double   = text "double"
    pPrint Bool     = text "bool"
    pPrint (Enum   body) = text "enum"   <+> enumBody   body
    pPrint (Struct body) = text "struct" <+> structBody body
    pPrint (Union  body) = text "union"  <+> pPrint     body
    pPrint (TypeVar ident) = blText ident

enumBody :: EnumBody -> Doc
enumBody body = braces $ nest 4 $ sep $ punctuate comma
        [ sep [blText ident, equals, pPrint val]
        | (ident, val) <- body
        ]

structBody :: StructBody -> Doc
structBody body = braces $ nest 4 $ sep 
    [ pPrint decl <> semi
    | decl <- body
    ]

instance Pretty UnionBody where
    pPrint (UnionBody switchDec cases mbDefault) =
        text "switch" <+> parens (pPrint switchDec) <+> (braces $ sep
            [ unionCases cases
            , maybe empty unionDefault mbDefault
            ])

unionCases cases = sep
    [ text "case" <+> pPrint val <> colon <+> pPrint dec <> semi
    | (val, dec) <- cases
    ]

unionDefault decl = text "default:" <+> pPrint decl <> semi 

instance Pretty ConstantDef where
    pPrint (ConstantDef ident val) = text "const" <+> blText ident <+> equals <+> pPrint val <> semi

instance Pretty TypeDef where
    pPrint (BasicDef decl)      = text "typedef"  <+> pPrint decl                      <> semi
    pPrint (EnumDef   ident body) = text "enum"   <+> blText ident <+> enumBody   body <> semi
    pPrint (StructDef ident body) = text "struct" <+> blText ident <+> structBody body <> semi
    pPrint (UnionDef  ident body) = text "union"  <+> blText ident <+> pPrint     body <> semi

instance Pretty Definition where
    pPrint (TypeDef  def) = pPrint def
    pPrint (ConstDef def) = pPrint def

pPrintXDR :: Specification -> Doc
pPrintXDR = sep . map pPrint