structure Type :> Type =
struct

  (* Use "raise Error (message,position)" for error messages *)
  exception Error of string*(int*int)

  type pos = int*int

  datatype Type = Int | Bool | TyVar of string

  (* lookup function for symbol table as list of (name,value) pairs *)
  fun lookup x []
        = NONE
    | lookup x ((y,v)::table)
        = if x=y then SOME v else lookup x table

  (* combine two symbol tables and check for duplicates *)
  fun combineTables [] table2 p = table2
    | combineTables ((x,v)::table1) table2 p =
        case lookup x table2 of
          SOME _ => raise Error ("Repeated identifier "^x,p)
        | NONE => (x,v) :: combineTables table1 table2 p

  (* check that type expression is valid and return its type *)
  fun checkType te ttable =
    case te of
      Cat.Int _ => Int
    | Cat.Bool _ => Bool
    | Cat.TyVar (x, pos) => 
       (case lookup x ttable of
	  SOME t => TyVar x
        | _ => raise Error ("Unknown type "^x,pos))

  (* Check pattern and return vtable *)
  fun checkPat pat ty ttable pos =
      (* pat er bodytypen, ty er argumenttypen *)
    case (pat,ty) of
      (Cat.NumP _, Int) => []
    | (Cat.TrueP _, Bool) => []
    | (Cat.FalseP _, Bool) => []
    | (Cat.NullP _, TyVar x) =>
       (case lookup x ttable of
          SOME _ => []
        | _ => raise Error ("Pattern doesn't match type", pos))
    | (Cat.TupleP (t1, _), TyVar x) => 
       (case lookup x ttable of
          SOME t2 => checkTuplePat t1 t2 ttable pos
        | _ => raise Error ("Pattern doesn't match type", pos))
    | (Cat.VarP (x,p), ty) => [(x,ty)]
    | _ => raise Error ("Pattern doesn't match type", pos)

  (* Takes a list of patterns and a list of values and pairs them, returning a vtable *)
  and checkTuplePat [t1] [t2] ttable pos =
        checkPat t1 t2 ttable pos
    | checkTuplePat (t1 :: t1s) (t2 :: t2s) ttable pos =
        (checkPat t1 t2 ttable pos) @ checkTuplePat t1s t2s ttable pos
    | checkTuplePat _ _ _ pos = raise Error ("Tuple error", pos)

  (* check expression and return type *)
  fun checkExp exp vtable ftable ttable =
    case exp of
      Cat.Num (n,pos) => Int
    | Cat.True (pos) => Bool
    | Cat.False (pos) => Bool
    | Cat.Null (s, pos) =>
       (case lookup s ttable of
          SOME t => TyVar s
        | _ => raise Error ("Unknown type argument to null", pos))
    | Cat.Var (x,pos) =>
       (case lookup x vtable of
	  SOME t => t
        | _ => raise Error ("Unknown variable "^x,pos))
    | Cat.Plus (e1,e2,pos) =>
       (case (checkExp e1 vtable ftable ttable,
              checkExp e2 vtable ftable ttable) of
          (Int,Int) => Int
        | _ => raise Error ("Non-int argument to +",pos))
    | Cat.Minus (e1,e2,pos) =>
       (case (checkExp e1 vtable ftable ttable,
              checkExp e2 vtable ftable ttable) of
          (Int,Int) => Int
        | _ => raise Error ("Non-int argument to -",pos))
    | Cat.Equal (e1, e2, pos) =>
       (case (checkExp e1 vtable ftable ttable,
              checkExp e2 vtable ftable ttable) of
          (Int,Int) => Bool
        | _ => raise Error ("Non-int argument to =", pos))
    | Cat.Less (e1, e2, pos) =>
       (case (checkExp e1 vtable ftable ttable,
              checkExp e2 vtable ftable ttable) of
          (Int,Int) => Bool
        | _ => raise Error ("Non-int argument to <", pos))
    | Cat.Not (e, pos) =>
       (case (checkExp e vtable ftable ttable) of
          Bool => Bool
        | _ => raise Error ("Non-bool argument to not", pos))
    | Cat.And (e1, e2, pos) =>
       (case (checkExp e1 vtable ftable ttable,
              checkExp e2 vtable ftable ttable) of
          (Bool,Bool) => Bool
        | _ => raise Error ("Non-int argument to and", pos))
    | Cat.Or (e1, e2, pos) =>
       (case (checkExp e1 vtable ftable ttable,
              checkExp e2 vtable ftable ttable) of
          (Bool,Bool) => Bool
        | _ => raise Error ("Non-int argument to or", pos))
    | Cat.Let (d, e, pos) =>
       let
         val vtable1 = checkDec d vtable ftable ttable
       in
         checkExp e vtable1 ftable ttable
       end
    | Cat.If (eif, ethen, eelse, pos) =>
       let
         val tif = checkExp eif vtable ftable ttable
         val tthen = checkExp ethen vtable ftable ttable
         val telse = checkExp eelse vtable ftable ttable
       in
         case tif of
           Bool => if tthen = telse 
                   then tthen
                   else raise Error ("Then and else not of same type", pos)
         | _ => raise Error ("If clause not of type Bool", pos)
       end
    | Cat.MkTuple (es, s, pos) => 
       (case lookup s ttable of
          SOME ty => 
            let 
              val _ = checkTuple es ty vtable ftable ttable pos
            in
              TyVar s
            end
        | _ => raise Error ("Type not recognized", pos))
    | Cat.Case (e, m, pos) =>
       let
         val ty = checkExp e vtable ftable ttable
       in
         checkMatch m ty vtable ftable ttable pos
       end
    | Cat.Apply (f,e1,pos) =>
       (case lookup f ftable of
	  SOME (t1,t2) =>
	    if t1 = (checkExp e1 vtable ftable ttable)
            then t2
            else raise Error ("Argument does not match declaration of "^f,pos)
        | _ => raise Error ("Unknown function "^f,pos))
    | Cat.Read (n,pos) => Int
    | Cat.Write (e1,pos) =>
       (case checkExp e1 vtable ftable ttable of
          Int => Int
        | _ => raise Error ("Non-int argument to write",pos))

  and checkMatch [(p,e)] tce vtable ftable ttable pos =
      (* tce er argumenttypen, p er patternet  *)
        let
          val vtable1 = checkPat p tce ttable pos
        in
	  checkExp e (vtable1 @ vtable) ftable ttable
        end
    | checkMatch ((p,e)::ms) tce vtable ftable ttable pos =
        let
          val vtable1 = checkPat p tce ttable pos
          val te = checkExp e (vtable1 @ vtable) ftable ttable
          val tm = checkMatch ms tce vtable ftable ttable pos
        in
	  if te = tm then te
	  else raise Error ("Match branches have different type",pos)
        end
    | checkMatch [] tce vtable ftable ttable pos =
        raise Error ("Empty match",pos)

  (* checks the declarations in a dec and returns a vtable*)
  and checkDec [(p, e, pos)] vtable ftable ttable =
        let
          val ty = checkExp e vtable ftable ttable
          val vtable1 = checkPat p ty ttable pos
        in
          vtable1 @ vtable
        end
    | checkDec ((p, e, pos)::ds) vtable ftable ttable = 
        let
          val ty = checkExp e vtable ftable ttable
          val vtable1 = checkPat p ty ttable pos
          val td = checkDec ds (vtable1 @ vtable) ftable ttable
        in
          vtable1 @ td @ vtable
        end
    | checkDec _ _ _ _ = raise Error ("Got empty dec", (0,0))

  and checkTuple [e] [ty] vtable ftable ttable pos =
        if checkExp e vtable ftable ttable = ty
        then [ty]
        else raise Error ("Type do not match", pos)
    | checkTuple (e :: es) (ty :: tys) vtable ftable ttable  pos =
        if checkExp e vtable ftable ttable  = ty
        then ty :: checkTuple es tys vtable ftable ttable pos
        else raise Error ("Types do not match", pos)
    | checkTuple _ _ _ _ _ pos = 
        raise Error ("checkTuple got wrong input!", pos)

  fun getFunDecs [] ttable ftable = ftable
    | getFunDecs ((f, targ, tresult, m, pos)::fs) ttable ftable =
        if List.exists (fn (g,_)=>f=g) ftable
	then raise Error ("Duplicate declaration of function "^f,pos)
        else getFunDecs fs ttable
			((f, (checkType targ ttable, checkType tresult ttable))
			 :: ftable)

  fun checkFunDec ftable ttable (f, targ, tresult, m, pos) =
    let
      val argtype = checkType targ ttable
      val resulttype = checkType tresult ttable
      val bodytype = checkMatch m argtype [] ftable ttable pos
    in
      if resulttype = bodytype
      then resulttype
      else raise Error ("Body type doesn't match declaration",pos)
    end

  fun getTyDec [ty] ttable =
        [checkType ty ttable]
    | getTyDec (ty :: tys) ttable =
        (checkType ty ttable) :: (getTyDec tys ttable)
    | getTyDec _ _ = raise Error ("Bad error in getTyDec!", (0,0))

  fun getTyDecs [] ttable = ttable
    | getTyDecs ((s, tys, pos) :: tyDecs) ttable =
        case lookup s ttable of
          SOME _ => 
            raise Error ("Type with same name already exists", pos)
        | _ =>
            let
              val tyDec = getTyDec tys ((s, []) :: ttable)
            in
              getTyDecs tyDecs ((s, tyDec) :: ttable)
            end

  fun checkProgram (tyDecs, funDecs, e) =
    let
      val ttable = getTyDecs tyDecs []
      val ftable = getFunDecs funDecs ttable []
      val _ = List.map (checkFunDec ftable ttable) funDecs
    in
      (checkExp e [] ftable ttable; ())
    end
end
