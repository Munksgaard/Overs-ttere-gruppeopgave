	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $0, 5
# was:	ori	2, 0, 5
	syscall
# 	ori	_dec__2_,2,0
# 	ori	_patVar_x__3_,_dec__2_,0
	ori	$3, $0, 0
# was:	ori	_dec__4_, 0, 0
# 	ori	_patVar_x__5_,_dec__4_,0
# 	ori	_plus1__6_,_patVar_x__5_,0
	ori	$2, $3, 0
# was:	ori	_plus2__7_, _patVar_x__5_, 0
	add	$0, $3, $2
# was:	add	dead, _plus1__6_, _plus2__7_
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
