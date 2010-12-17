	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $0, 5
# was:	ori	2, 0, 5
	syscall
# 	ori	_tuple1__13_,2,0
	sw	$2, 0($28)
# was:	sw	_tuple1__13_, 0(28)
	addi	$2, $28, 0
# was:	addi	_dec__12_, 28, 0
	addi	$28, $28, 4
# was:	addi	28, 28, 4
# 	ori	_patVar_a__14_,_dec__12_,0
# 	ori	_apply__19_,_patVar_a__14_,0
# 	ori	2,_apply__19_,0
	jal	exists
# was:	jal	exists, 2
# 	ori	_not__18_,2,0
	xori	$2, $2, 1
# was:	xori	_if__15_, _not__18_, 1
	beq	$2, $0, _elselabel__16_
# was:	beq	_if__15_, 0, _elselabel__16_
	ori	$4, $0, 0
# was:	ori	dead, 0, 0
# 	ori	4,dead,0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
	j	_exitlabel__17_
_elselabel__16_:
	ori	$3, $0, 1
# was:	ori	_dec__23_, 0, 1
	ori	$4, $3, 0
# was:	ori	4, _dec__23_, 0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
# 	ori	_patVar_y__24_,_dec__23_,0
	ori	$2, $0, 0
# was:	ori	_apply__28_, 0, 0
# 	ori	2,_apply__28_,0
	jal	exists
# was:	jal	exists, 2
# 	ori	_if__25_,2,0
	beq	$2, $0, _elselabel__26_
# was:	beq	_if__25_, 0, _elselabel__26_
	ori	$4, $0, 2
# was:	ori	dead, 0, 2
# 	ori	4,dead,0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
	j	_exitlabel__27_
_elselabel__26_:
	ori	$4, $0, 3
# was:	ori	dead, 0, 3
# 	ori	4,dead,0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
_exitlabel__27_:
_exitlabel__17_:
	j	_stop_
# 
exists:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	exists_arg__1_,2,0
	bne	$2, $0, _match__5_
# was:	bne	exists_arg__1_, 0, _match__5_
	ori	$2, $0, 0
# was:	ori	exists_res__2_, 0, 0
	j	exists_return__3_
_match__5_:
	lw	$2, 0($2)
# was:	lw	_patTuple__7_, 0(exists_arg__1_)
# 	ori	_patVar_x__8_,_patTuple__7_,0
	ori	$2, $0, 1
# was:	ori	exists_res__2_, 0, 1
	j	exists_return__3_
_match__6_:
	j	exists_fail__4_
exists_return__3_:
# 	ori	2,exists_res__2_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
exists_fail__4_:
	ori	$5, $0, 6
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
