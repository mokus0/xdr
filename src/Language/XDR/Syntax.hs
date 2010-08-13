{-# LANGUAGE EmptyDataDecls #-}
module Language.XDR.Syntax where

import Data.ByteString.Lazy (ByteString)
import Data.Word

type Constant   = Integer
type Identifier = ByteString

data Multiplicity
    = Fixed Value
    | Variable (Maybe Value)
    deriving (Eq, Show)

data Declaration
    = BasicDec      TypeSpecifier Identifier (Maybe Multiplicity)
    | OpaqueDec                   Identifier Multiplicity
    | StringDec                   Identifier (Maybe Value)
    | OptionalDec   TypeSpecifier Identifier
    | VoidDec
    deriving (Eq, Show)

data Value
    = Lit Constant
    | Var Identifier
    deriving (Eq, Show)

data Signedness
    = Signed
    | Unsigned
    deriving (Eq, Show)

data TypeSpecifier
    = Int   Signedness
    | Hyper Signedness
    | Float
    | Double
    | Bool
    | Enum EnumBody
    | Struct StructBody
    | Union UnionBody
    | TypeVar Identifier
    deriving (Eq, Show)
    
type EnumBody   = [(Identifier, Value)]
type StructBody = [Declaration]
data UnionBody  = UnionBody Declaration [(Value, Declaration)] (Maybe Declaration)
    deriving (Eq, Show)

data ConstantDef = ConstantDef Identifier Constant
    deriving (Eq, Show)
data TypeDef
    = BasicDef  Declaration
    | EnumDef   Identifier EnumBody
    | StructDef Identifier StructBody
    | UnionDef  Identifier UnionBody
    deriving (Eq, Show)

data Definition
    = TypeDef  TypeDef
    | ConstDef ConstantDef
    deriving (Eq, Show)

type Specification = [Definition]
