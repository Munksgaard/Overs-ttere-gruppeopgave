	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $0, 5
# was:	ori	2, 0, 5
	syscall
# 	ori	_apply__31_,2,0
# 	ori	2,_apply__31_,0
	jal	readList
# was:	jal	readList, 2
# 	ori	_apply__30_,2,0
# 	ori	2,_apply__30_,0
	jal	printList
# was:	jal	printList, 2
# 	ori	dead,2,0
	j	_stop_
# 
readList:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	readList_arg__1_,2,0
	ori	$3, $0, 0
# was:	ori	_constPat__6_, 0, 0
	bne	$2, $3, _match__5_
# was:	bne	readList_arg__1_, _constPat__6_, _match__5_
	ori	$2, $0, 0
# was:	ori	readList_res__2_, 0, 0
	j	readList_return__3_
_match__5_:
	ori	$3, $2, 0
# was:	ori	_patVar_n__8_, readList_arg__1_, 0
# 	ori	_minus1__12_,_patVar_n__8_,0
	ori	$2, $0, 1
# was:	ori	_minus2__13_, 0, 1
	sub	$2, $3, $2
# was:	sub	_apply__11_, _minus1__12_, _minus2__13_
# 	ori	2,_apply__11_,0
	jal	readList
# was:	jal	readList, 2
# 	ori	_tuple1_4__10_,2,0
	sw	$2, 4($28)
# was:	sw	_tuple1_4__10_, 4(28)
	ori	$2, $0, 5
# was:	ori	2, 0, 5
	syscall
# 	ori	_tuple1_0__9_,2,0
	sw	$2, 0($28)
# was:	sw	_tuple1_0__9_, 0(28)
	addi	$2, $28, 0
# was:	addi	readList_res__2_, 28, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
	j	readList_return__3_
_match__7_:
	j	readList_fail__4_
readList_return__3_:
# 	ori	2,readList_res__2_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
readList_fail__4_:
	ori	$5, $0, 6
	j	_Error_
# 
printList:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	printList_arg__14_,2,0
	bne	$2, $0, _match__18_
# was:	bne	printList_arg__14_, 0, _match__18_
	ori	$2, $0, 1
# was:	ori	printList_res__15_, 0, 1
	j	printList_return__16_
_match__18_:
	beq	$2, $0, _match__19_
# was:	beq	printList_arg__14_, 0, _match__19_
	lw	$6, 0($2)
# was:	lw	_patTuple__20_, 0(printList_arg__14_)
# 	ori	_patVar_n__21_,_patTuple__20_,0
	lw	$3, 4($2)
# was:	lw	_patTuple__22_, 4(printList_arg__14_)
# 	ori	_patVar_l__23_,_patTuple__22_,0
# 	ori	_dec__27_,_patVar_n__21_,0
	ori	$4, $6, 0
# was:	ori	4, _dec__27_, 0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
# 	ori	_patVar_t__28_,_dec__27_,0
	ori	$2, $3, 0
# was:	ori	_apply__29_, _patVar_l__23_, 0
# 	ori	2,_apply__29_,0
	jal	printList
# was:	jal	printList, 2
# 	ori	printList_res__15_,2,0
	j	printList_return__16_
_match__19_:
	j	printList_fail__17_
printList_return__16_:
# 	ori	2,printList_res__15_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
printList_fail__17_:
	ori	$5, $0, 11
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
