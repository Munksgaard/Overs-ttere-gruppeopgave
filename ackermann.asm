	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	addi	$3, $28, 0
# was:	addi	_compileTupleMem__74_, 28, 0
	addi	$6, $3, 0
# was:	addi	_apply__73_, _compileTupleMem__74_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
	ori	$2, $0, 5
# was:	ori	2, 0, 5
	syscall
# 	ori	_compileTuple1__76_,2,0
	sw	$2, 0($3)
# was:	sw	_compileTuple1__76_, 0(_compileTupleMem__74_)
	addi	$3, $3, 4
# was:	addi	_compileTupleMem__74_, _compileTupleMem__74_, 4
	ori	$2, $0, 5
# was:	ori	2, 0, 5
	syscall
# 	ori	_compileTuple1__78_,2,0
	sw	$2, 0($3)
# was:	sw	_compileTuple1__78_, 0(_compileTupleMem__74_)
	addi	$3, $3, 4
# was:	addi	_compileTupleMem__74_, _compileTupleMem__74_, 4
	ori	$2, $6, 0
# was:	ori	2, _apply__73_, 0
	jal	ackermann
# was:	jal	ackermann, 2
# 	ori	dead,2,0
	ori	$4, $2, 0
# was:	ori	4, dead, 0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
	j	_stop_
# 
ackermann:
	sw	$31, -4($29)
	sw	$17, -12($29)
	sw	$16, -8($29)
	addi	$29, $29, -16
# 	ori	ackermann_arg__1_,2,0
	beq	$2, $0, _match__5_
# was:	beq	ackermann_arg__1_, 0, _match__5_
	lw	$3, 0($2)
# was:	lw	_patTuple__6_, 0(ackermann_arg__1_)
# 	ori	_patVar_m__7_,_patTuple__6_,0
	lw	$2, 4($2)
# was:	lw	_patTuple__8_, 4(ackermann_arg__1_)
# 	ori	_patVar_n__9_,_patTuple__8_,0
	addi	$4, $28, 0
# was:	addi	_compileTupleMem__14_, 28, 0
	addi	$5, $4, 0
# was:	addi	_case1__10_, _compileTupleMem__14_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_equal1__18_,_patVar_m__7_,0
	ori	$6, $0, 0
# was:	ori	_equal2__19_, 0, 0
	bne	$3, $6, _equallabel1__20_
# was:	bne	_equal1__18_, _equal2__19_, _equallabel1__20_
	ori	$6, $0, 1
# was:	ori	_compileTuple1__16_, 0, 1
	j	_equallabel2__21_
_equallabel1__20_:
	ori	$6, $0, 0
# was:	ori	_compileTuple1__16_, 0, 0
_equallabel2__21_:
	sw	$6, 0($4)
# was:	sw	_compileTuple1__16_, 0(_compileTupleMem__14_)
	addi	$4, $4, 4
# was:	addi	_compileTupleMem__14_, _compileTupleMem__14_, 4
# 	ori	_equal1__24_,_patVar_n__9_,0
	ori	$6, $0, 0
# was:	ori	_equal2__25_, 0, 0
	bne	$2, $6, _equallabel1__26_
# was:	bne	_equal1__24_, _equal2__25_, _equallabel1__26_
	ori	$6, $0, 1
# was:	ori	_compileTuple1__22_, 0, 1
	j	_equallabel2__27_
_equallabel1__26_:
	ori	$6, $0, 0
# was:	ori	_compileTuple1__22_, 0, 0
_equallabel2__27_:
	sw	$6, 0($4)
# was:	sw	_compileTuple1__22_, 0(_compileTupleMem__14_)
	addi	$4, $4, 4
# was:	addi	_compileTupleMem__14_, _compileTupleMem__14_, 4
	beq	$5, $0, _match__28_
# was:	beq	_case1__10_, 0, _match__28_
	lw	$6, 0($5)
# was:	lw	_patTuple__29_, 0(_case1__10_)
	ori	$4, $0, 1
# was:	ori	_constPat__30_, 0, 1
	bne	$6, $4, _match__28_
# was:	bne	_patTuple__29_, _constPat__30_, _match__28_
	lw	$6, 4($5)
# was:	lw	_patTuple__31_, 4(_case1__10_)
	ori	$4, $0, 1
# was:	ori	_constPat__32_, 0, 1
	bne	$6, $4, _match__28_
# was:	bne	_patTuple__31_, _constPat__32_, _match__28_
	ori	$2, $0, 1
# was:	ori	ackermann_res__2_, 0, 1
	j	_caseendlabel__13_
_match__28_:
	beq	$5, $0, _match__33_
# was:	beq	_case1__10_, 0, _match__33_
	lw	$6, 0($5)
# was:	lw	_patTuple__34_, 0(_case1__10_)
	ori	$4, $0, 1
# was:	ori	_constPat__35_, 0, 1
	bne	$6, $4, _match__33_
# was:	bne	_patTuple__34_, _constPat__35_, _match__33_
	lw	$4, 4($5)
# was:	lw	_patTuple__36_, 4(_case1__10_)
	bne	$4, $0, _match__33_
# was:	bne	_patTuple__36_, 0, _match__33_
# 	ori	_plus1__37_,_patVar_n__9_,0
	ori	$3, $0, 1
# was:	ori	_plus2__38_, 0, 1
	add	$2, $2, $3
# was:	add	ackermann_res__2_, _plus1__37_, _plus2__38_
	j	_caseendlabel__13_
_match__33_:
	beq	$5, $0, _match__39_
# was:	beq	_case1__10_, 0, _match__39_
	lw	$4, 0($5)
# was:	lw	_patTuple__40_, 0(_case1__10_)
	bne	$4, $0, _match__39_
# was:	bne	_patTuple__40_, 0, _match__39_
	lw	$4, 4($5)
# was:	lw	_patTuple__41_, 4(_case1__10_)
	bne	$4, $0, _match__39_
# was:	bne	_patTuple__41_, 0, _match__39_
	addi	$17, $28, 0
# was:	addi	_compileTupleMem__43_, 28, 0
	addi	$16, $17, 0
# was:	addi	_apply__42_, _compileTupleMem__43_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_minus1__47_,_patVar_m__7_,0
	ori	$4, $0, 1
# was:	ori	_minus2__48_, 0, 1
	sub	$4, $3, $4
# was:	sub	_compileTuple1__45_, _minus1__47_, _minus2__48_
	sw	$4, 0($17)
# was:	sw	_compileTuple1__45_, 0(_compileTupleMem__43_)
	addi	$17, $17, 4
# was:	addi	_compileTupleMem__43_, _compileTupleMem__43_, 4
	addi	$4, $28, 0
# was:	addi	_compileTupleMem__52_, 28, 0
	addi	$5, $4, 0
# was:	addi	_apply__51_, _compileTupleMem__52_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__54_,_patVar_m__7_,0
	sw	$3, 0($4)
# was:	sw	_compileTuple1__54_, 0(_compileTupleMem__52_)
	addi	$4, $4, 4
# was:	addi	_compileTupleMem__52_, _compileTupleMem__52_, 4
# 	ori	_minus1__58_,_patVar_n__9_,0
	ori	$3, $0, 1
# was:	ori	_minus2__59_, 0, 1
	sub	$2, $2, $3
# was:	sub	_compileTuple1__56_, _minus1__58_, _minus2__59_
	sw	$2, 0($4)
# was:	sw	_compileTuple1__56_, 0(_compileTupleMem__52_)
	addi	$4, $4, 4
# was:	addi	_compileTupleMem__52_, _compileTupleMem__52_, 4
	ori	$2, $5, 0
# was:	ori	2, _apply__51_, 0
	jal	ackermann
# was:	jal	ackermann, 2
# 	ori	_compileTuple1__49_,2,0
	sw	$2, 0($17)
# was:	sw	_compileTuple1__49_, 0(_compileTupleMem__43_)
	addi	$17, $17, 4
# was:	addi	_compileTupleMem__43_, _compileTupleMem__43_, 4
	ori	$2, $16, 0
# was:	ori	2, _apply__42_, 0
	jal	ackermann
# was:	jal	ackermann, 2
# 	ori	ackermann_res__2_,2,0
	j	_caseendlabel__13_
_match__39_:
	beq	$5, $0, _match__60_
# was:	beq	_case1__10_, 0, _match__60_
	lw	$2, 0($5)
# was:	lw	_patTuple__61_, 0(_case1__10_)
	bne	$2, $0, _match__60_
# was:	bne	_patTuple__61_, 0, _match__60_
	lw	$2, 4($5)
# was:	lw	_patTuple__62_, 4(_case1__10_)
	ori	$4, $0, 1
# was:	ori	_constPat__63_, 0, 1
	bne	$2, $4, _match__60_
# was:	bne	_patTuple__62_, _constPat__63_, _match__60_
	addi	$4, $28, 0
# was:	addi	_compileTupleMem__65_, 28, 0
	addi	$2, $4, 0
# was:	addi	_apply__64_, _compileTupleMem__65_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_minus1__69_,_patVar_m__7_,0
	ori	$5, $0, 1
# was:	ori	_minus2__70_, 0, 1
	sub	$3, $3, $5
# was:	sub	_compileTuple1__67_, _minus1__69_, _minus2__70_
	sw	$3, 0($4)
# was:	sw	_compileTuple1__67_, 0(_compileTupleMem__65_)
	addi	$4, $4, 4
# was:	addi	_compileTupleMem__65_, _compileTupleMem__65_, 4
	ori	$3, $0, 1
# was:	ori	_compileTuple1__71_, 0, 1
	sw	$3, 0($4)
# was:	sw	_compileTuple1__71_, 0(_compileTupleMem__65_)
	addi	$4, $4, 4
# was:	addi	_compileTupleMem__65_, _compileTupleMem__65_, 4
# 	ori	2,_apply__64_,0
	jal	ackermann
# was:	jal	ackermann, 2
# 	ori	ackermann_res__2_,2,0
	j	_caseendlabel__13_
_match__60_:
	j	_casefaillabel__12_
_casefaillabel__12_:
	ori	$5, $0, 11
# was:	ori	5, 0, 11
	j	_Error_
_caseendlabel__13_:
	j	ackermann_return__3_
_match__5_:
	j	ackermann_fail__4_
ackermann_return__3_:
# 	ori	2,ackermann_res__2_,0
	addi	$29, $29, 16
	lw	$17, -12($29)
	lw	$16, -8($29)
	lw	$31, -4($29)
	jr	$31
ackermann_fail__4_:
	ori	$5, $0, 9
	j	_Error_
_stop_:
	ori	$2, $0, 10
	syscall
_Error_:
	la	$4, _ErrorString_
	ori	$2, $0, 4
	syscall
	ori	$4, $5, 0
	ori	$2, $0, 1
	syscall
	la	$4, _cr_
	ori	$2, $0, 4
	syscall
	j	_stop_
	.data	
_cr_:
	.asciiz	"\n"
_ErrorString_:
	.asciiz	"Match failed near line "
	.align	2
_heap_:
	.space	100000
