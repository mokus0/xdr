{
module Language.XDR.Lexer where

import Control.Monad.Loops (iterateUntil)
import qualified Data.ByteString.Lazy.Char8 as BL
}

%wrapper "monad-bytestring"

$digit = [0-9]
$alpha = [a-zA-Z]

@const = \-? $digit+
@ident = $alpha [$alpha $digit \_]*

tokens :-
    <0>         $white+                         { token' Blank }
    
    <0>         \/\*                            { token' Comment `andBegin` comment }
    <comment>   \*\/                            { token' Comment `andBegin` 0       }
    <comment>   ([^\*]|$white)+                 { token' Comment                    }
    <comment>   \*                              { token' Comment                    }
    
    <0>         opaque      { token' (const Opaque      )}
    <0>         string      { token' (const String      )}
    <0>         void        { token' (const Void        )}
    <0>         unsigned    { token' (const Unsigned    )}
    <0>         int         { token' (const Int         )}
    <0>         hyper       { token' (const Hyper       )}
    <0>         float       { token' (const Float       )}
    <0>         double      { token' (const Double      )}
    <0>         bool        { token' (const Bool        )}
    <0>         enum        { token' (const Enum        )}
    <0>         struct      { token' (const Struct      )}
    <0>         union       { token' (const Union       )}
    <0>         switch      { token' (const Switch      )}
    <0>         case        { token' (const Case        )}
    <0>         default     { token' (const Default     )}
    <0>         const       { token' (const Const       )}
    <0>         typedef     { token' (const TypeDef     )}
    <0>         \[          { token' (const LSquare     )}
    <0>         \]          { token' (const RSquare     )}
    <0>         \{          { token' (const LBrace      )}
    <0>         \}          { token' (const RBrace      )}
    <0>         \(          { token' (const LParen      )}
    <0>         \)          { token' (const RParen      )}
    <0>         \<          { token' (const LAngle      )}
    <0>         \>          { token' (const RAngle      )}
    <0>         =           { token' (const Equals      )}
    <0>         \,          { token' (const Comma       )}
    <0>         \*          { token' (const Star        )}
    <0>         \:          { token' (const Colon       )}
    <0>         \;          { token' (const SemiColon   )}
    <0>         @ident      { token' Identifier         }
    <0>         @const      { token' (Constant . readB) }
    

{
-- token' = undefined
token' tok (pos, c, input) len = return (tok (BL.take (fromIntegral len) input) pos)

readB bs = read (BL.unpack bs)

data Token
    = Blank         BL.ByteString  AlexPosn
    | Comment       BL.ByteString  AlexPosn
    | Identifier    BL.ByteString  AlexPosn
    | Opaque        AlexPosn
    | String        AlexPosn
    | Void          AlexPosn
    | Unsigned      AlexPosn
    | Int           AlexPosn
    | Hyper         AlexPosn
    | Float         AlexPosn
    | Double        AlexPosn
    | Bool          AlexPosn
    | Enum          AlexPosn
    | Struct        AlexPosn
    | Union         AlexPosn
    | Switch        AlexPosn
    | Case          AlexPosn
    | Default       AlexPosn
    | Const         AlexPosn
    | TypeDef       AlexPosn
    | Constant      Integer AlexPosn
    | Keyword       BL.ByteString  AlexPosn
    | LSquare       AlexPosn
    | RSquare       AlexPosn
    | LBrace        AlexPosn
    | RBrace        AlexPosn
    | LParen        AlexPosn
    | RParen        AlexPosn
    | LAngle        AlexPosn
    | RAngle        AlexPosn
    | Equals        AlexPosn
    | Comma         AlexPosn
    | Star          AlexPosn
    | Colon         AlexPosn
    | SemiColon     AlexPosn
    | EOF
    deriving (Eq, Show)

isCode :: Token -> Bool
isCode Blank{}   = False
isCode Comment{} = False
isCode _         = True

alexScanCode = iterateUntil isCode alexMonadScan

maybeToken EOF   = Nothing
maybeToken other = Just other

alexEOF = return EOF

}