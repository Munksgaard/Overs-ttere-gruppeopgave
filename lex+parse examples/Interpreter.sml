structure Interpreter :> Interpreter =
struct

  exception RunError of string*Syntax.pos

  datatype value = IntVal of int | RealVal of real | BoolVal of bool

  fun evalDefs pgm = evalDefs1 pgm []

  and evalDefs1 [] table = ()
    | evalDefs1 ((x,exp)::defs) table =
        let
	  val v = evalExp exp table
	  val vstring = (case v of
	                   IntVal n => Int.toString n
	                 | RealVal v => Real.toString v
	                 | BoolVal b => Bool.toString b)
	in
          (TextIO.output (TextIO.stdOut,x ^" = "^ vstring ^"\n");
	   evalDefs1 defs ((x,v)::table))
	end


  and evalExp exp table =
    case exp of
      Syntax.ICONST (n,p) => IntVal n
    | Syntax.FCONST (v,p) => RealVal v
    | Syntax.ID (x,p) =>
        (case lookup x table of
	   SOME v => v
	 | NONE => raise RunError ("unknown variable: "^x,p))
    | Syntax.PLUS (e1,e2,p) =>
        (case (evalExp e1 table, evalExp e2 table) of
	   (IntVal n1, IntVal n2)   => IntVal (n1+n2)
	 | (IntVal n1, RealVal v2)  => RealVal (Real.fromInt n1+v2)
	 | (RealVal v1, IntVal n2)  => RealVal (v1+Real.fromInt n2)
	 | (RealVal v1, RealVal v2) => RealVal (v1+v2)
	 | _ => raise RunError ("bool arg to +",p))
    | Syntax.MINUS (e1,e2,p) =>
        (case (evalExp e1 table, evalExp e2 table) of
	   (IntVal n1, IntVal n2)   => IntVal (n1-n2)
	 | (IntVal n1, RealVal v2)  => RealVal (Real.fromInt n1-v2)
	 | (RealVal v1, IntVal n2)  => RealVal (v1-Real.fromInt n2)
	 | (RealVal v1, RealVal v2) => RealVal (v1-v2)
	 | _ => raise RunError ("bool arg to -",p))
    | Syntax.TIMES (e1,e2,p) =>
        (case (evalExp e1 table, evalExp e2 table) of
	   (IntVal n1, IntVal n2)   => IntVal (n1*n2)
	 | (IntVal n1, RealVal v2)  => RealVal (Real.fromInt n1*v2)
	 | (RealVal v1, IntVal n2)  => RealVal (v1*Real.fromInt n2)
	 | (RealVal v1, RealVal v2) => RealVal (v1*v2)
	 | _ => raise RunError ("bool arg to *",p))
    | Syntax.DIVIDE (e1,e2,p) =>
        (case (evalExp e1 table, evalExp e2 table) of
	   (IntVal n1, IntVal n2)   =>
	                    RealVal (Real.fromInt n1/Real.fromInt n2)
	 | (IntVal n1, RealVal v2)  => RealVal (Real.fromInt n1/v2)
	 | (RealVal v1, IntVal n2)  => RealVal (v1/Real.fromInt n2)
	 | (RealVal v1, RealVal v2) => RealVal (v1/v2)
	 | _ => raise RunError ("bool arg to /",p))
    | Syntax.UMINUS (e1,p) =>
        (case evalExp e1 table of
	   IntVal n  => IntVal (~n)
	 | RealVal v  => RealVal (~v)
	 | _ => raise RunError ("bool arg to -",p))
    | Syntax.EQ (e1,e2,p) =>
        (case (evalExp e1 table, evalExp e2 table) of
	   (IntVal n1, IntVal n2)   => BoolVal (n1=n2)
	 | (IntVal n1, RealVal v2)  => BoolVal (Real.fromInt n1=v2)
	 | (RealVal v1, IntVal n2)  => BoolVal (v1=Real.fromInt n2)
	 | (RealVal v1, RealVal v2) => BoolVal (v1=v2)
	 | (BoolVal b1, BoolVal b2) => BoolVal (b1=b2)
	 | _ => raise RunError ("bad args to =",p))
    | Syntax.AND (e1,e2,p) =>
        (case (evalExp e1 table, evalExp e2 table) of
	   (BoolVal b1, BoolVal b2) => BoolVal (b1 andalso b2)
	 | _ => raise RunError ("nonbool args to and",p))
    | Syntax.OR (e1,e2,p) =>
        (case (evalExp e1 table, evalExp e2 table) of
	   (BoolVal b1, BoolVal b2) => BoolVal (b1 orelse b2)
	 | _ => raise RunError ("nonbool args to or",p))
    | Syntax.NOT (e1,p) =>
        (case evalExp e1 table of
	   BoolVal b => BoolVal (not b)
	 | _ => raise RunError ("nonbool arg to not",p))
    | Syntax.IF (e1,e2,e3,p) =>
        (case evalExp e1 table of
	   BoolVal b => evalExp (if b then e2 else e3) table
	 | _ => raise RunError ("nonbool condition",p))

  and lookup x [] = NONE
    | lookup x ((y,v)::table) =
        if x=y then SOME v else lookup x table

end
