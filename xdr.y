{
module Language.XDR.Parser
    ( module Syn
    , xdr
    , definition
    , declaration
    , type_specifier
    , ParseXDR
    , parseXDR
    ) where

import qualified Language.XDR.Lexer  as Lex
import qualified Language.XDR.Syntax as Syn
import Language.XDR.ParseMonad
import Data.Maybe (isJust)
}

%name xdr specification
%name definition definition
%name declaration declaration
%name type_specifier type_specifier

%tokentype { Lex.Token }
%monad { ParseXDR }
%lexer { getToken } { Lex.EOF }

%token
    identifier   { Lex.Identifier $$ _ }
    constant     { Lex.Constant   $$ _ }
    opaque       { Lex.Opaque        _ }
    string       { Lex.String        _ }
    void         { Lex.Void          _ }
    unsigned     { Lex.Unsigned      _ }
    int          { Lex.Int           _ }
    hyper        { Lex.Hyper         _ }
    float        { Lex.Float         _ }
    double       { Lex.Double        _ }
    bool         { Lex.Bool          _ }
    enum         { Lex.Enum          _ }
    struct       { Lex.Struct        _ }
    union        { Lex.Union         _ }
    switch       { Lex.Switch        _ }
    case         { Lex.Case          _ }
    default      { Lex.Default       _ }
    const        { Lex.Const         _ }
    typedef      { Lex.TypeDef       _ }
    '['          { Lex.LSquare       _ }
    ']'          { Lex.RSquare       _ }
    '{'          { Lex.LBrace        _ }
    '}'          { Lex.RBrace        _ }
    '('          { Lex.LParen        _ }
    ')'          { Lex.RParen        _ }
    '<'          { Lex.LAngle        _ }
    '>'          { Lex.RAngle        _ }
    '*'          { Lex.Star          _ }
    '='          { Lex.Equals        _ }
    ','          { Lex.Comma         _ }
    ':'          { Lex.Colon         _ }
    ';'          { Lex.SemiColon     _ }

%%

-- Some useful meta-parsers, copied from the Happy user guide:

opt(p)          : p                   { Just $1 }
                |                     { Nothing }

rev_list1(p)    : p                   { [$1] }
                | rev_list1(p) p      { $2 : $1 }

fst(p,q)        : p q                 { $1 }
snd(p,q)        : p q                 { $2 }
both(p,q)       : p q                 { ($1,$2) }

list1(p)        : rev_list1(p)        { reverse $1 }
list(p)         : list1(p)            { $1 }
                |                     { [] }
sep1(p,q)       : p list(snd(q,p))    { $1 : $2 }

-- The XDR language

declaration :: { Syn.Declaration }
    : type_specifier identifier opt(multiplicity)       { Syn.BasicDec $1 $2 $3 }
    | opaque         identifier multiplicity            { Syn.OpaqueDec $2 $3 }
    | string identifier '<' opt(value) '>'              { Syn.StringDec $2 $4 }
    | type_specifier '*' identifier                     { Syn.OptionalDec $1 $3 }
    | void                                              { Syn.VoidDec }

multiplicity :: { Syn.Multiplicity }
    : '[' value ']'                                     { Syn.Fixed    $2 }
    | '<' value '>'                                     { Syn.Bounded  $2 }
    | '<'       '>'                                     { Syn.Unbounded   }

value :: { Syn.Value }
    : constant                                          { Syn.Lit $1 }
    | identifier                                        { Syn.Var $1 }

type_specifier :: { Syn.TypeSpecifier }
    : signedness int                                    { Syn.Int     $1 }
    | signedness hyper                                  { Syn.Hyper   $1 }
    | float                                             { Syn.Float      }
    | double                                            { Syn.Double     }
    | bool                                              { Syn.Bool       }
    | enum enum_body                                    { Syn.Enum    $2 }
    | struct struct_body                                { Syn.Struct  $2 }
    | union union_body                                  { Syn.Union   $2 }
    | identifier                                        { Syn.TypeVar $1 }

signedness :: { Syn.Signedness }
    : opt(unsigned)                                     { if isJust $1 then Syn.Unsigned else Syn.Signed }

enum_body :: { Syn.EnumBody }
    : '{' sep1(enum_line, ',') '}'                      { $2 }

enum_line :: { (Syn.Identifier, Syn.Value) }
    : identifier '=' value                              { ($1, $3) }

struct_body :: { Syn.StructBody }
    : '{' list1(struct_line) '}'                        { $2 }

struct_line :: { Syn.Declaration }
    : declaration ';'                                   { $1 }

union_body :: { Syn.UnionBody }
    : switch '(' declaration ')' 
        '{' 
            list1(union_case)
            opt(union_default)
        '}'                                             { Syn.UnionBody $3 $6 $7 }

union_case :: { (Syn.Value, Syn.Declaration) }
    : case value ':' declaration ';'                    { ($2, $4) }
union_default
    : default ':' declaration ';'                       { undefined }

constant_def :: { Syn.ConstantDef }
    : const identifier '=' constant ';'                 { Syn.ConstantDef $2 $4 }

type_def :: { Syn.TypeDef }
    : typedef declaration ';'                           { Syn.BasicDef  $2    }
    | enum    identifier enum_body ';'                  { Syn.EnumDef   $2 $3 }
    | struct  identifier struct_body ';'                { Syn.StructDef $2 $3 }
    | union   identifier union_body ';'                 { Syn.UnionDef  $2 $3 }

definition :: { Syn.Definition }
    : type_def                                          { Syn.TypeDef  $1 }
    | constant_def                                      { Syn.ConstDef $1 }

specification :: { Syn.Specification }
    : list(definition)                                  { $1 }

{

happyError = fail msg
    where
        msg = "parse error"

}