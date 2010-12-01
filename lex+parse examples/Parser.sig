local
type t__1__ = (int*int)
type t__2__ = (int*int)
type t__3__ = (int*int)
type t__4__ = (int*int)
type t__5__ = (int*int)
type t__6__ = real*(int*int)
type t__7__ = string*(int*int)
type t__8__ = (int*int)
type t__9__ = (int*int)
type t__10__ = (int*int)
type t__11__ = (int*int)
type t__12__ = int*(int*int)
type t__13__ = (int*int)
type t__14__ = (int*int)
type t__15__ = (int*int)
type t__16__ = (int*int)
type t__17__ = (int*int)
in
datatype token =
    AND of t__1__
  | DIVIDE of t__2__
  | ELSE of t__3__
  | EOF of t__4__
  | EQ of t__5__
  | FLOAT of t__6__
  | ID of t__7__
  | IF of t__8__
  | LPAR of t__9__
  | MINUS of t__10__
  | NOT of t__11__
  | NUM of t__12__
  | OR of t__13__
  | PLUS of t__14__
  | RPAR of t__15__
  | THEN of t__16__
  | TIMES of t__17__
end;

val Defs :
  (Lexing.lexbuf -> token) -> Lexing.lexbuf -> Syntax.Pgm;
