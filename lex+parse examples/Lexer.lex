{
 open Lexing;

 val currentLine = ref 1
 val lineStartPos = ref [0]

 fun getPos lexbuf = getLineCol (getLexemeStart lexbuf)
				(!currentLine)
				(!lineStartPos)

 and getLineCol pos line (p1::ps) =
       if pos>=p1 then (line, pos-p1)
       else getLineCol pos (line-1) ps

 exception LexicalError of string * (int * int) (* (message, (line, column)) *)

 fun lexerError lexbuf s = 
     raise LexicalError (s, getPos lexbuf)

 fun keyword (s, pos) =
     case s of
         "if"           => Parser.IF pos
       | "then"         => Parser.THEN pos
       | "else"         => Parser.ELSE pos
       | "and"          => Parser.AND pos
       | "or"           => Parser.OR pos
       | "not"          => Parser.NOT pos
       | _              => Parser.ID (s,pos);

 }

rule Token = parse
    [` ` `\t` `\r`]     { Token lexbuf } (* whitespace *)
  | [`\n` `\012`]       { currentLine := !currentLine+1;
                          lineStartPos :=  getLexemeStart lexbuf
			                   :: !lineStartPos;
                          Token lexbuf } (* newlines *)
  | "\\" [^ `\n`]*      { Token lexbuf } (* comment *)
  | [`~`]?[`0`-`9`]+ { case Int.fromString (getLexeme lexbuf) of
                               NONE   => lexerError lexbuf "Bad integer"
                             | SOME i => Parser.NUM (i, getPos lexbuf)
                        }
  | [`~`]?(([`0`-`9`]+(`.`[`0`-`9`]* )?|`.`[`0`-`9`]+))
    ([`e``E`][`+``~`]?[`0`-`9`]+)?
                        { case Real.fromString (getLexeme lexbuf) of
                               NONE   => lexerError lexbuf "Bad float"
                             | SOME x => Parser.FLOAT (x, getPos lexbuf)
                        }  
  | ([`a`-`z`] | [`A`-`Z`]) ([`a`-`z`] | [`A`-`Z`] | [`0`-`9`])*
                        { keyword (getLexeme lexbuf, getPos lexbuf) }
  | `+`                 { Parser.PLUS (getPos lexbuf) }
  | `-`                 { Parser.MINUS (getPos lexbuf) }
  | `*`                 { Parser.TIMES (getPos lexbuf) }
  | `/`                 { Parser.DIVIDE (getPos lexbuf) }
  | `(`                 { Parser.LPAR (getPos lexbuf) }
  | `)`                 { Parser.RPAR (getPos lexbuf) }
  | `=`                 { Parser.EQ (getPos lexbuf) }
  | eof                 { Parser.EOF (getPos lexbuf) }
  | _                   { lexerError lexbuf "Illegal symbol in input" }

;
