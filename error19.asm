	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$3, $0, 0
# was:	ori	_dec__2_, 0, 0
	beq	$3, $0, _letfaillabel__1_
# was:	beq	_dec__2_, 0, _letfaillabel__1_
	lw	$2, 0($3)
# was:	lw	_patTuple__3_, 0(_dec__2_)
# 	ori	_patVar_x__4_,_patTuple__3_,0
	lw	$3, 4($3)
# was:	lw	_patTuple__5_, 4(_dec__2_)
# 	ori	_patVar_y__6_,_patTuple__5_,0
# 	ori	dead,_patVar_x__4_,0
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
