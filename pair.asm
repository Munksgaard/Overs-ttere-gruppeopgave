	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $0, 5
# was:	ori	2, 0, 5
	syscall
# 	ori	_tuple1__5_,2,0
	sw	$2, 0($28)
# was:	sw	_tuple1__5_, 0(28)
	ori	$2, $0, 5
# was:	ori	2, 0, 5
	syscall
# 	ori	_tuple1__6_,2,0
	sw	$2, 4($28)
# was:	sw	_tuple1__6_, 4(28)
	addi	$2, $28, 0
# was:	addi	_dec__4_, 28, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
	lw	$3, 0($2)
# was:	lw	_patTuple__7_, 0(_dec__4_)
# 	ori	_patVar_x__8_,_patTuple__7_,0
	lw	$6, 4($2)
# was:	lw	_patTuple__9_, 4(_dec__4_)
# 	ori	_patVar_y__10_,_patTuple__9_,0
# 	ori	_dec__11_,_patVar_y__10_,0
	ori	$4, $6, 0
# was:	ori	4, _dec__11_, 0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
# 	ori	_patVar_t1__12_,_dec__11_,0
	ori	$4, $3, 0
# was:	ori	dead, _patVar_x__8_, 0
# 	ori	4,dead,0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
	j	_stop_
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
