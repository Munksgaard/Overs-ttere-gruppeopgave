	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	addi	$6, $28, 0
# was:	addi	_compileTupleMem__4_, 28, 0
	addi	$3, $6, 0
# was:	addi	_dec__3_, _compileTupleMem__4_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
	ori	$2, $0, 5
# was:	ori	2, 0, 5
	syscall
# 	ori	_compileTuple1__5_,2,0
	sw	$2, 0($6)
# was:	sw	_compileTuple1__5_, 0(_compileTupleMem__4_)
	addi	$6, $6, 4
# was:	addi	_compileTupleMem__4_, _compileTupleMem__4_, 4
	ori	$2, $0, 5
# was:	ori	2, 0, 5
	syscall
# 	ori	_compileTuple1__7_,2,0
	sw	$2, 0($6)
# was:	sw	_compileTuple1__7_, 0(_compileTupleMem__4_)
	addi	$6, $6, 4
# was:	addi	_compileTupleMem__4_, _compileTupleMem__4_, 4
	beq	$3, $0, _letfaillabel__1_
# was:	beq	_dec__3_, 0, _letfaillabel__1_
	lw	$6, 0($3)
# was:	lw	_patTuple__9_, 0(_dec__3_)
# 	ori	_patVar_x__10_,_patTuple__9_,0
	lw	$3, 4($3)
# was:	lw	_patTuple__11_, 4(_dec__3_)
# 	ori	_patVar_y__12_,_patTuple__11_,0
# 	ori	_dec__13_,_patVar_y__12_,0
	ori	$4, $3, 0
# was:	ori	4, _dec__13_, 0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
# 	ori	_patVar_t1__14_,_dec__13_,0
	ori	$4, $6, 0
# was:	ori	dead, _patVar_x__10_, 0
# 	ori	4,dead,0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
	j	_letlabel1__2_
_letfaillabel__1_:
	ori	$5, $0, 6
# was:	ori	5, 0, 6
	j	_Error_
_letlabel1__2_:
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
