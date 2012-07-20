module Codec.Binary.XDR.Get where

import Control.Monad
import Data.Binary.Get
import Data.Binary.IEEE754
import Data.Bits
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as BL
import Data.Int
import Data.List
import Data.Word

getVoid :: Get ()
getVoid = return ()

getInt :: Get Int32
getInt = fmap fromIntegral getWord32be

getUnsignedInt :: Get Word32
getUnsignedInt = getWord32be

getEnum :: Enum a => Get a
getEnum = fmap (toEnum . fromIntegral) getWord32be

getEnumBy :: (Int32 -> Maybe a) -> Get a
getEnumBy f = do
    tag <- getInt
    case f tag of
        Nothing -> fail "getEnumBy: enum tag lookup failed"
        Just a  -> return a

getBool :: Get Bool
getBool = getEnum

getHyper :: Get Int64
getHyper = fmap fromIntegral getWord64be

getUnsignedHyper :: Get Word64
getUnsignedHyper = getWord64be

getFloat :: Get Float
getFloat = getFloat32be

getDouble :: Get Double
getDouble = getFloat64be

getFixedOpaque :: Word32 -> Get BL.ByteString
getFixedOpaque n = do
    bs <- getLazyByteString (fromIntegral n)
    
    case fromIntegral (n .&. 3) of
        0 -> return ()
        m -> skip (4-m)
    
    return bs

getVariableOpaque :: Maybe Word32 -> Get BL.ByteString
getVariableOpaque mbLim = do
    n <- getWord32be
    case mbLim of
        Just lim | n > lim  -> fail "getVariableOpaque: encoded field has length larger than limit"
        _                   -> return ()
    bs <- getLazyByteString (fromIntegral n)
    
    case fromIntegral (n .&. 3) of
        0 -> return ()
        m -> skip (4-m)
    
    return bs

getString :: Maybe Word32 -> Get BL.ByteString
getString = getVariableOpaque

getFixedArray :: Get a -> Word32 -> Get [a]
getFixedArray getItem n = sequence (genericReplicate n getItem)

getVariableArray :: Get a -> Maybe Word32 -> Get [a]
getVariableArray getItem mbLim = do
    n <- getWord32be
    case mbLim of
        Just lim | n > lim  -> fail "getVariableArray: encoded array has count larger than limit"
        _                   -> return ()
    
    sequence (genericReplicate n getItem)

getStruct :: [Get a] -> Get [a]
getStruct = sequence

getUnion :: Enum a => (a -> Get b) -> Get b
getUnion decodeTag = getEnum >>= decodeTag

getUnionBy :: (Int32 -> Maybe (Get b)) -> Get b
getUnionBy decodeTag = join (getEnumBy decodeTag)

getOptional :: Get a -> Get (Maybe a)
getOptional getThing = do
    present <- getBool
    if present then fmap Just getThing else return Nothing