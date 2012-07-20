{-# LANGUAGE TemplateHaskell, QuasiQuotes #-}
-- |Simple test module that should compile and yield the following signature
-- or something equivalent.
-- 
-- data Boolean = FALSE | TRUE | FILENOTFOUND
-- answer :: Num a => a
-- random :: Num a => a
-- boolean :: Fmt Boolean
-- booleans :: Fmt [Boolean]
-- fileNotFound :: Num a => a
-- randomBooleans :: Fmt [Boolean]
-- state :: Fmt String
-- blah :: Fmt String
-- blahs :: Fmt [String]
-- hungry :: String
-- full :: String
-- achoo :: Fmt Int64
-- numBlahs :: Num a => a
-- foo :: String
-- bar :: String
-- qux :: String
module TH where

import Data.Binary.Get (runGet)
import Data.Binary.Put (runPut)
import Codec.Binary.XDR.Format
import Codec.Binary.XDR.QQ
import Data.Int
import Codec.Binary.XDR.TH (xdrToFmts)

data Boolean
    = FALSE
    | TRUE
    | FILENOTFOUND
    deriving (Eq, Ord, Enum, Bounded, Show)

-- Declare several types and constants from a big block of XDR code,
-- making reference to Haskell data constructors for the 'boolean' enum:
[xdr|
    const answer = 42;
    const random = 4;
    
    enum boolean {
        TRUE         = 1,
        FALSE        = 0,
        FILENOTFOUND = fileNotFound
    };
    
    typedef boolean booleans < >;
    
    const fileNotFound = 100;
|]

-- Declare a single XDR type encoding via quasiquotes.  Note that
-- quasiquoters can create expressions or declarations.  In expression
-- context, the XDR must consist of a single type declaration or specifier.
-- 
-- As in the declaration version above, references to other types and
-- constants are allowed.  They are mapped to corresponding Haskell
-- identifiers which may be defined elsewhere by any means, including
-- straight Haskell code, TH, Quasiquotes, etc. (so long as they have
-- the right type).
randomBooleans = [xdr| boolean randomBooleans[random] |]

-- Declare some more XDR types via TH, again making reference to
-- identifiers external to the XDR code.  This time, referencing 
-- enum constants that are arbitrary values instead of data constructors
-- (and, in fact, are not even defined until later in the file).
[xdr|
    enum state {
        hungry = 97,
        full   = 0
    };
    
    enum blah {
        foo = 0,
        bar = 100,
        qux = random
    };
    
    typedef blah blahs[numBlahs];
|]

hungry = "hungry"
full   = "full"

-- Just an extra intervening splice - making sure the compiler
-- has to work to find 'foo', 'bar', etc., from the splice above :)
[xdr|
    typedef hyper achoo;
    
    const numBlahs = 1024;
|]

foo = "foo"
bar = "bar"
qux = "qux"

