
(* mips svarer til den delmængde af MIPS instruktionssættet, *)
(* som er understøttet af Maz Sporks MASM assembler,         *)
(* inklusive de fleste pesudoordrer og direktiver            *)

datatype mips
 = LABEL of string
 | ASSERT of string
 | ORG of string
 | EQU of string*string
 | EQUR of string*string
 | END
 | NOP
 | DC of string list
 | DS of string
 | DSRND of string*string
 | COMMENT of string
 | LUI of string*string
 | ADD of string*string*string
 | ADDI of string*string*string
 | SUB of string*string*string
 | AND of string*string*string
 | ANDI of string*string*string
 | OR of string*string*string
 | ORI of string*string*string
 | SLT of string*string*string
 | SLTI of string*string*string
 | BEQ of string*string*string
 | BNE of string*string*string
 | J of string
 | JAL of string * string list (* label + argumentregistre *)
 | JR of string
 | LW of string*string*string (* lw rd,i(rs) kodes som LW (rd,rs,i) *)
 | SW of string*string*string (* sw rd,i(rs) kodes som SW (rd,rs,i) *)
 | STOP

fun MOVE (rd,rs) = ORI (rd,rs,"0")

fun LI (rd,v) = ADDI (rd,"0",v)

fun SUBI (rd,rs,v) = ADDI (rd,rs,"-(" ^ v ^ ")")

fun pp_list [] = ""
  | pp_list [v] = v
  | pp_list (v::vs) = v ^ ", " ^ pp_list vs

fun pp_mips inst
 = case inst of
     LABEL l => l ^ ":"
   | ASSERT s => "\t assert\t" ^ s
   | ORG s => "\t org\t" ^ s
   | EQU (l,s) => l ^ "\t equ\t" ^ s
   | EQUR (l,r) => l ^ "\t equr\t$" ^ r
   | END => "\t end"
   | DC vs => "\t dc\t" ^ pp_list vs
   | DS s => "\t ds\t" ^ s
   | DSRND (n,m) =>  "\t dsrnd\t" ^ n ^ ", " ^ m
   | COMMENT s => "; " ^ s
   | NOP => "\t nop"
   | LUI (rt,v) => "\t lui\t" ^ pp_reg rt ^ ", " ^ v
   | ADD (rd,rs,rt) => "\t add\t" ^ pp_reg rd ^ ", " ^ pp_reg rs ^ ", " ^ pp_reg rt
   | ADDI (rd,rs,v) => "\t addi\t" ^ pp_reg rd ^ ", " ^ pp_reg rs ^ ", " ^ v
   | SUB (rd,rs,rt) => "\t sub\t" ^ pp_reg rd ^ ", " ^ pp_reg rs ^ ", " ^ pp_reg rt
   | AND (rd,rs,rt) => "\t and\t" ^ pp_reg rd ^ ", " ^ pp_reg rs ^ ", " ^ pp_reg rt
   | ANDI (rd,rs,v) => "\t andi\t" ^ pp_reg rd ^ ", " ^ pp_reg rs ^ ", " ^ v
   | OR (rd,rs,rt) => "\t or\t" ^ pp_reg rd ^ ", " ^ pp_reg rs ^ ", " ^ pp_reg rt
   | ORI (rd,rs,v) => "\t ori\t" ^ pp_reg rd ^ ", " ^ pp_reg rs ^ ", " ^ v
   | SLT (rd,rs,rt) => "\t slt\t" ^ pp_reg rd ^ ", " ^ pp_reg rs ^ ", " ^ pp_reg rt
   | SLTI (rd,rs,v) => "\t slti\t" ^ pp_reg rd ^ ", " ^ pp_reg rs ^ ", " ^ v
   | BEQ (rs,rt,v) => "\t beq\t" ^ pp_reg rs ^ ", " ^ pp_reg rt ^ ", " ^ v
   | BNE (rs,rt,v) => "\t bne\t" ^ pp_reg rs ^ ", " ^ pp_reg rt ^ ", " ^ v
   | J l => "\t j\t" ^ l
   | JAL (l,argRegs) => "\t jal\t" ^ l
   | JR r => "\t jr\t" ^ pp_reg r
   | LW (rd,rs,v) => "\t lw\t" ^ pp_reg rd ^ ", " ^ v ^ "(" ^ pp_reg rs ^ ")"
   | SW (rd,rs,v) => "\t sw\t" ^ pp_reg rd ^ ", " ^ v ^ "(" ^ pp_reg rs ^ ")"
   | STOP => "\t stop"

and pp_reg r =
  if numerical r then "$" ^ r else ":" ^ r

and numerical s =
  foldl (fn (c,i) => i andalso ord c >= ord #"0" andalso ord c <= ord #"9")
        true (explode s)

and intOfString s =
  foldl ( fn (c,i) => 10*i + ord c- ord #"0" ) 0 (explode s)

(* pp_mips_list udskriver en liste af instruktioner, *)
(* så de kan læses af MASM assembleren *)

and pp_mips_list [] = ""
  | pp_mips_list (i::is) = pp_mips i ^ "\n" ^ pp_mips_list is
