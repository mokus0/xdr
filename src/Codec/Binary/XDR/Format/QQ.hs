module Codec.Binary.XDR.Format.QQ (xdr) where

import Language.Haskell.TH.Quote (QuasiQuoter(..))
import Language.XDR (parseXDR, declaration, type_specifier)
import Language.XDR.TH
import qualified Data.ByteString.Lazy.Char8 as BL

-- |Very rudimentary quasiquoter for XDR formats.
--
-- In expression context, returns a 'Fmt' given an XDR declaration or 
-- type-specifier.  Does not support typedefs or const definitions.
-- Currently does not support structs or unions either.  Enum constants must
-- be valid Haskell identifiers or nullary data constructors in scope at the
-- splice point.
-- 
-- Supports much more of the language in declaration context.
xdr :: QuasiQuoter
xdr = QuasiQuoter 
    { quoteExp  = qExp
    , quoteDec  = xdrToFmts . BL.pack
    , quotePat  = qOther
    , quoteType = qOther
    }
    where
        qExp xdr = case parseXDR declaration (BL.pack xdr) of
            Left err -> tryTypeSpec xdr
            Right dec -> declarationToFmt simpleTHEnv emptyEnv dec
        
        tryTypeSpec xdr = case parseXDR type_specifier (BL.pack xdr) of
            Left err -> fail err
            Right dec -> typeSpecToFmt simpleTHEnv emptyEnv dec
        
        qOther _ = fail "xdr quasiquoter is only usable in expression and declaration contexts"
