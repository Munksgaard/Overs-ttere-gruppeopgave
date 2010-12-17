local
in
datatype token =
    COLON
  | COMMA
  | HEJ
  | ID
  | LPAR
  | RPAR
end;

val Prog :
  (Lexing.lexbuf -> token) -> Lexing.lexbuf -> Cat.Prog;
