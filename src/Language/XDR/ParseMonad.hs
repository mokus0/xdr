{-# LANGUAGE GeneralizedNewtypeDeriving, FlexibleContexts #-}
module Language.XDR.ParseMonad
    ( ParseXDR, getToken, parseXDR ) where

import Language.XDR.Lexer as Lex

-- alex's "Alex" monad is good enough.  Just make an opaque wrapper around that,
-- with nicer error reporting.
newtype ParseXDR a = P { unP :: Lex.Alex a }

instance Monad ParseXDR where
    return = P . return
    P x >>= f = P (x >>= unP . f)
    fail str = do
        Lex.AlexPn byte line col <- gets Lex.alex_pos
        P $ Alex $ \_ -> Left $ unwords
            [ str
            , "at line" , show line
            , "column",   show col
            ]

get :: ParseXDR Lex.AlexState
get = P (Alex (\st -> Right (st,st)))

gets :: (Lex.AlexState -> a) -> ParseXDR a
gets f = do
    st <- get
    return (f st)

put :: Lex.AlexState -> ParseXDR ()
put st = P (Alex (\_ -> Right (st,())))

getToken :: (Lex.Token -> ParseXDR r) -> ParseXDR r
getToken k = do
    st <- get
    case unAlex alexScanCode st of
        Left err -> fail err
        Right (st, token) -> do
            put st
            k token

parseXDR (P parser) input = runAlex input parser