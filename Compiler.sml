(* Compiler for Cat *)
(* Compile by mosmlc -c Compiler.sml *)
(* Then recompile CC by mosmlc CC.sml -o CC *)

structure Compiler :> Compiler =
struct

  (* Use "raise Error (message,position)" for error messages *)
  exception Error of string*(int*int)

  (* Name generator.  Call with, e.g., t1 = "tmp"^newName () *)
  val counter = ref 0

  fun newName () = (counter := !counter + 1;
                  "_" ^ Int.toString (!counter)^ "_")

  (* Number to text with spim-compatible sign symbol *)
  fun makeConst n = if n>=0 then Int.toString n
                    else "-" ^ Int.toString (~n)

  fun tylookup x [] pos = raise Error ("Type "^x^" not found", pos)
    | tylookup x ((s, ts, p) :: table) pos = 
        if x=s then ts else tylookup x table pos

  fun lookup x [] pos = raise Error ("Name "^x^" not found", pos)
    | lookup x ((y,v)::table) pos = if x=y then v else lookup x table pos

  fun isIn x [] = false
    | isIn x (y::ys) = x=y orelse isIn x ys

  (* link register *)
  val RA = "31"
  (* Register for stack pointer *)
  val SP = "29"
  (* Register for heap pointer *)
  val HP = "28"

  (* Suggested register division *)
  val maxCaller = 15   (* highest caller-saves register *)
  val maxReg = 26      (* highest allocatable register *)

  (* compile pattern *)
  fun compilePat p v vtable fail =
    case p of
      Cat.NumP (n,pos) =>
        let
	  val t = "_constPat_"^newName()
        in
          if n<32768 then
	    ([Mips.LI (t, makeConst n),
	      Mips.BNE (v,t,fail)],
	     vtable)
	  else
	    ([Mips.LUI (t, makeConst (n div 65536)),
	      Mips.ORI (t, t, makeConst (n mod 65536)),
	      Mips.BNE (v,t,fail)],
	     vtable)
	end
    | Cat.TrueP (pos) =>
        let
          val t = "_constPat_"^newName()
        in
          ([Mips.LI (t, makeConst 1),
            Mips.BNE (v, t, fail)],
            vtable)
        end
    | Cat.FalseP (pos) =>
        ([Mips.BNE (v, "0", fail)], vtable)
    | Cat.NullP (pos) => 
        ([Mips.BNE (v, "0", fail)], vtable)
    | Cat.VarP (x,pos) =>
        let
          val xt = "_patVar_"^x^"_"^newName()
        in
          ([Mips.MOVE (xt,v)], (x,xt)::vtable)
        end
    | Cat.TupleP (pats, pos) =>
        let
          val (code1, vtable1) = compilePats pats v vtable fail 0
        in
          ([Mips.BEQ (v, "0", fail)] @ code1, vtable1)
        end

  and compilePats [] v vtable fail offset = ([], [])
    | compilePats (pat :: pats) v vtable fail offset =
        let
          val x = "_patTuple_"^newName()
          val code1 = [Mips.LW (x, v, makeConst offset)]
          val (code2, vtable1) = compilePat pat x vtable fail
          val (code3, vtable2) = compilePats pats v (vtable1 @ vtable) fail (offset + 4)
        in
          (code1 @ code2 @ code3, vtable2 @ vtable1 @ vtable)
        end
        
  (* compile expression *)
  fun compileExp e vtable place =
    case e of
      Cat.Num (n,pos) =>
        if n<32768 then
	  [Mips.LI (place, makeConst n)]
	else
	  [Mips.LUI (place, makeConst (n div 65536)),
	   Mips.ORI (place, place, makeConst (n mod 65536))]
    | Cat.True (pos) => [Mips.LI (place, makeConst 1)]
    | Cat.False (pos) => [Mips.LI (place, makeConst 0)]
    | Cat.Null (x,pos) => [Mips.LI (place, makeConst 0)]
    | Cat.Var (x,pos) => [Mips.MOVE (place, lookup x vtable pos)]
    | Cat.Plus (e1,e2,pos) =>
        let
	  val t1 = "_plus1_"^newName()
	  val t2 = "_plus2_"^newName()
          val code1 = compileExp e1 vtable t1
          val code2 = compileExp e2 vtable t2
	in
	  code1 @ code2 @ [Mips.ADD (place,t1,t2)]
	end
    | Cat.Minus (e1,e2,pos) =>
        let
	  val t1 = "_minus1_"^newName()
	  val t2 = "_minus2_"^newName()
          val code1 = compileExp e1 vtable t1
          val code2 = compileExp e2 vtable t2
	in
	  code1 @ code2 @ [Mips.SUB (place,t1,t2)]
	end
    | Cat.Equal (e1, e2, pos) =>
        let
          val t1 = "_equal1_"^newName()
          val t2 = "_equal2_"^newName()
          val l1 = "_equallabel1_"^newName()
          val l2 = "_equallabel2_"^newName()
          val code1 = compileExp e1 vtable t1
          val code2 = compileExp e2 vtable t2
	in
	  code1 @ code2 @ 
          [Mips.BNE (t1,t2,l1), 
           Mips.LI (place, makeConst 1),
           Mips.J l2,
           Mips.LABEL l1,
           Mips.LI (place, "0"),
           Mips.LABEL l2]
	end
    | Cat.Less (e1, e2, pos) =>
        let
          val t1 = "_less1_"^newName()
          val t2 = "_less2_"^newName()
          val l1 = "_lesslabel1_"^newName()
          val l2 = "_lesslabel2_"^newName()
          val code1 = compileExp e1 vtable t1
          val code2 = compileExp e2 vtable t2
	in
	  code1 @ code2 @ 
          [Mips.LUI (place, "0"),
           Mips.SLT (place,t1,t2)]
	end
    | Cat.Not (e, pos) =>
        let
          val t = "_not_"^newName()
          val code = compileExp e vtable t
        in
          code @ [Mips.XORI (place, t, makeConst 1)]
        end
    | Cat.And (e1, e2, pos) =>
        let
          val t1 = "_and1_"^newName()
          val t2 = "_and2_"^newName()
          val code1 = compileExp e1 vtable t1
          val code2 = compileExp e2 vtable t2
        in
          code1 @ code2 @
          [Mips.AND (place, t1, t2)]
        end
    | Cat.Or (e1, e2, pos) =>
        let
          val t1 = "_or1_"^newName()
          val t2 = "_or2_"^newName()
          val code1 = compileExp e1 vtable t1
          val code2 = compileExp e2 vtable t2
        in
          code1 @ code2 @
          [Mips.OR (place, t1, t2)]
        end
    | Cat.Let (d, e, (line, col)) =>
        let
          val t1 = "_let1_"^newName()
          val t2 = "_let2_"^newName()
          val fail = "_letfaillabel_"^newName()
          val errorcode     (* if match fails *)
	    = [Mips.LABEL fail,
	       Mips.LI ("5",makeConst line),
	       Mips.J "_Error_"]
          val (code1, vtable1) = compileDec d vtable fail
          val code2 = compileExp e (vtable1 @ vtable) place
        in
          code1 @ code2
        end
    | Cat.If (eif, ethen, eelse, pos) =>
        let
          val t1 = "_if_"^newName()
          val l1 = "_elselabel_"^newName()
          val l2 = "_exitlabel_"^newName()
          val code1 = compileExp eif vtable t1
          val code2 = compileExp ethen vtable place
          val code3 = compileExp eelse vtable place
	in
          code1 @
	  [Mips.BEQ (t1, "0", l1)]
          @ code2 @
          [Mips.J l2, 
           Mips.LABEL l1]
          @ code3 @
          [Mips.LABEL l2]
        end
    | Cat.MkTuple (es, s, pos) =>
        let
          val len = length es
          val mem = "_compileTupleMem_"^newName()
          val t1 = "_compileTuple1_"^newName()
          val code1 = [Mips.ADDI (mem, HP, "0")]
          val code2 =  [Mips.ADDI (place, mem, "0"),
                        Mips.ADDI (HP, HP, makeConst (len * 4))]
          val code3 = compileTuple es vtable mem
        in
          code1 @ code2 @ code3
        end
    | Cat.Case (e, m, (line, col)) =>
        let
          val t1 = "_case1_"^newName()
          val t2 = "_case2_"^newName()
          val fail = "_casefaillabel_"^newName()
          val endlabel = "_caseendlabel_"^newName()
          val code1 = compileExp e vtable t1
          val code2 = compileMatch m t1 place endlabel fail vtable
          val errorcode     (* if match fails *)
	    = [Mips.LABEL fail,
	       Mips.LI ("5",makeConst line),
	       Mips.J "_Error_"]
        in
          code1 @ code2 @
          errorcode @
          [Mips.LABEL endlabel] 
        end
    | Cat.Apply (f,e,pos) =>
	let
	  val t1 = "_apply_"^newName()
	  val code1 = compileExp e vtable t1
	in
	  code1 @
          [Mips.MOVE ("2",t1), Mips.JAL (f,["2"]), Mips.MOVE (place,"2")]
	end
    | Cat.Read pos =>
        [Mips.LI ("2","5"), (* read_int syscall *)
         Mips.SYSCALL,
         Mips.MOVE (place,"2")]
    | Cat.Write (e,pos) =>
	compileExp e vtable place
        @ [Mips.MOVE ("4",place),
	   Mips.LI ("2","1"),  (* write_int syscall *)
	   Mips.SYSCALL,
	   Mips.LA ("4","_cr_"),
	   Mips.LI ("2","4"),  (* write_string syscall *)
	   Mips.SYSCALL]

  and compileMatch [] arg res endLabel failLabel vtable =
        [Mips.J failLabel]
    | compileMatch ((p,e)::m) arg res endLabel failLabel vtable =
        let
	  val next = "_match_"^newName()
	  val (code1, vtable1) = compilePat p arg vtable next
	  val code2 = compileExp e vtable1 res
	  val code3 = compileMatch m arg res endLabel failLabel vtable
	in
	  code1 @ code2 @ [Mips.J endLabel, Mips.LABEL next] @ code3
	end

  (* compile declarations and return (code,vtable) *)
  and compileDec [] vtable fail =
        ([], [])
    | compileDec ((p,e,pos) :: ds) vtable fail =
        let
          val t = "_dec_"^newName()
          val code1 = compileExp e vtable t
          val (code2, vtable1) = compilePat p t vtable fail
          val (code3, vtable2) = compileDec ds (vtable1 @ vtable) fail
        in
          (code1 @ code2 @ code3, vtable2 @ vtable1 @ vtable)
        end

  and compileTuple [] vtable mem =
        []
    | compileTuple (e :: es) vtable mem =
        let
          val t1 = "_compileTuple1_"^newName()
          val t2 = "_compileTuple2_"^newName()
          val code1 = compileExp e vtable t1
          val code2 = compileTuple es vtable mem
        in
          code1 @
          [Mips.SW (t1, mem, "0"),
           Mips.ADDI (mem, mem, makeConst 4)] @
          code2
        end

  (* code for saving and restoring callee-saves registers *)
  fun stackSave currentReg maxReg savecode restorecode offset =
    if currentReg > maxReg
    then (savecode, restorecode, offset)  (* done *)
    else stackSave (currentReg+1)
                   maxReg
                   (Mips.SW (makeConst currentReg,
                                 SP,
                                 makeConst offset)
                    :: savecode) (* save register *)
                   (Mips.LW (makeConst currentReg,
                                 SP,
                                 makeConst offset)
                    :: restorecode) (* restore register *)
                   (offset-4) (* adjust offset *)


  (* compile function declaration *)
  and compileFun (fname, argty, resty, m, (line,col)) =
        let
	  val atmp = fname ^"_arg_"^ newName()
          val rtmp = fname ^"_res_"^ newName()
          val exit = fname ^"_return_"^ newName()
          val fail = fname ^"_fail_"^ newName()
	  val parcode       (* move R2 to argument *)
            = [Mips.MOVE (atmp, "2")]
          val returncode    (* move return value to R2 *)
            = [Mips.LABEL exit, Mips.MOVE ("2",rtmp)]
          val errorcode     (* if match fails *)
	    = [Mips.LABEL fail,
	       Mips.LI ("5",makeConst line),
	       Mips.J "_Error_"]
          val body = compileMatch m atmp rtmp exit fail []
          val (body1, _, maxr)  (* call register allocator *)
            = RegAlloc.registerAlloc
                (parcode @ body @ returncode) ["2"] 2 maxCaller maxReg
          val (savecode, restorecode, offset) = (* save/restore callee-saves *)
                stackSave (maxCaller+1) maxr [] [] (~8)
        in
            [Mips.COMMENT "",
             Mips.LABEL fname,  (* function label *)
             Mips.SW (RA, SP, "-4")] (* save return address *)
          @ savecode  (* save callee-saves registers *)
          @ [Mips.ADDI (SP,SP,makeConst offset)] (* move SP down *)
          @ body1  (* code for function body *)
          @ [Mips.ADDI (SP,SP,makeConst (~offset))] (* move SP up *)
          @ restorecode  (* restore callee-saves registers *)
          @ [Mips.LW (RA, SP, "-4"), (* restore return addr *)
             Mips.JR (RA, [])] (* return *)
	  @ errorcode
        end


  (* compile program *)
  fun compile (tys, funs, e) =
    let
      val tysCode = []
      val funsCode = List.concat (List.map compileFun funs)
      val mainCode = compileExp e [] "dead" @ [Mips.J "_stop_"]
      val (code1, _, _)
             = RegAlloc.registerAlloc mainCode [] 2 maxCaller maxReg
    in
      [Mips.TEXT "0x00400000",
       Mips.GLOBL "main",
       Mips.LABEL "main",
       Mips.LA (HP, "_heap_")]    (* initialise heap pointer *)
      @ code1                     (* run program *)
      @ funsCode		  (* code for functions *)
      @ [Mips.LABEL "_stop_",
         Mips.LI ("2","10"),      (* syscall control = 10 *)
         Mips.SYSCALL,            (* exit *)
         Mips.LABEL "_Error_",    (* code for reporting match errors *)
	 Mips.LA ("4","_ErrorString_"),
	 Mips.LI ("2","4"), Mips.SYSCALL, (* print string *)
	 Mips.MOVE ("4","5"),
	 Mips.LI ("2","1"), Mips.SYSCALL, (* print line number *)
	 Mips.LA ("4","_cr_"),
	 Mips.LI ("2","4"), Mips.SYSCALL, (* print CR *)
	 Mips.J "_stop_",
	 Mips.DATA "",
	 Mips.LABEL "_cr_",       (* carriage return string *)
	 Mips.ASCIIZ "\n",
	 Mips.LABEL "_ErrorString_",
	 Mips.ASCIIZ "Match failed near line ",
	 Mips.ALIGN "2",
	 Mips.LABEL "_heap_",
	 Mips.SPACE "100000"]
    end

end
