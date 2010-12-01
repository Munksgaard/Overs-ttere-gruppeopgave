local open Obj Lexing in


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

 
fun action_14 lexbuf = (
 lexerError lexbuf "Illegal symbol in input" )
and action_13 lexbuf = (
 Parser.EOF (getPos lexbuf) )
and action_12 lexbuf = (
 Parser.EQ (getPos lexbuf) )
and action_11 lexbuf = (
 Parser.RPAR (getPos lexbuf) )
and action_10 lexbuf = (
 Parser.LPAR (getPos lexbuf) )
and action_9 lexbuf = (
 Parser.DIVIDE (getPos lexbuf) )
and action_8 lexbuf = (
 Parser.TIMES (getPos lexbuf) )
and action_7 lexbuf = (
 Parser.MINUS (getPos lexbuf) )
and action_6 lexbuf = (
 Parser.PLUS (getPos lexbuf) )
and action_5 lexbuf = (
 keyword (getLexeme lexbuf, getPos lexbuf) )
and action_4 lexbuf = (
 case Real.fromString (getLexeme lexbuf) of
                               NONE   => lexerError lexbuf "Bad float"
                             | SOME x => Parser.FLOAT (x, getPos lexbuf)
                        )
and action_3 lexbuf = (
 case Int.fromString (getLexeme lexbuf) of
                               NONE   => lexerError lexbuf "Bad integer"
                             | SOME i => Parser.NUM (i, getPos lexbuf)
                        )
and action_2 lexbuf = (
 Token lexbuf )
and action_1 lexbuf = (
 currentLine := !currentLine+1;
                          lineStartPos :=  getLexemeStart lexbuf
			                   :: !lineStartPos;
                          Token lexbuf )
and action_0 lexbuf = (
 Token lexbuf )
and state_0 lexbuf = (
 let val currChar = getNextChar lexbuf in
 if currChar >= #"A" andalso currChar <= #"Z" then  state_14 lexbuf
 else if currChar >= #"a" andalso currChar <= #"z" then  state_14 lexbuf
 else if currChar >= #"0" andalso currChar <= #"9" then  state_12 lexbuf
 else case currChar of
    #"\t" => action_0 lexbuf
 |  #"\r" => action_0 lexbuf
 |  #" " => action_0 lexbuf
 |  #"\n" => action_1 lexbuf
 |  #"\f" => action_1 lexbuf
 |  #"~" => state_16 lexbuf
 |  #"\\" => state_15 lexbuf
 |  #"=" => action_12 lexbuf
 |  #"/" => action_9 lexbuf
 |  #"." => state_10 lexbuf
 |  #"-" => action_7 lexbuf
 |  #"+" => action_6 lexbuf
 |  #"*" => action_8 lexbuf
 |  #")" => action_11 lexbuf
 |  #"(" => action_10 lexbuf
 |  #"\^@" => action_13 lexbuf
 |  _ => action_14 lexbuf
 end)
and state_10 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_14);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_23 lexbuf
 else backtrack lexbuf
 end)
and state_12 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_3);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_18 lexbuf
 else case currChar of
    #"E" => state_20 lexbuf
 |  #"e" => state_20 lexbuf
 |  #"." => state_19 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_14 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_5);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_25 lexbuf
 else if currChar >= #"A" andalso currChar <= #"Z" then  state_25 lexbuf
 else if currChar >= #"a" andalso currChar <= #"z" then  state_25 lexbuf
 else backtrack lexbuf
 end)
and state_15 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_2);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"\^@" => backtrack lexbuf
 |  #"\n" => backtrack lexbuf
 |  _ => state_24 lexbuf
 end)
and state_16 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_14);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_18 lexbuf
 else case currChar of
    #"." => state_17 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_17 lexbuf = (
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_23 lexbuf
 else backtrack lexbuf
 end)
and state_18 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_3);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_18 lexbuf
 else case currChar of
    #"E" => state_20 lexbuf
 |  #"e" => state_20 lexbuf
 |  #"." => state_19 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_19 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_4);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_19 lexbuf
 else case currChar of
    #"E" => state_20 lexbuf
 |  #"e" => state_20 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_20 lexbuf = (
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_22 lexbuf
 else case currChar of
    #"+" => state_21 lexbuf
 |  #"~" => state_21 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_21 lexbuf = (
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_22 lexbuf
 else backtrack lexbuf
 end)
and state_22 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_4);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_22 lexbuf
 else backtrack lexbuf
 end)
and state_23 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_4);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_23 lexbuf
 else case currChar of
    #"E" => state_20 lexbuf
 |  #"e" => state_20 lexbuf
 |  _ => backtrack lexbuf
 end)
and state_24 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_2);
 let val currChar = getNextChar lexbuf in
 case currChar of
    #"\^@" => backtrack lexbuf
 |  #"\n" => backtrack lexbuf
 |  _ => state_24 lexbuf
 end)
and state_25 lexbuf = (
 setLexLastPos lexbuf (getLexCurrPos lexbuf);
 setLexLastAction lexbuf (magic action_5);
 let val currChar = getNextChar lexbuf in
 if currChar >= #"0" andalso currChar <= #"9" then  state_25 lexbuf
 else if currChar >= #"A" andalso currChar <= #"Z" then  state_25 lexbuf
 else if currChar >= #"a" andalso currChar <= #"z" then  state_25 lexbuf
 else backtrack lexbuf
 end)
and Token lexbuf =
  (setLexLastAction lexbuf (magic dummyAction);
   setLexStartPos lexbuf (getLexCurrPos lexbuf);
   state_0 lexbuf)

(* The following checks type consistency of actions *)
val _ = fn _ => [action_14, action_13, action_12, action_11, action_10, action_9, action_8, action_7, action_6, action_5, action_4, action_3, action_2, action_1, action_0];

end
