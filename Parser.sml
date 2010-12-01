local
type t__1__ = (int*int)
type t__2__ = (int*int)
type t__3__ = (int*int)
type t__4__ = (int*int)
type t__5__ = (int*int)
type t__6__ = (int*int)
type t__7__ = (int*int)
type t__8__ = (int*int)
type t__9__ = (int*int)
type t__10__ = (int*int)
type t__11__ = (int*int)
type t__12__ = (int*int)
type t__13__ = (int*int)
type t__14__ = (int*int)
type t__15__ = string*(int*int)
type t__16__ = (int*int)
type t__17__ = (int*int)
type t__18__ = (int*int)
type t__19__ = (int*int)
type t__20__ = (int*int)
type t__21__ = (int*int)
type t__22__ = (int*int)
type t__23__ = (int*int)
type t__24__ = (int*int)
type t__25__ = int*(int*int)
type t__26__ = (int*int)
type t__27__ = (int*int)
type t__28__ = (int*int)
type t__29__ = (int*int)
type t__30__ = (int*int)
type t__31__ = (int*int)
type t__32__ = (int*int)
type t__33__ = (int*int)
type t__34__ = (int*int)
type t__35__ = (int*int)
in
datatype token =
    AND of t__1__
  | ARROW of t__2__
  | AT of t__3__
  | BAR of t__4__
  | BOOL of t__5__
  | CASE of t__6__
  | COLON of t__7__
  | COMMA of t__8__
  | ELSE of t__9__
  | END of t__10__
  | EOF of t__11__
  | EQUAL of t__12__
  | FALSE of t__13__
  | FUN of t__14__
  | ID of t__15__
  | IF of t__16__
  | IN of t__17__
  | INT of t__18__
  | LESSTHAN of t__19__
  | LET of t__20__
  | LPAR of t__21__
  | MATCHARROW of t__22__
  | MINUS of t__23__
  | NOT of t__24__
  | NUM of t__25__
  | OF of t__26__
  | OR of t__27__
  | PLUS of t__28__
  | READ of t__29__
  | RPAR of t__30__
  | SEMICOLON of t__31__
  | THEN of t__32__
  | TRUE of t__33__
  | TYPE of t__34__
  | WRITE of t__35__
end;

open Obj Parsing;
prim_val vector_ : int -> 'a -> 'a Vector.vector = 2 "make_vect";
prim_val update_ : 'a Vector.vector -> int -> 'a -> unit = 3 "set_vect_item";

val yytransl = #[
  257 (* AND *),
  258 (* ARROW *),
  259 (* AT *),
  260 (* BAR *),
  261 (* BOOL *),
  262 (* CASE *),
  263 (* COLON *),
  264 (* COMMA *),
  265 (* ELSE *),
  266 (* END *),
  267 (* EOF *),
  268 (* EQUAL *),
  269 (* FALSE *),
  270 (* FUN *),
  271 (* ID *),
  272 (* IF *),
  273 (* IN *),
  274 (* INT *),
  275 (* LESSTHAN *),
  276 (* LET *),
  277 (* LPAR *),
  278 (* MATCHARROW *),
  279 (* MINUS *),
  280 (* NOT *),
  281 (* NUM *),
  282 (* OF *),
  283 (* OR *),
  284 (* PLUS *),
  285 (* READ *),
  286 (* RPAR *),
  287 (* SEMICOLON *),
  288 (* THEN *),
  289 (* TRUE *),
  290 (* TYPE *),
  291 (* WRITE *),
    0];

val yylhs = "\255\255\
\\001\000\006\000\006\000\002\000\005\000\005\000\004\000\004\000\
\\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\\000\000";

val yylen = "\002\000\
\\003\000\009\000\000\000\001\000\001\000\001\000\003\000\003\000\
\\001\000\001\000\003\000\003\000\002\000\001\000\002\000\003\000\
\\002\000";

val yydefred = "\000\000\
\\000\000\000\000\000\000\017\000\000\000\000\000\000\000\000\000\
\\009\000\014\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\001\000\000\000\000\000\004\000\000\000\016\000\000\000\000\000\
\\000\000\000\000\006\000\005\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\002\000\000\000";

val yydgoto = "\002\000\
\\004\000\021\000\012\000\029\000\030\000\005\000";

val yysindex = "\003\000\
\\247\254\000\000\242\254\000\000\033\255\009\255\033\255\033\255\
\\000\000\000\000\033\255\046\255\005\255\000\000\241\254\000\000\
\\000\000\033\255\033\255\000\000\034\255\000\000\000\000\000\000\
\\005\255\243\254\000\000\000\000\024\255\017\255\243\254\247\254\
\\033\255\039\255\000\000\043\255";

val yyrindex = "\000\000\
\\035\255\000\000\000\000\000\000\000\000\000\000\252\254\000\000\
\\000\000\000\000\000\000\000\000\000\000\255\254\000\000\007\255\
\\000\000\000\000\000\000\000\000\000\000\000\000\010\255\021\255\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\035\255\
\\000\000\036\255\000\000\051\255";

val yygindex = "\000\000\
\\000\000\022\000\034\000\028\000\000\000\031\000";

val YYTABLESIZE = 74;
val yytable = "\010\000\
\\006\000\027\000\013\000\001\000\003\000\010\000\010\000\018\000\
\\013\000\013\000\015\000\028\000\019\000\012\000\022\000\013\000\
\\015\000\015\000\010\000\012\000\012\000\013\000\020\000\010\000\
\\011\000\010\000\013\000\031\000\013\000\015\000\011\000\011\000\
\\012\000\032\000\015\000\025\000\015\000\012\000\033\000\012\000\
\\014\000\015\000\031\000\011\000\016\000\008\000\026\000\007\000\
\\011\000\003\000\011\000\023\000\024\000\008\000\007\000\003\000\
\\017\000\009\000\034\000\003\000\007\000\010\000\035\000\003\000\
\\000\000\018\000\036\000\011\000\018\000\003\000\019\000\000\000\
\\000\000\019\000";

val yycheck = "\004\001\
\\015\001\015\001\004\001\001\000\014\001\010\001\011\001\023\001\
\\010\001\011\001\004\001\025\001\028\001\004\001\030\001\007\001\
\\010\001\011\001\023\001\010\001\011\001\023\001\018\001\028\001\
\\004\001\030\001\028\001\004\001\030\001\023\001\010\001\011\001\
\\023\001\010\001\028\001\002\001\030\001\028\001\022\001\030\001\
\\007\000\008\000\004\001\023\001\011\000\010\001\025\000\015\001\
\\028\001\015\001\030\001\018\000\019\000\021\001\004\001\021\001\
\\011\001\025\001\031\000\025\001\010\001\029\001\032\000\029\001\
\\255\255\023\001\033\000\035\001\023\001\035\001\028\001\255\255\
\\255\255\028\001";

val yyact = vector_ 18 (fn () => ((raise Fail "parser") : obj));
(* Rule 1, file Parser.grm, line 39 *)
val _ = update_ yyact 1
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.FunDec list
val d__2__ = peekVal 1 : Cat.Exp
val d__3__ = peekVal 0 : (int*int)
in
( ([],(d__1__),(d__2__)) ) end : Cat.Prog))
;
(* Rule 2, file Parser.grm, line 43 *)
val _ = update_ yyact 2
(fn () => repr(let
val d__1__ = peekVal 8 : (int*int)
val d__2__ = peekVal 7 : string*(int*int)
val d__3__ = peekVal 6 : (int*int)
val d__4__ = peekVal 5 : Cat.Type
val d__5__ = peekVal 4 : (int*int)
val d__6__ = peekVal 3 : Cat.Type
val d__7__ = peekVal 2 : Cat.Match
val d__8__ = peekVal 1 : (int*int)
val d__9__ = peekVal 0 : Cat.FunDec list
in
( (#1 (d__2__), (d__4__), (d__6__), (d__7__), (d__1__)) :: (d__9__) ) end : Cat.FunDec list))
;
(* Rule 3, file Parser.grm, line 44 *)
val _ = update_ yyact 3
(fn () => repr(let
in
( [] ) end : Cat.FunDec list))
;
(* Rule 4, file Parser.grm, line 47 *)
val _ = update_ yyact 4
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.Int (d__1__) ) end : Cat.Type))
;
(* Rule 5, file Parser.grm, line 50 *)
val _ = update_ yyact 5
(fn () => repr(let
val d__1__ = peekVal 0 : int*(int*int)
in
( Cat.NumP (d__1__) ) end : Cat.Pat))
;
(* Rule 6, file Parser.grm, line 51 *)
val _ = update_ yyact 6
(fn () => repr(let
val d__1__ = peekVal 0 : string*(int*int)
in
( Cat.VarP (d__1__) ) end : Cat.Pat))
;
(* Rule 7, file Parser.grm, line 55 *)
val _ = update_ yyact 7
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Pat
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp
in
( [((d__1__),(d__3__))] ) end : Cat.Match))
;
(* Rule 8, file Parser.grm, line 57 *)
val _ = update_ yyact 8
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Match
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Match
in
( (d__1__) @ (d__3__) ) end : Cat.Match))
;
(* Rule 9, file Parser.grm, line 60 *)
val _ = update_ yyact 9
(fn () => repr(let
val d__1__ = peekVal 0 : int*(int*int)
in
( Cat.Num (d__1__) ) end : Cat.Exp))
;
(* Rule 10, file Parser.grm, line 61 *)
val _ = update_ yyact 10
(fn () => repr(let
val d__1__ = peekVal 0 : string*(int*int)
in
( Cat.Var (d__1__) ) end : Cat.Exp))
;
(* Rule 11, file Parser.grm, line 62 *)
val _ = update_ yyact 11
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Exp
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp
in
( Cat.Plus ((d__1__), (d__3__), (d__2__)) ) end : Cat.Exp))
;
(* Rule 12, file Parser.grm, line 63 *)
val _ = update_ yyact 12
(fn () => repr(let
val d__1__ = peekVal 2 : Cat.Exp
val d__2__ = peekVal 1 : (int*int)
val d__3__ = peekVal 0 : Cat.Exp
in
( Cat.Minus ((d__1__), (d__3__), (d__2__)) ) end : Cat.Exp))
;
(* Rule 13, file Parser.grm, line 65 *)
val _ = update_ yyact 13
(fn () => repr(let
val d__1__ = peekVal 1 : string*(int*int)
val d__2__ = peekVal 0 : Cat.Exp
in
( Cat.Apply (#1 (d__1__), (d__2__), #2 (d__1__)) ) end : Cat.Exp))
;
(* Rule 14, file Parser.grm, line 66 *)
val _ = update_ yyact 14
(fn () => repr(let
val d__1__ = peekVal 0 : (int*int)
in
( Cat.Read (d__1__) ) end : Cat.Exp))
;
(* Rule 15, file Parser.grm, line 67 *)
val _ = update_ yyact 15
(fn () => repr(let
val d__1__ = peekVal 1 : (int*int)
val d__2__ = peekVal 0 : Cat.Exp
in
( Cat.Write ((d__2__), (d__1__)) ) end : Cat.Exp))
;
(* Rule 16, file Parser.grm, line 68 *)
val _ = update_ yyact 16
(fn () => repr(let
val d__1__ = peekVal 2 : (int*int)
val d__2__ = peekVal 1 : Cat.Exp
val d__3__ = peekVal 0 : (int*int)
in
( (d__2__) ) end : Cat.Exp))
;
(* Entry Prog *)
val _ = update_ yyact 17 (fn () => raise yyexit (peekVal 0));
val yytables : parseTables =
  ( yyact,
    yytransl,
    yylhs,
    yylen,
    yydefred,
    yydgoto,
    yysindex,
    yyrindex,
    yygindex,
    YYTABLESIZE,
    yytable,
    yycheck );
fun Prog lexer lexbuf = yyparse yytables 1 lexer lexbuf;
