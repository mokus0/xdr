{-# LANGUAGE TemplateHaskell, QuasiQuotes #-}
module TH where

import Codec.Binary.XDR.Format
import Codec.Binary.XDR.Format.QQ
import Language.XDR.TH (xdrToFmts)

data Boolean
    = FALSE
    | TRUE
    | FILENOTFOUND
    deriving (Eq, Ord, Enum, Bounded, Show)

$( xdrToFmts $ unlines
    [ "const answer = 42;"
    , "const random = 4;"
    , ""
    , "enum boolean {"
    , "    TRUE         = 1,"
    , "    FALSE        = 0,"
    , "    FILENOTFOUND = fileNotFound"
    , "};"
    , ""
    , "typedef boolean booleans < >;"
    , ""
    , "const fileNotFound = 100;"
    , "const numBlahs = 1024;"
    ])

randomBooleans = [$xdr| boolean randomBooleans[random] |]

$( xdrToFmts "typedef int blah<numBlahs>;")
