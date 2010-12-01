structure RegAlloc :> RegAlloc =
struct

open MipsData;

(* Funktioner, der implementerer mængder af strings *)

val emptyset = []

fun addset (a:string) [] = [a]
  | addset a (b :: l) =
      if a<b then a :: b :: l
      else if a=b then b :: l
      else b :: addset a l

fun addsetL [] s = s
  | addsetL (a :: l) s = addset a (addsetL l s)

fun union [] l2 = l2
  | union (a::l1) l2 = addset a (union l1 l2)

fun remove (a:string) [] = []
  | remove a (b :: l)  =
      if a<b then b :: l
      else if a=b then l
      else b :: remove a l

fun setdiff l1 [] = l1
  | setdiff l1 (a::l2) = remove a (setdiff l1 l2)

fun member (a:string) [] = false
  | member a (b :: l)  =
      if a<b then false
      else if a=b then true
      else member a l

fun intersect [] l2 = []
  | intersect (a::l1) l2 =
      if member a l2 then a :: intersect l1 l2
      else intersect l1 l2

fun zip [] _ = []
  | zip _ [] = []
  | zip (a :: aas) (b :: bs) = (a,b) :: zip aas bs

fun destRegs [] = []
  | destRegs (i::ilist) = union (destReg i) (destRegs ilist)

and destReg i =
  case i of
    LABEL l => emptyset
  | ASSERT s => emptyset
  | ORG s => emptyset
  | EQU (l,s) => emptyset
  | EQUR (l,r) => emptyset
  | END => emptyset
  | DC vs => emptyset
  | DS s => emptyset
  | DSRND (n,m) => emptyset
  | COMMENT s => emptyset
  | NOP => emptyset
  | LUI (rt,v) => addset rt emptyset
  | ADD (rd,rs,rt) => addset rd emptyset
  | ADDI (rd,rs,v) => addset rd emptyset
  | SUB (rd,rs,rt) => addset rd emptyset
  | AND (rd,rs,rt) => addset rd emptyset
  | ANDI (rd,rs,v) => addset rd emptyset
  | OR (rd,rs,rt) => addset rd emptyset
  | ORI (rd,rs,v) => addset rd emptyset
  | SLT (rd,rs,rt) => addset rd emptyset
  | SLTI (rd,rs,v) => addset rd emptyset
  | BEQ (rs,rt,v) => emptyset
  | BNE (rs,rt,v) => emptyset
  | J lab => emptyset
  | JAL (lab,argRegs) => argRegs
  | JR r => emptyset
  | LW (rd,rs,v) => addset rd emptyset
  | SW (rd,rs,v) => emptyset
  | STOP => emptyset

fun live_step ilist llist =
  let fun scan [] = []
        | scan (i::is) =
	    let val ls1 = scan is
	    in if null ls1 then [instruct i emptyset]
	       else instruct i (hd ls1) :: ls1
	    end
      and instruct i live =
	    case i of	      
              LABEL l => live
            | ASSERT s => live
            | ORG s => live
            | EQU (l,s) => live
            | EQUR (l,r) => live
            | END => live
            | DC vs => live
            | DS s => live
            | DSRND (n,m) =>  live
            | COMMENT s => live
            | NOP => live
            | LUI (rt,v) => remove rt live
            | ADD (rd,rs,rt) => addsetL [rs,rt] (remove rd live)
            | ADDI (rd,rs,v) => addset rs (remove rd live)
            | SUB (rd,rs,rt) => addsetL [rs,rt] (remove rd live)
            | AND (rd,rs,rt) => addsetL [rs,rt] (remove rd live)
            | ANDI (rd,rs,v) => addset rs (remove rd live)
            | OR (rd,rs,rt) => addsetL [rs,rt] (remove rd live)
            | ORI (rd,rs,v) => addset rs (remove rd live)
            | SLT (rd,rs,rt) => addsetL [rs,rt] (remove rd live)
            | SLTI (rd,rs,v) => addset rs (remove rd live)
            | BEQ (rs,rt,v) => addsetL [rs,rt] (union live (live_at v))
            | BNE (rs,rt,v) => addsetL [rs,rt] (union live (live_at v))
            | J lab => live_at lab
            | JAL (lab,argRegs) => union argRegs live
            | JR r => addset r emptyset
		(* Antag JR kun bruges som return og at alle variabler *)
		(* er i lager eller nummererede registre ved kald      *)
            | LW (rd,rs,v) => addset rs (remove rd live)
            | SW (rd,rs,v) => addsetL [rs,rd] live
            | STOP => emptyset
      and live_at lab = search ilist llist lab
      and search [] [] lab = emptyset
        | search (LABEL k :: is) (l :: ls) lab =
	    if k = lab then l else search is ls lab
        | search (_ :: is) (_ :: ls) lab = search is ls lab
	| search a b l = search a b l (* shouldn't happen *)
  in scan ilist
  end

fun iterate_live ilist llist =
  let val llist1 = live_step ilist llist
  in if llist1 = llist then llist
     else iterate_live ilist llist1
  end

fun init_list [] = []
  | init_list (i::is) = emptyset :: init_list is

(* live_regs finder for hver instruktion de symbolske registernavne, *)
(* der er levende FØR denne instruktion er udført.                   *)

fun live_regs ilist =
      iterate_live ilist (init_list ilist)

fun regs [] rs = rs
  | regs (l :: llist) rs = union l (regs llist rs)

fun findRegs llist = filterSymbolic (regs llist [])

and filterSymbolic [] = []
  | filterSymbolic (a::l) =
      if numerical a then filterSymbolic l
      else a :: filterSymbolic l

(* conflicts llist r finder de registre, *)
(* der interfererer med r                *)

fun conflicts [] [] callerSaves live1 r =
      let val con1 = if numerical r then remove r callerSaves else []
          val con2 = if member r live1 then remove r live1 else []
      in
        union con1 con2
      end
  | conflicts (ORI (rd,rs,"0") :: ilist) (l :: llist) callerSaves live1 r =
      if r=rd
      then union (remove rs (remove r l))
		 (conflicts ilist llist callerSaves live1 r)
      else if r=rs
      then conflicts ilist llist callerSaves live1 r
      else if member r l
      then union [rd] (conflicts ilist llist callerSaves live1 r)
      else conflicts ilist llist callerSaves live1 r
  | conflicts (JAL (f,argRegs) :: ilist) (l :: llist) callerSaves live1 r =
      if (member r l)  (* Function calls interfere with caller-saves *)
      then union (remove r callerSaves)
		 (conflicts ilist llist callerSaves live1 r)
      else if member r callerSaves
      then union (remove r l)
		 (conflicts ilist llist callerSaves live1 r)
      else conflicts ilist llist callerSaves live1 r
  | conflicts (i :: ilist) (l :: llist) callerSaves live1 r =
      if (member r (destReg i))
      then union (remove r l)
		 (conflicts ilist llist callerSaves live1 r)
      else if member r l
      then union (destReg i)
		 (conflicts ilist llist callerSaves live1 r)
      else conflicts ilist llist callerSaves live1 r

(* En graf repræsenteres som en liste af registre *)
(* parret med deres konflikter                    *)

fun graph ilist llist callerSaves =
  let val rs = callerSaves @ findRegs llist
  in
    zip rs (map (conflicts ilist ((tl llist)@[[]]) callerSaves (hd llist)) rs)
  end

(* finder move-relaterede registre *)

fun findMoves ilist llist =
  let val rs = findRegs llist
  in
    zip rs (map (findMoves1 ilist) rs)
  end

and findMoves1 [] r = []
  | findMoves1 (ORI (rd,rs,"0") :: ilist) r =
      union (if rd=r then [rs]
             else if rs=r then [rd]
             else [])
	    (findMoves1 ilist r)
  | findMoves1 (i :: ilist) r = findMoves1 ilist r

(* sorter efter antallet af konflikter,
   dog med numeriske knuder til sidst   *)

fun sortByOrder [] = []
  | sortByOrder (g : (string * 'b list) list) =
     let fun split [] = ([],[])
	   | split (a::g) =
               let val (l,g1) = ascending a g []
                   val (g2,g3) = split g1
               in (rev2 l g3, g2) end
         and ascending a [] l = (a::l,[])
           | ascending a (g as (b::g1)) l =
               if numerical (#1 b)
	          orelse not (numerical (#1 a))
		  andalso length (#2 a) <= length (#2 b)
               then ascending b g1 (a::l)
               else (a::l,g)
         and rev2 [] l2 = l2
           | rev2 (a::l1) l2 = rev2 l1 (a::l2)
         fun merge [] l2 = l2
           | merge l1 [] = l1
           | merge (l1 as (a::r1)) (l2 as (b::r2)) =
               if numerical (#1 b)
		  orelse not (numerical (#1 a))
		  andalso length (#2 a) <= length (#2 b)
               then a :: merge r1 l2
               else b :: merge l1 r2
         val (g1,g2) = split g
     in 
       if null g1 then g2
       else if null g2 then g1
       else merge (sortByOrder g1) (sortByOrder g2)
     end

(* n-farv grafen ved brug af Briggs algoritme *)

exception not_colourable

fun colourGraph g rmin rmax moveRelated =
  select (simplify (sortByOrder g) []) (mList rmin rmax) moveRelated []

and simplify [] l = l
  | simplify ((a as (r,c)) :: g) l =
      simplify (sortByOrder (removeNode r g)) (a::l)

and removeNode r [] = []
  | removeNode r ((r1,c)::g) =
      (r1,remove r c) :: removeNode r g

and select [] regs moveRelated sl = sl
  | select ((r,c)::l) regs moveRelated sl =
      let val rnum = 
	       if numerical r then r
               else let val possible = NotIn c sl regs
			val related = lookUp2 r moveRelated
			val related2 = map (fn r=>lookUp r sl) related
		        val mPossible = intersect possible related2
		    in
	              if null possible then raise not_colourable
		      else if null mPossible then hd possible
		      else hd mPossible
		    end
      in
        select l regs moveRelated ((r,rnum)::sl)
      end

and NotIn [] sl regs = regs
  | NotIn (r::cs) sl regs =
      NotIn cs sl (delete (lookUp r sl) regs)

and lookUp r [] = "0"
  | lookUp r ((r1,n)::sl) =
      if numerical r then r
      else if r=r1 then n else lookUp r sl

and lookUp2 r [] = []
  | lookUp2 r ((r1,ms)::sl) =
      if r=r1 then ms else lookUp2 r sl

and delete x [] = []
  | delete x (y::l) = if x=y then delete x l else y :: delete x l

and mList m n =
  if m > n then []
  else makestring m :: mList (m+1) n

fun filterNullMoves [] allocs = []
  | filterNullMoves (ORI (rd,rs,"0") :: ilist) allocs =
      let val rd1 = lookUp rd allocs
          val rs1 = lookUp rs allocs
      in
        if rd1 = rs1 orelse rd1 = "0"
	then COMMENT ("Nulled: ori "^rd^","^rs^",0")
	     :: filterNullMoves ilist allocs
        else ORI (rd,rs,"0") :: filterNullMoves ilist allocs
      end
  | filterNullMoves (i :: ilist) allocs =
      i :: filterNullMoves ilist allocs

fun insertLive [] [] = []
  | insertLive (i :: ilist) (l :: llist) =
      [COMMENT ("\t\tLive: "^printList l), i] @ insertLive ilist llist

and printList [] = ""
  | printList (r :: rs) = r^" "^ printList rs

fun printGraph [] = []
  | printGraph ((r,rs) :: g) =
     [COMMENT ("interferes: "^r^" with "^printList rs)]
     @ printGraph g
		  
fun registerAlloc ilist rmin callerMax rmax =
  let val llist = live_regs ilist
      val callerSaves = mList rmin callerMax
      val iGraph = graph ilist llist callerSaves
      val moveRelated = findMoves ilist llist
      val allocs = colourGraph iGraph rmin rmax moveRelated
      val deadRegs = setdiff (filterSymbolic (destRegs ilist))
		             (map (#1) allocs)
      val allocs1 = allocs @ (map (fn r => (r,"0")) deadRegs)
      val ilist1 = filterNullMoves ilist allocs1
   (* val ilist2 = insertLive ilist1 llist *)
  in
    (makeEqur allocs1, ilist1, hd llist, maxreg allocs 0)
  end

and makeEqur [] = []
  | makeEqur ((r,n)::al) =
      if numerical r then makeEqur al
      else EQUR (r,n) :: makeEqur al

and maxreg [] m = m
  | maxreg ((r,n)::rs) m = 
      maxreg rs (if m< intOfString n then intOfString n else m)

end
