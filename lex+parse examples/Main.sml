structure Main =
struct

  fun createLexerStream ( is : BasicIO.instream ) =
      Lexing.createLexer (fn buff => fn n => Nonstdio.buff_input is buff 0 n)

  fun compile filename =  
      let val lexbuf = createLexerStream (BasicIO.open_in filename)
          val defs =  (Parser.Defs Lexer.Token lexbuf)
      in
        Interpreter.evalDefs defs
      end


  fun errorMess s = TextIO.output (TextIO.stdErr,s ^ "\n");

  val _ = compile (List.nth(Mosml.argv (),1))
          handle Parsing.yyexit ob => errorMess "Parser-exit\n"
               | Parsing.ParseError ob =>
                   let val Location.Loc (p1,p2)
                             = Location.getCurrentLocation ()
                       val (lin,col)
			     = Lexer.getLineCol p2
						(!Lexer.currentLine)
						(!Lexer.lineStartPos)
                   in
                     errorMess ("Parse-error at line "
                      ^ makestring lin ^ ", column " ^ makestring col)
                   end
               | Lexer.LexicalError (mess,(lin,col)) =>
                     errorMess ("Lexical error: " ^mess^ " at line "
                      ^ makestring lin ^ ", column " ^ makestring col)
	       | Interpreter.RunError (mess,(lin,col)) =>
                     errorMess ("Runtime error: " ^mess^ " at line "
                      ^ makestring lin ^ ", column " ^ makestring col)
               | SysErr (s,_) => errorMess ("Exception: " ^ s)
end
