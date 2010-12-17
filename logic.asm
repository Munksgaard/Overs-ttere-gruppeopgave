	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $0, 2
# was:	ori	_tuple1__85_, 0, 2
	sw	$2, 0($28)
# was:	sw	_tuple1__85_, 0(28)
	ori	$2, $0, 3
# was:	ori	_tuple1__86_, 0, 3
	sw	$2, 4($28)
# was:	sw	_tuple1__86_, 4(28)
	addi	$2, $28, 0
# was:	addi	_apply__84_, 28, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	2,_apply__84_,0
	jal	test1
# was:	jal	test1, 2
# 	ori	_tuple1__83_,2,0
	sw	$2, 0($28)
# was:	sw	_tuple1__83_, 0(28)
	ori	$2, $0, 2
# was:	ori	_tuple1__89_, 0, 2
	sw	$2, 0($28)
# was:	sw	_tuple1__89_, 0(28)
	ori	$2, $0, 3
# was:	ori	_tuple1__90_, 0, 3
	sw	$2, 4($28)
# was:	sw	_tuple1__90_, 4(28)
	addi	$2, $28, 0
# was:	addi	_apply__88_, 28, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	2,_apply__88_,0
	jal	test2
# was:	jal	test2, 2
# 	ori	_tuple1__87_,2,0
	sw	$2, 4($28)
# was:	sw	_tuple1__87_, 4(28)
	ori	$2, $0, 3
# was:	ori	_tuple1__93_, 0, 3
	sw	$2, 0($28)
# was:	sw	_tuple1__93_, 0(28)
	ori	$2, $0, 2
# was:	ori	_tuple1__94_, 0, 2
	sw	$2, 4($28)
# was:	sw	_tuple1__94_, 4(28)
	addi	$2, $28, 0
# was:	addi	_apply__92_, 28, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	2,_apply__92_,0
	jal	test1
# was:	jal	test1, 2
# 	ori	_tuple1__91_,2,0
	sw	$2, 8($28)
# was:	sw	_tuple1__91_, 8(28)
	ori	$2, $0, 3
# was:	ori	_tuple1__97_, 0, 3
	sw	$2, 0($28)
# was:	sw	_tuple1__97_, 0(28)
	ori	$2, $0, 2
# was:	ori	_tuple1__98_, 0, 2
	sw	$2, 4($28)
# was:	sw	_tuple1__98_, 4(28)
	addi	$2, $28, 0
# was:	addi	_apply__96_, 28, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	2,_apply__96_,0
	jal	test2
# was:	jal	test2, 2
# 	ori	_tuple1__95_,2,0
	sw	$2, 12($28)
# was:	sw	_tuple1__95_, 12(28)
	ori	$2, $0, 2
# was:	ori	_tuple1__101_, 0, 2
	sw	$2, 0($28)
# was:	sw	_tuple1__101_, 0(28)
	ori	$2, $0, 2
# was:	ori	_tuple1__102_, 0, 2
	sw	$2, 4($28)
# was:	sw	_tuple1__102_, 4(28)
	addi	$2, $28, 0
# was:	addi	_apply__100_, 28, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	2,_apply__100_,0
	jal	test1
# was:	jal	test1, 2
# 	ori	_tuple1__99_,2,0
	sw	$2, 16($28)
# was:	sw	_tuple1__99_, 16(28)
	ori	$2, $0, 2
# was:	ori	_tuple1__105_, 0, 2
	sw	$2, 0($28)
# was:	sw	_tuple1__105_, 0(28)
	ori	$2, $0, 2
# was:	ori	_tuple1__106_, 0, 2
	sw	$2, 4($28)
# was:	sw	_tuple1__106_, 4(28)
	addi	$2, $28, 0
# was:	addi	_apply__104_, 28, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	2,_apply__104_,0
	jal	test2
# was:	jal	test2, 2
# 	ori	_tuple1__103_,2,0
	sw	$2, 20($28)
# was:	sw	_tuple1__103_, 20(28)
	addi	$0, $28, 0
# was:	addi	dead, 28, 0
	addi	$28, $28, 24
# was:	addi	28, 28, 24
	j	_stop_
# 
show:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	show_arg__1_,2,0
	lw	$3, 0($2)
# was:	lw	_patTuple__6_, 0(show_arg__1_)
# 	ori	_patVar_b__7_,_patTuple__6_,0
	lw	$6, 4($2)
# was:	lw	_patTuple__8_, 4(show_arg__1_)
# 	ori	_patVar_n__9_,_patTuple__8_,0
# 	ori	_dec__13_,_patVar_n__9_,0
	ori	$4, $6, 0
# was:	ori	4, _dec__13_, 0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
# 	ori	_patVar_t__14_,_dec__13_,0
	ori	$2, $3, 0
# was:	ori	show_res__2_, _patVar_b__7_, 0
	j	show_return__3_
_match__5_:
	j	show_fail__4_
show_return__3_:
# 	ori	2,show_res__2_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
show_fail__4_:
	ori	$5, $0, 10
	j	_Error_
# 
test1:
	sw	$31, -4($29)
	sw	$18, -16($29)
	sw	$17, -12($29)
	sw	$16, -8($29)
	addi	$29, $29, -20
# 	ori	test1_arg__15_,2,0
	lw	$16, 0($2)
# was:	lw	_patTuple__20_, 0(test1_arg__15_)
# 	ori	_patVar_x__21_,_patTuple__20_,0
	lw	$17, 4($2)
# was:	lw	_patTuple__22_, 4(test1_arg__15_)
# 	ori	_patVar_y__23_,_patTuple__22_,0
# 	ori	_less1__31_,_patVar_x__21_,0
# 	ori	_less2__32_,_patVar_y__23_,0
	lui	$18, 0
# was:	lui	_and1__29_, 0
	slt	$18, $16, $17
# was:	slt	_and1__29_, _less1__31_, _less2__32_
# 	ori	_equal1__37_,_patVar_x__21_,0
# 	ori	_equal2__38_,_patVar_y__23_,0
	bne	$16, $17, _equallabel1__39_
# was:	bne	_equal1__37_, _equal2__38_, _equallabel1__39_
	ori	$2, $0, 1
# was:	ori	_tuple1__36_, 0, 1
	j	_equallabel2__40_
_equallabel1__39_:
	ori	$2, $0, 0
# was:	ori	_tuple1__36_, 0, 0
_equallabel2__40_:
	sw	$2, 0($28)
# was:	sw	_tuple1__36_, 0(28)
	ori	$2, $0, 11
# was:	ori	_tuple1__41_, 0, 11
	sw	$2, 4($28)
# was:	sw	_tuple1__41_, 4(28)
	addi	$2, $28, 0
# was:	addi	_apply__35_, 28, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	2,_apply__35_,0
	jal	show
# was:	jal	show, 2
# 	ori	_and2__30_,2,0
	and	$18, $18, $2
# was:	and	_or1__27_, _and1__29_, _and2__30_
# 	ori	_less1__44_,_patVar_y__23_,0
# 	ori	_less2__45_,_patVar_x__21_,0
	lui	$2, 0
# was:	lui	_tuple1__43_, 0
	slt	$2, $17, $16
# was:	slt	_tuple1__43_, _less1__44_, _less2__45_
	sw	$2, 0($28)
# was:	sw	_tuple1__43_, 0(28)
	ori	$2, $0, 12
# was:	ori	_tuple1__48_, 0, 12
	sw	$2, 4($28)
# was:	sw	_tuple1__48_, 4(28)
	addi	$2, $28, 0
# was:	addi	_apply__42_, 28, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	2,_apply__42_,0
	jal	show
# was:	jal	show, 2
# 	ori	_or2__28_,2,0
	or	$2, $18, $2
# was:	or	_if__24_, _or1__27_, _or2__28_
	beq	$2, $0, _elselabel__25_
# was:	beq	_if__24_, 0, _elselabel__25_
	ori	$3, $0, 13
# was:	ori	test1_res__16_, 0, 13
	ori	$4, $3, 0
# was:	ori	4, test1_res__16_, 0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
	j	_exitlabel__26_
_elselabel__25_:
	ori	$3, $0, 14
# was:	ori	test1_res__16_, 0, 14
	ori	$4, $3, 0
# was:	ori	4, test1_res__16_, 0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
_exitlabel__26_:
	j	test1_return__17_
_match__19_:
	j	test1_fail__18_
test1_return__17_:
	ori	$2, $3, 0
# was:	ori	2, test1_res__16_, 0
	addi	$29, $29, 20
	lw	$18, -16($29)
	lw	$17, -12($29)
	lw	$16, -8($29)
	lw	$31, -4($29)
	jr	$31
test1_fail__18_:
	ori	$5, $0, 14
	j	_Error_
# 
test2:
	sw	$31, -4($29)
	sw	$19, -20($29)
	sw	$18, -16($29)
	sw	$17, -12($29)
	sw	$16, -8($29)
	addi	$29, $29, -24
# 	ori	test2_arg__49_,2,0
	lw	$18, 0($2)
# was:	lw	_patTuple__54_, 0(test2_arg__49_)
# 	ori	_patVar_x__55_,_patTuple__54_,0
	lw	$19, 4($2)
# was:	lw	_patTuple__56_, 4(test2_arg__49_)
# 	ori	_patVar_y__57_,_patTuple__56_,0
# 	ori	_less1__63_,_patVar_x__55_,0
# 	ori	_less2__64_,_patVar_y__57_,0
	lui	$16, 0
# was:	lui	_or1__61_, 0
	slt	$16, $18, $19
# was:	slt	_or1__61_, _less1__63_, _less2__64_
# 	ori	_equal1__71_,_patVar_x__55_,0
# 	ori	_equal2__72_,_patVar_y__57_,0
	bne	$18, $19, _equallabel1__73_
# was:	bne	_equal1__71_, _equal2__72_, _equallabel1__73_
	ori	$2, $0, 1
# was:	ori	_tuple1__70_, 0, 1
	j	_equallabel2__74_
_equallabel1__73_:
	ori	$2, $0, 0
# was:	ori	_tuple1__70_, 0, 0
_equallabel2__74_:
	sw	$2, 0($28)
# was:	sw	_tuple1__70_, 0(28)
	ori	$2, $0, 21
# was:	ori	_tuple1__75_, 0, 21
	sw	$2, 4($28)
# was:	sw	_tuple1__75_, 4(28)
	addi	$2, $28, 0
# was:	addi	_apply__69_, 28, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	2,_apply__69_,0
	jal	show
# was:	jal	show, 2
	ori	$17, $2, 0
# was:	ori	_and1__67_, 2, 0
# 	ori	_less1__78_,_patVar_y__57_,0
# 	ori	_less2__79_,_patVar_x__55_,0
	lui	$2, 0
# was:	lui	_tuple1__77_, 0
	slt	$2, $19, $18
# was:	slt	_tuple1__77_, _less1__78_, _less2__79_
	sw	$2, 0($28)
# was:	sw	_tuple1__77_, 0(28)
	ori	$2, $0, 22
# was:	ori	_tuple1__82_, 0, 22
	sw	$2, 4($28)
# was:	sw	_tuple1__82_, 4(28)
	addi	$2, $28, 0
# was:	addi	_apply__76_, 28, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	2,_apply__76_,0
	jal	show
# was:	jal	show, 2
# 	ori	_and2__68_,2,0
	and	$2, $17, $2
# was:	and	_or2__62_, _and1__67_, _and2__68_
	or	$2, $16, $2
# was:	or	_if__58_, _or1__61_, _or2__62_
	beq	$2, $0, _elselabel__59_
# was:	beq	_if__58_, 0, _elselabel__59_
	ori	$3, $0, 23
# was:	ori	test2_res__50_, 0, 23
	ori	$4, $3, 0
# was:	ori	4, test2_res__50_, 0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
	j	_exitlabel__60_
_elselabel__59_:
	ori	$3, $0, 24
# was:	ori	test2_res__50_, 0, 24
	ori	$4, $3, 0
# was:	ori	4, test2_res__50_, 0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
_exitlabel__60_:
	j	test2_return__51_
_match__53_:
	j	test2_fail__52_
test2_return__51_:
	ori	$2, $3, 0
# was:	ori	2, test2_res__50_, 0
	addi	$29, $29, 24
	lw	$19, -20($29)
	lw	$18, -16($29)
	lw	$17, -12($29)
	lw	$16, -8($29)
	lw	$31, -4($29)
	jr	$31
test2_fail__52_:
	ori	$5, $0, 20
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
