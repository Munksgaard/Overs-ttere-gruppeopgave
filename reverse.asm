	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $0, 5
# was:	ori	2, 0, 5
	syscall
# 	ori	_apply__15_,2,0
# 	ori	2,_apply__15_,0
	jal	readwrite
# was:	jal	readwrite, 2
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
readwrite:
	sw	$31, -4($29)
	sw	$16, -8($29)
	addi	$29, $29, -12
# 	ori	readwrite_arg__1_,2,0
	ori	$3, $0, 0
# was:	ori	_constPat__6_, 0, 0
	bne	$2, $3, _match__5_
# was:	bne	readwrite_arg__1_, _constPat__6_, _match__5_
	ori	$2, $0, 0
# was:	ori	readwrite_res__2_, 0, 0
	j	readwrite_return__3_
_match__5_:
	ori	$16, $2, 0
# was:	ori	_patVar_x__8_, readwrite_arg__1_, 0
	ori	$2, $0, 5
# was:	ori	2, 0, 5
	syscall
# 	ori	_apply__13_,2,0
# 	ori	2,_apply__13_,0
	jal	readwrite
# was:	jal	readwrite, 2
	ori	$3, $2, 0
# was:	ori	_dec__12_, 2, 0
	ori	$4, $3, 0
# was:	ori	4, _dec__12_, 0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
# 	ori	_patVar_y__14_,_dec__12_,0
	ori	$2, $16, 0
# was:	ori	readwrite_res__2_, _patVar_x__8_, 0
	j	readwrite_return__3_
_match__7_:
	j	readwrite_fail__4_
readwrite_return__3_:
# 	ori	2,readwrite_res__2_,0
	addi	$29, $29, 12
	lw	$16, -8($29)
	lw	$31, -4($29)
	jr	$31
readwrite_fail__4_:
	ori	$5, $0, 4
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
