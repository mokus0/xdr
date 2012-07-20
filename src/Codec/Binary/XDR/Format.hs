{-# LANGUAGE GADTs #-}
module Codec.Binary.XDR.Format
    ( Fmt(..), Struct(..), Union(..)
    , getFmt, putFmt
    ) where

import Codec.Binary.XDR.Get
import Codec.Binary.XDR.Put

import Control.Monad
import Data.Binary
import Data.ByteString.Lazy
import Data.Int
import Data.Word

data Fmt a where
    Void    :: Fmt ()
    Int     :: Fmt Int32
    UInt    :: Fmt Word32
    Enum    :: (Int32 -> Maybe a) -> (a -> Maybe Int32) -> Fmt a
    Bool    :: Fmt Bool
    Hyper   :: Fmt Int64
    UHyper  :: Fmt Word64
    Float   :: Fmt Float
    Double  :: Fmt Double
    OpaqueF :: Word32 -> Fmt ByteString
    OpaqueV :: Maybe Word32 -> Fmt ByteString
    String  :: Maybe Word32 -> Fmt ByteString
    ArrayF  :: Fmt a -> Word32 -> Fmt [a]
    ArrayV  :: Fmt a -> Maybe Word32 -> Fmt [a]
    Maybe   :: Fmt a -> Fmt (Maybe a)
    Struct  :: Struct a -> Fmt a
    Union   :: Union a -> Fmt a
    Iso     :: (a -> b) -> (b -> a) -> Fmt a -> Fmt b

getFmt :: Fmt a -> Get a
getFmt Void         = getVoid
getFmt Int          = getInt
getFmt UInt         = getUnsignedInt
getFmt (Enum f _)   = getEnumBy f
getFmt Bool         = getBool
getFmt Hyper        = getHyper
getFmt UHyper       = getUnsignedHyper
getFmt Float        = getFloat
getFmt Double       = getDouble
getFmt (OpaqueF n)  = getFixedOpaque n
getFmt (OpaqueV n)  = getVariableOpaque n
getFmt (String n)   = getString n
getFmt (ArrayF f n) = getFixedArray (getFmt f) n
getFmt (ArrayV f n) = getVariableArray (getFmt f) n
getFmt (Maybe f)    = getOptional (getFmt f)
getFmt (Struct s)   = getStruct_ s
getFmt (Union u)    = do
    tag <- getInt
    case getUnion_ tag u of
        Nothing         -> fail "getFmt: union tag not defined"
        Just getItem    -> getItem
getFmt (Iso f _ t)  = fmap f (getFmt t)

getStruct_ :: Struct a -> Get a
getStruct_ Empty = getVoid
getStruct_ (Field f) = getFmt f
getStruct_ (CatStructs a b) = do
    a <- getStruct_ a
    b <- getStruct_ b
    return (a,b)

getUnion_ :: Int32 -> Union a -> Maybe (Get a)
getUnion_ tag (Default _ f) = Just (getFmt f)
getUnion_ tag (Case t f)
    | t == tag  = Just (getFmt f)
    | otherwise = Nothing
getUnion_ tag (MergeUnions a b) = fmap (fmap Left) (getUnion_ tag a) `mplus` fmap (fmap Right) (getUnion_ tag b)

putFmt :: Fmt a -> a -> Put
putFmt Void         = const putVoid
putFmt Int          = putInt
putFmt UInt         = putUnsignedInt
putFmt (Enum _ f)   = putEnumBy f
putFmt Bool         = putBool
putFmt Hyper        = putHyper
putFmt UHyper       = putUnsignedHyper
putFmt Float        = putFloat
putFmt Double       = putDouble
putFmt (OpaqueF n)  = putFixedOpaque n
putFmt (OpaqueV n)  = putVariableOpaque n
putFmt (String n)   = putString n
putFmt (ArrayF f n) = putFixedArray (putFmt f) n
putFmt (ArrayV f n) = putVariableArray (putFmt f) n
putFmt (Maybe f)    = putOptional (putFmt f)
putFmt (Struct s)   = putStruct_ s
putFmt (Union u)    = putUnion_ u
putFmt (Iso _ f t)  = putFmt t . f

putStruct_ :: Struct a -> a -> Put
putStruct_ Empty = const putVoid
putStruct_ (Field f) = putFmt f
putStruct_ (CatStructs a b) = \(x,y) -> do
    putStruct_ a x
    putStruct_ b y

putUnion_ :: Union a -> a -> Put
putUnion_ (Default t f) x = do
    putInt t
    putFmt f x
putUnion_ (Case t f) x = do
    putInt t
    putFmt f x
putUnion_ (MergeUnions a b) (Left  x) = putUnion_ a x
putUnion_ (MergeUnions a b) (Right x) = putUnion_ b x

data Struct a where
    Empty       :: Struct ()
    Field       :: Fmt a -> Struct a
    CatStructs  :: Struct a -> Struct b -> Struct (a,b)

data Union a where
    Default     :: Int32 -> Fmt a -> Union a
    Case        :: Int32 -> Fmt a -> Union a
    MergeUnions :: Union a -> Union b -> Union (Either a b)

