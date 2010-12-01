
SRCS := Parser.sml Lexer.sml Syntax.sml Interpreter.sml
OBJS := $(SRCS:.sml=.ui) $(SRCS:.sml=.uo)

all : Main

Main : $(OBJS)
	mosmlc -o Main Main.sml


Lexer.sml : Lexer.lex Syntax.sml 
	mosmllex Lexer.lex

Parser.sml Parser.sig : Parser.grm Syntax.sml
	mosmlyac -v Parser.grm

Lexer.uo : Parser.sig

%.uo %.ui : %.sml 
	mosmlc -c $*.sml

Parser.ui : Parser.sig
	mosmlc -c $^

Parser.ui : Syntax.ui

clean:
	rm -f *.ui *.uo Parser.sig Parser.sml Lexer.sml 



