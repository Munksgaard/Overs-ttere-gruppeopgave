structure Syntax =
struct

  type pos = int * int       (* position in program (line,column) *)

  datatype Exp = ICONST of int * pos
	       | FCONST of real * pos 
	       | ID of string * pos   
	       | PLUS of Exp * Exp * pos   
	       | MINUS of Exp * Exp * pos   
	       | TIMES of Exp * Exp * pos   
	       | DIVIDE of Exp * Exp * pos 
	       | UMINUS of Exp * pos  
	       | EQ of Exp * Exp * pos      
	       | AND of Exp * Exp * pos
	       | OR of Exp * Exp * pos
	       | NOT of Exp * pos
	       | IF of Exp * Exp * Exp * pos

  type Def = string * Exp

  type Pgm = Def list

end
