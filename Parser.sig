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
type t__14__ = string*(int*int)
type t__15__ = (int*int)
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
  | BAR of t__3__
  | BOOL of t__4__
  | CASE of t__5__
  | COLON of t__6__
  | COMMA of t__7__
  | ELSE of t__8__
  | END of t__9__
  | EOF of t__10__
  | EQUAL of t__11__
  | FALSE of t__12__
  | FUN of t__13__
  | ID of t__14__
  | IF of t__15__
  | IN of t__16__
  | INT of t__17__
  | LESSTHAN of t__18__
  | LET of t__19__
  | LPAR of t__20__
  | MATCHARROW of t__21__
  | MINUS of t__22__
  | NOT of t__23__
  | NULL of t__24__
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

val Prog :
  (Lexing.lexbuf -> token) -> Lexing.lexbuf -> Cat.Prog;
