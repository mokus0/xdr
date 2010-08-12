module Codec.Binary.XDR
    ( module Codec.Binary.XDR
    , module Codec.Binary.XDR.Get
    , module Codec.Binary.XDR.Put
    , module Codec.Binary.XDR.Format
    ) where

import Codec.Binary.XDR.Get
import Codec.Binary.XDR.Put
import Codec.Binary.XDR.Format

import Data.Binary
import Data.Int
import Data.Word

class XDR a where
    format :: Fmt a

putXDR :: XDR a => a -> Put
putXDR = putFmt format

getXDR :: XDR a => Get a
getXDR = getFmt format

instance XDR () where
    format = Void

instance XDR Bool where
    format = Bool

instance XDR Int32 where
    format = Int

instance XDR Word32 where
    format = UInt

instance XDR Int64 where
    format = Hyper

instance XDR Word64 where
    format = UHyper

instance XDR Float where
    format = Float

instance XDR Double where
    format = Double

instance XDR a => XDR (Maybe a) where
    format = Maybe format

