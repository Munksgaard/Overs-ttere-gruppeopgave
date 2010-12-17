	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	addi	$3, $28, 0
# was:	addi	_compileTupleMem__123_, 28, 0
	addi	$2, $3, 0
# was:	addi	_apply__122_, _compileTupleMem__123_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
	ori	$4, $0, 3
# was:	ori	_compileTuple1__125_, 0, 3
	sw	$4, 0($3)
# was:	sw	_compileTuple1__125_, 0(_compileTupleMem__123_)
	addi	$3, $3, 4
# was:	addi	_compileTupleMem__123_, _compileTupleMem__123_, 4
	addi	$4, $28, 0
# was:	addi	_compileTupleMem__129_, 28, 0
	addi	$5, $4, 0
# was:	addi	_compileTuple1__127_, _compileTupleMem__129_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
	ori	$6, $0, 6
# was:	ori	_compileTuple1__131_, 0, 6
	sw	$6, 0($4)
# was:	sw	_compileTuple1__131_, 0(_compileTupleMem__129_)
	addi	$4, $4, 4
# was:	addi	_compileTupleMem__129_, _compileTupleMem__129_, 4
	ori	$6, $0, 0
# was:	ori	_compileTuple1__133_, 0, 0
	sw	$6, 0($4)
# was:	sw	_compileTuple1__133_, 0(_compileTupleMem__129_)
	addi	$4, $4, 4
# was:	addi	_compileTupleMem__129_, _compileTupleMem__129_, 4
	sw	$5, 0($3)
# was:	sw	_compileTuple1__127_, 0(_compileTupleMem__123_)
	addi	$3, $3, 4
# was:	addi	_compileTupleMem__123_, _compileTupleMem__123_, 4
# 	ori	2,_apply__122_,0
	jal	printList
# was:	jal	printList, 2
# 	ori	dead,2,0
	j	_stop_
# 
booltest:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	booltest_arg__1_,2,0
# 	ori	_patVar_n__6_,booltest_arg__1_,0
	ori	$3, $0, 0
# was:	ori	_or1__7_, 0, 0
	ori	$2, $0, 1
# was:	ori	_or2__8_, 0, 1
	or	$2, $3, $2
# was:	or	booltest_res__2_, _or1__7_, _or2__8_
	j	booltest_return__3_
_match__5_:
	j	booltest_fail__4_
booltest_return__3_:
# 	ori	2,booltest_res__2_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
booltest_fail__4_:
	ori	$5, $0, 5
	j	_Error_
# 
boolToInt:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	boolToInt_arg__9_,2,0
	ori	$3, $0, 1
# was:	ori	_constPat__14_, 0, 1
	bne	$2, $3, _match__13_
# was:	bne	boolToInt_arg__9_, _constPat__14_, _match__13_
	ori	$2, $0, 1
# was:	ori	boolToInt_res__10_, 0, 1
	j	boolToInt_return__11_
_match__13_:
	bne	$2, $0, _match__15_
# was:	bne	boolToInt_arg__9_, 0, _match__15_
	ori	$2, $0, 0
# was:	ori	boolToInt_res__10_, 0, 0
	j	boolToInt_return__11_
_match__15_:
	j	boolToInt_fail__12_
boolToInt_return__11_:
# 	ori	2,boolToInt_res__10_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
boolToInt_fail__12_:
	ori	$5, $0, 9
	j	_Error_
# 
ifTest:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	ifTest_arg__16_,2,0
	ori	$3, $2, 0
# was:	ori	_patVar_n__21_, ifTest_arg__16_, 0
# 	ori	_equal1__25_,_patVar_n__21_,0
	ori	$2, $0, 5
# was:	ori	_equal2__26_, 0, 5
	bne	$3, $2, _equallabel1__27_
# was:	bne	_equal1__25_, _equal2__26_, _equallabel1__27_
	ori	$2, $0, 1
# was:	ori	_if__22_, 0, 1
	j	_equallabel2__28_
_equallabel1__27_:
	ori	$2, $0, 0
# was:	ori	_if__22_, 0, 0
_equallabel2__28_:
	beq	$2, $0, _elselabel__23_
# was:	beq	_if__22_, 0, _elselabel__23_
	ori	$2, $0, 1
# was:	ori	ifTest_res__17_, 0, 1
	j	_exitlabel__24_
_elselabel__23_:
	ori	$2, $0, 0
# was:	ori	ifTest_res__17_, 0, 0
_exitlabel__24_:
	j	ifTest_return__18_
_match__20_:
	j	ifTest_fail__19_
ifTest_return__18_:
# 	ori	2,ifTest_res__17_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
ifTest_fail__19_:
	ori	$5, $0, 14
	j	_Error_
# 
caseTest:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	caseTest_arg__29_,2,0
	ori	$3, $2, 0
# was:	ori	_patVar_n__34_, caseTest_arg__29_, 0
# 	ori	_case1__35_,_patVar_n__34_,0
	ori	$2, $0, 3
# was:	ori	_constPat__40_, 0, 3
	bne	$3, $2, _match__39_
# was:	bne	_case1__35_, _constPat__40_, _match__39_
	ori	$2, $0, 10
# was:	ori	caseTest_res__30_, 0, 10
	j	_caseendlabel__38_
_match__39_:
# 	ori	_patVar_n__42_,_case1__35_,0
	ori	$2, $3, 0
# was:	ori	_plus1__43_, _patVar_n__42_, 0
	ori	$3, $0, 5
# was:	ori	_plus2__44_, 0, 5
	add	$2, $2, $3
# was:	add	caseTest_res__30_, _plus1__43_, _plus2__44_
	j	_caseendlabel__38_
_match__41_:
	j	_casefaillabel__37_
_casefaillabel__37_:
	ori	$5, $0, 19
# was:	ori	5, 0, 19
	j	_Error_
_caseendlabel__38_:
	j	caseTest_return__31_
_match__33_:
	j	caseTest_fail__32_
caseTest_return__31_:
# 	ori	2,caseTest_res__30_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
caseTest_fail__32_:
	ori	$5, $0, 18
	j	_Error_
# 
mktupletest:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	mktupletest_arg__45_,2,0
	beq	$2, $0, _match__49_
# was:	beq	mktupletest_arg__45_, 0, _match__49_
	lw	$3, 0($2)
# was:	lw	_patTuple__50_, 0(mktupletest_arg__45_)
	ori	$4, $0, 2
# was:	ori	_constPat__51_, 0, 2
	bne	$3, $4, _match__49_
# was:	bne	_patTuple__50_, _constPat__51_, _match__49_
	lw	$3, 4($2)
# was:	lw	_patTuple__52_, 4(mktupletest_arg__45_)
	ori	$4, $0, 2
# was:	ori	_constPat__53_, 0, 2
	bne	$3, $4, _match__49_
# was:	bne	_patTuple__52_, _constPat__53_, _match__49_
	ori	$2, $0, 1
# was:	ori	mktupletest_res__46_, 0, 1
	j	mktupletest_return__47_
_match__49_:
	beq	$2, $0, _match__54_
# was:	beq	mktupletest_arg__45_, 0, _match__54_
	lw	$3, 0($2)
# was:	lw	_patTuple__55_, 0(mktupletest_arg__45_)
# 	ori	_patVar_n__56_,_patTuple__55_,0
	lw	$2, 4($2)
# was:	lw	_patTuple__57_, 4(mktupletest_arg__45_)
# 	ori	_patVar_m__58_,_patTuple__57_,0
# 	ori	_plus1__59_,_patVar_n__56_,0
# 	ori	_plus2__60_,_patVar_m__58_,0
	add	$2, $3, $2
# was:	add	mktupletest_res__46_, _plus1__59_, _plus2__60_
	j	mktupletest_return__47_
_match__54_:
	j	mktupletest_fail__48_
mktupletest_return__47_:
# 	ori	2,mktupletest_res__46_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
mktupletest_fail__48_:
	ori	$5, $0, 25
	j	_Error_
# 
lettest:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	lettest_arg__61_,2,0
# 	ori	_patVar_n__66_,lettest_arg__61_,0
	ori	$3, $0, 4
# was:	ori	_dec__70_, 0, 4
# 	ori	_patVar_m__71_,_dec__70_,0
# 	ori	_plus1__72_,_patVar_n__66_,0
# 	ori	_plus2__73_,_patVar_m__71_,0
	add	$2, $2, $3
# was:	add	lettest_res__62_, _plus1__72_, _plus2__73_
	j	lettest_return__63_
_match__65_:
	j	lettest_fail__64_
lettest_return__63_:
# 	ori	2,lettest_res__62_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
lettest_fail__64_:
	ori	$5, $0, 30
	j	_Error_
# 
lettest2:
	sw	$31, -4($29)
	sw	$16, -8($29)
	addi	$29, $29, -12
# 	ori	lettest2_arg__74_,2,0
# 	ori	_patVar_n__79_,lettest2_arg__74_,0
	ori	$16, $0, 1
# was:	ori	_dec__83_, 0, 1
# 	ori	_patVar_m__84_,_dec__83_,0
# 	ori	_apply__87_,_patVar_n__79_,0
# 	ori	2,_apply__87_,0
	jal	lettest
# was:	jal	lettest, 2
# 	ori	_plus1__85_,2,0
# 	ori	_plus2__86_,_patVar_m__84_,0
	add	$2, $2, $16
# was:	add	lettest2_res__75_, _plus1__85_, _plus2__86_
	j	lettest2_return__76_
_match__78_:
	j	lettest2_fail__77_
lettest2_return__76_:
# 	ori	2,lettest2_res__75_,0
	addi	$29, $29, 12
	lw	$16, -8($29)
	lw	$31, -4($29)
	jr	$31
lettest2_fail__77_:
	ori	$5, $0, 33
	j	_Error_
# 
tupletest:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	tupletest_arg__88_,2,0
# 	ori	_patVar_n__93_,tupletest_arg__88_,0
	addi	$3, $28, 0
# was:	addi	_compileTupleMem__94_, 28, 0
	addi	$2, $3, 0
# was:	addi	tupletest_res__89_, _compileTupleMem__94_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
	ori	$4, $0, 8
# was:	ori	_compileTuple1__96_, 0, 8
	sw	$4, 0($3)
# was:	sw	_compileTuple1__96_, 0(_compileTupleMem__94_)
	addi	$3, $3, 4
# was:	addi	_compileTupleMem__94_, _compileTupleMem__94_, 4
	addi	$4, $28, 0
# was:	addi	_compileTupleMem__100_, 28, 0
	addi	$5, $4, 0
# was:	addi	_compileTuple1__98_, _compileTupleMem__100_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
	ori	$6, $0, 5
# was:	ori	_compileTuple1__102_, 0, 5
	sw	$6, 0($4)
# was:	sw	_compileTuple1__102_, 0(_compileTupleMem__100_)
	addi	$4, $4, 4
# was:	addi	_compileTupleMem__100_, _compileTupleMem__100_, 4
	ori	$6, $0, 0
# was:	ori	_compileTuple1__104_, 0, 0
	sw	$6, 0($4)
# was:	sw	_compileTuple1__104_, 0(_compileTupleMem__100_)
	addi	$4, $4, 4
# was:	addi	_compileTupleMem__100_, _compileTupleMem__100_, 4
	sw	$5, 0($3)
# was:	sw	_compileTuple1__98_, 0(_compileTupleMem__94_)
	addi	$3, $3, 4
# was:	addi	_compileTupleMem__94_, _compileTupleMem__94_, 4
	j	tupletest_return__90_
_match__92_:
	j	tupletest_fail__91_
tupletest_return__90_:
# 	ori	2,tupletest_res__89_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
tupletest_fail__91_:
	ori	$5, $0, 43
	j	_Error_
# 
printList:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	printList_arg__106_,2,0
	beq	$2, $0, _match__110_
# was:	beq	printList_arg__106_, 0, _match__110_
	lw	$6, 0($2)
# was:	lw	_patTuple__111_, 0(printList_arg__106_)
# 	ori	_patVar_n__112_,_patTuple__111_,0
	lw	$3, 4($2)
# was:	lw	_patTuple__113_, 4(printList_arg__106_)
# 	ori	_patVar_l__114_,_patTuple__113_,0
# 	ori	_dec__118_,_patVar_n__112_,0
	ori	$4, $6, 0
# was:	ori	4, _dec__118_, 0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
# 	ori	_patVar_t__119_,_dec__118_,0
	ori	$2, $3, 0
# was:	ori	_apply__120_, _patVar_l__114_, 0
# 	ori	2,_apply__120_,0
	jal	printList
# was:	jal	printList, 2
# 	ori	printList_res__107_,2,0
	j	printList_return__108_
_match__110_:
	bne	$2, $0, _match__121_
# was:	bne	printList_arg__106_, 0, _match__121_
	ori	$2, $0, 1
# was:	ori	printList_res__107_, 0, 1
	j	printList_return__108_
_match__121_:
	j	printList_fail__109_
printList_return__108_:
# 	ori	2,printList_res__107_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
printList_fail__109_:
	ori	$5, $0, 47
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
