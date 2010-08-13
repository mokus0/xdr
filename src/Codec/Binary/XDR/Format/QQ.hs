module Codec.Binary.XDR.Format.QQ where

import Language.Haskell.TH.Quote (QuasiQuoter(..))
import Language.XDR (parseXDR, declaration, type_specifier)
import Language.XDR.TH
import qualified Data.ByteString.Lazy.Char8 as BL

-- |Very rudimentary quasiquoter for XDR formats.  Returns a 'Fmt' given an
-- XDR declaration or type-specifier.  Does not support typedefs or const definitions.
-- Currently does not support enums, structs or unions either.
xdr :: QuasiQuoter
xdr = QuasiQuoter qExp qPat
    where
        qPat _ = fail "xdr quasiquoter is only usable in expression contexts"
        qExp xdr = case parseXDR declaration (BL.pack xdr) of
            Left err -> tryTypeSpec xdr
            Right dec -> declarationToFmt emptyEnv dec
        
        tryTypeSpec xdr = case parseXDR type_specifier (BL.pack xdr) of
            Left err -> fail err
            Right dec -> typeSpecToFmt emptyEnv dec
        
        