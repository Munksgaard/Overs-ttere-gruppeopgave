	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $0, 5
# was:	ori	2, 0, 5
	syscall
	ori	$3, $2, 0
# was:	ori	_less1__5_, 2, 0
	ori	$2, $0, 7
# was:	ori	_less2__6_, 0, 7
	lui	$4, 0
# was:	lui	_case1__1_, 0
	slt	$4, $3, $2
# was:	slt	_case1__1_, _less1__5_, _less2__6_
	bne	$4, $0, _match__9_
# was:	bne	_case1__1_, 0, _match__9_
	ori	$4, $0, 4
# was:	ori	dead, 0, 4
# 	ori	4,dead,0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
	j	_caseendlabel__4_
_match__9_:
	bne	$4, $0, _match__10_
# was:	bne	_case1__1_, 0, _match__10_
	ori	$4, $0, 5
# was:	ori	dead, 0, 5
# 	ori	4,dead,0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
	j	_caseendlabel__4_
_match__10_:
	j	_casefaillabel__3_
_casefaillabel__3_:
	ori	$5, $0, 4
# was:	ori	5, 0, 4
	j	_Error_
_caseendlabel__4_:
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
