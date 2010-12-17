	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $0, 5
# was:	ori	2, 0, 5
	syscall
# 	ori	_apply__191_,2,0
# 	ori	2,_apply__191_,0
	jal	readList
# was:	jal	readList, 2
# 	ori	_apply__190_,2,0
# 	ori	2,_apply__190_,0
	jal	qsort
# was:	jal	qsort, 2
# 	ori	_apply__189_,2,0
# 	ori	2,_apply__189_,0
	jal	printList
# was:	jal	printList, 2
# 	ori	dead,2,0
	j	_stop_
# 
readList:
	sw	$31, -4($29)
	sw	$17, -12($29)
	sw	$16, -8($29)
	addi	$29, $29, -16
# 	ori	readList_arg__1_,2,0
	ori	$3, $0, 0
# was:	ori	_constPat__6_, 0, 0
	bne	$2, $3, _match__5_
# was:	bne	readList_arg__1_, _constPat__6_, _match__5_
	ori	$16, $0, 0
# was:	ori	readList_res__2_, 0, 0
	j	readList_return__3_
_match__5_:
	ori	$3, $2, 0
# was:	ori	_patVar_n__8_, readList_arg__1_, 0
	addi	$17, $28, 0
# was:	addi	_compileTupleMem__9_, 28, 0
	addi	$16, $17, 0
# was:	addi	readList_res__2_, _compileTupleMem__9_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
	ori	$2, $0, 5
# was:	ori	2, 0, 5
	syscall
# 	ori	_compileTuple1__11_,2,0
	sw	$2, 0($17)
# was:	sw	_compileTuple1__11_, 0(_compileTupleMem__9_)
	addi	$17, $17, 4
# was:	addi	_compileTupleMem__9_, _compileTupleMem__9_, 4
# 	ori	_minus1__16_,_patVar_n__8_,0
	ori	$2, $0, 1
# was:	ori	_minus2__17_, 0, 1
	sub	$2, $3, $2
# was:	sub	_apply__15_, _minus1__16_, _minus2__17_
# 	ori	2,_apply__15_,0
	jal	readList
# was:	jal	readList, 2
# 	ori	_compileTuple1__13_,2,0
	sw	$2, 0($17)
# was:	sw	_compileTuple1__13_, 0(_compileTupleMem__9_)
	addi	$17, $17, 4
# was:	addi	_compileTupleMem__9_, _compileTupleMem__9_, 4
	j	readList_return__3_
_match__7_:
	j	readList_fail__4_
readList_return__3_:
	ori	$2, $16, 0
# was:	ori	2, readList_res__2_, 0
	addi	$29, $29, 16
	lw	$17, -12($29)
	lw	$16, -8($29)
	lw	$31, -4($29)
	jr	$31
readList_fail__4_:
	ori	$5, $0, 8
	j	_Error_
# 
printList:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	printList_arg__18_,2,0
	beq	$2, $0, _match__22_
# was:	beq	printList_arg__18_, 0, _match__22_
	lw	$6, 0($2)
# was:	lw	_patTuple__23_, 0(printList_arg__18_)
# 	ori	_patVar_n__24_,_patTuple__23_,0
	lw	$3, 4($2)
# was:	lw	_patTuple__25_, 4(printList_arg__18_)
# 	ori	_patVar_l__26_,_patTuple__25_,0
# 	ori	_dec__30_,_patVar_n__24_,0
	ori	$4, $6, 0
# was:	ori	4, _dec__30_, 0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
# 	ori	_patVar_t__31_,_dec__30_,0
	ori	$2, $3, 0
# was:	ori	_apply__32_, _patVar_l__26_, 0
# 	ori	2,_apply__32_,0
	jal	printList
# was:	jal	printList, 2
# 	ori	printList_res__19_,2,0
	j	printList_return__20_
_match__22_:
	bne	$2, $0, _match__33_
# was:	bne	printList_arg__18_, 0, _match__33_
	ori	$2, $0, 1
# was:	ori	printList_res__19_, 0, 1
	j	printList_return__20_
_match__33_:
	j	printList_fail__21_
printList_return__20_:
# 	ori	2,printList_res__19_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
printList_fail__21_:
	ori	$5, $0, 13
	j	_Error_
# 
append:
	sw	$31, -4($29)
	sw	$17, -12($29)
	sw	$16, -8($29)
	addi	$29, $29, -16
# 	ori	append_arg__34_,2,0
	beq	$2, $0, _match__38_
# was:	beq	append_arg__34_, 0, _match__38_
	lw	$3, 0($2)
# was:	lw	_patTuple__39_, 0(append_arg__34_)
	bne	$3, $0, _match__38_
# was:	bne	_patTuple__39_, 0, _match__38_
	lw	$17, 4($2)
# was:	lw	_patTuple__40_, 4(append_arg__34_)
# 	ori	_patVar_l2__41_,_patTuple__40_,0
# 	ori	append_res__35_,_patVar_l2__41_,0
	j	append_return__36_
_match__38_:
	beq	$2, $0, _match__42_
# was:	beq	append_arg__34_, 0, _match__42_
	lw	$3, 0($2)
# was:	lw	_patTuple__43_, 0(append_arg__34_)
	beq	$3, $0, _match__42_
# was:	beq	_patTuple__43_, 0, _match__42_
	lw	$4, 0($3)
# was:	lw	_patTuple__44_, 0(_patTuple__43_)
# 	ori	_patVar_n__45_,_patTuple__44_,0
	lw	$3, 4($3)
# was:	lw	_patTuple__46_, 4(_patTuple__43_)
# 	ori	_patVar_l1__47_,_patTuple__46_,0
	lw	$2, 4($2)
# was:	lw	_patTuple__48_, 4(append_arg__34_)
# 	ori	_patVar_l2__49_,_patTuple__48_,0
	addi	$16, $28, 0
# was:	addi	_compileTupleMem__50_, 28, 0
	addi	$17, $16, 0
# was:	addi	append_res__35_, _compileTupleMem__50_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__52_,_patVar_n__45_,0
	sw	$4, 0($16)
# was:	sw	_compileTuple1__52_, 0(_compileTupleMem__50_)
	addi	$16, $16, 4
# was:	addi	_compileTupleMem__50_, _compileTupleMem__50_, 4
	addi	$4, $28, 0
# was:	addi	_compileTupleMem__57_, 28, 0
	addi	$5, $4, 0
# was:	addi	_apply__56_, _compileTupleMem__57_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__59_,_patVar_l1__47_,0
	sw	$3, 0($4)
# was:	sw	_compileTuple1__59_, 0(_compileTupleMem__57_)
	addi	$4, $4, 4
# was:	addi	_compileTupleMem__57_, _compileTupleMem__57_, 4
# 	ori	_compileTuple1__61_,_patVar_l2__49_,0
	sw	$2, 0($4)
# was:	sw	_compileTuple1__61_, 0(_compileTupleMem__57_)
	addi	$4, $4, 4
# was:	addi	_compileTupleMem__57_, _compileTupleMem__57_, 4
	ori	$2, $5, 0
# was:	ori	2, _apply__56_, 0
	jal	append
# was:	jal	append, 2
# 	ori	_compileTuple1__54_,2,0
	sw	$2, 0($16)
# was:	sw	_compileTuple1__54_, 0(_compileTupleMem__50_)
	addi	$16, $16, 4
# was:	addi	_compileTupleMem__50_, _compileTupleMem__50_, 4
	j	append_return__36_
_match__42_:
	j	append_fail__37_
append_return__36_:
	ori	$2, $17, 0
# was:	ori	2, append_res__35_, 0
	addi	$29, $29, 16
	lw	$17, -12($29)
	lw	$16, -8($29)
	lw	$31, -4($29)
	jr	$31
append_fail__37_:
	ori	$5, $0, 18
	j	_Error_
# 
qsort:
	sw	$31, -4($29)
	sw	$21, -28($29)
	sw	$20, -24($29)
	sw	$19, -20($29)
	sw	$18, -16($29)
	sw	$17, -12($29)
	sw	$16, -8($29)
	addi	$29, $29, -32
# 	ori	qsort_arg__63_,2,0
	bne	$2, $0, _match__67_
# was:	bne	qsort_arg__63_, 0, _match__67_
	ori	$2, $0, 0
# was:	ori	qsort_res__64_, 0, 0
	j	qsort_return__65_
_match__67_:
	beq	$2, $0, _match__68_
# was:	beq	qsort_arg__63_, 0, _match__68_
	lw	$21, 0($2)
# was:	lw	_patTuple__69_, 0(qsort_arg__63_)
# 	ori	_patVar_n__70_,_patTuple__69_,0
	lw	$18, 4($2)
# was:	lw	_patTuple__71_, 4(qsort_arg__63_)
# 	ori	_patVar_l__72_,_patTuple__71_,0
	addi	$16, $28, 0
# was:	addi	_compileTupleMem__74_, 28, 0
	addi	$17, $16, 0
# was:	addi	_apply__73_, _compileTupleMem__74_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
	addi	$3, $28, 0
# was:	addi	_compileTupleMem__80_, 28, 0
	addi	$2, $3, 0
# was:	addi	_apply__79_, _compileTupleMem__80_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__82_,_patVar_n__70_,0
	sw	$21, 0($3)
# was:	sw	_compileTuple1__82_, 0(_compileTupleMem__80_)
	addi	$3, $3, 4
# was:	addi	_compileTupleMem__80_, _compileTupleMem__80_, 4
# 	ori	_compileTuple1__84_,_patVar_l__72_,0
	sw	$18, 0($3)
# was:	sw	_compileTuple1__84_, 0(_compileTupleMem__80_)
	addi	$3, $3, 4
# was:	addi	_compileTupleMem__80_, _compileTupleMem__80_, 4
# 	ori	2,_apply__79_,0
	jal	smaller
# was:	jal	smaller, 2
# 	ori	_apply__78_,2,0
# 	ori	2,_apply__78_,0
	jal	qsort
# was:	jal	qsort, 2
# 	ori	_compileTuple1__76_,2,0
	sw	$2, 0($16)
# was:	sw	_compileTuple1__76_, 0(_compileTupleMem__74_)
	addi	$16, $16, 4
# was:	addi	_compileTupleMem__74_, _compileTupleMem__74_, 4
	addi	$20, $28, 0
# was:	addi	_compileTupleMem__88_, 28, 0
	addi	$19, $20, 0
# was:	addi	_compileTuple1__86_, _compileTupleMem__88_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__90_,_patVar_n__70_,0
	sw	$21, 0($20)
# was:	sw	_compileTuple1__90_, 0(_compileTupleMem__88_)
	addi	$20, $20, 4
# was:	addi	_compileTupleMem__88_, _compileTupleMem__88_, 4
	addi	$3, $28, 0
# was:	addi	_compileTupleMem__96_, 28, 0
	addi	$2, $3, 0
# was:	addi	_apply__95_, _compileTupleMem__96_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__98_,_patVar_n__70_,0
	sw	$21, 0($3)
# was:	sw	_compileTuple1__98_, 0(_compileTupleMem__96_)
	addi	$3, $3, 4
# was:	addi	_compileTupleMem__96_, _compileTupleMem__96_, 4
# 	ori	_compileTuple1__100_,_patVar_l__72_,0
	sw	$18, 0($3)
# was:	sw	_compileTuple1__100_, 0(_compileTupleMem__96_)
	addi	$3, $3, 4
# was:	addi	_compileTupleMem__96_, _compileTupleMem__96_, 4
# 	ori	2,_apply__95_,0
	jal	larger
# was:	jal	larger, 2
# 	ori	_apply__94_,2,0
# 	ori	2,_apply__94_,0
	jal	qsort
# was:	jal	qsort, 2
# 	ori	_compileTuple1__92_,2,0
	sw	$2, 0($20)
# was:	sw	_compileTuple1__92_, 0(_compileTupleMem__88_)
	addi	$20, $20, 4
# was:	addi	_compileTupleMem__88_, _compileTupleMem__88_, 4
	sw	$19, 0($16)
# was:	sw	_compileTuple1__86_, 0(_compileTupleMem__74_)
	addi	$16, $16, 4
# was:	addi	_compileTupleMem__74_, _compileTupleMem__74_, 4
	ori	$2, $17, 0
# was:	ori	2, _apply__73_, 0
	jal	append
# was:	jal	append, 2
# 	ori	qsort_res__64_,2,0
	j	qsort_return__65_
_match__68_:
	j	qsort_fail__66_
qsort_return__65_:
# 	ori	2,qsort_res__64_,0
	addi	$29, $29, 32
	lw	$21, -28($29)
	lw	$20, -24($29)
	lw	$19, -20($29)
	lw	$18, -16($29)
	lw	$17, -12($29)
	lw	$16, -8($29)
	lw	$31, -4($29)
	jr	$31
qsort_fail__66_:
	ori	$5, $0, 23
	j	_Error_
# 
smaller:
	sw	$31, -4($29)
	sw	$17, -12($29)
	sw	$16, -8($29)
	addi	$29, $29, -16
# 	ori	smaller_arg__102_,2,0
	beq	$2, $0, _match__106_
# was:	beq	smaller_arg__102_, 0, _match__106_
	lw	$3, 0($2)
# was:	lw	_patTuple__107_, 0(smaller_arg__102_)
# 	ori	_patVar_n__108_,_patTuple__107_,0
	lw	$3, 4($2)
# was:	lw	_patTuple__109_, 4(smaller_arg__102_)
	bne	$3, $0, _match__106_
# was:	bne	_patTuple__109_, 0, _match__106_
	ori	$17, $0, 0
# was:	ori	smaller_res__103_, 0, 0
	j	smaller_return__104_
_match__106_:
	beq	$2, $0, _match__110_
# was:	beq	smaller_arg__102_, 0, _match__110_
	lw	$3, 0($2)
# was:	lw	_patTuple__111_, 0(smaller_arg__102_)
# 	ori	_patVar_n__112_,_patTuple__111_,0
	lw	$2, 4($2)
# was:	lw	_patTuple__113_, 4(smaller_arg__102_)
	beq	$2, $0, _match__110_
# was:	beq	_patTuple__113_, 0, _match__110_
	lw	$4, 0($2)
# was:	lw	_patTuple__114_, 0(_patTuple__113_)
# 	ori	_patVar_m__115_,_patTuple__114_,0
	lw	$2, 4($2)
# was:	lw	_patTuple__116_, 4(_patTuple__113_)
# 	ori	_patVar_l__117_,_patTuple__116_,0
# 	ori	_less1__121_,_patVar_m__115_,0
# 	ori	_less2__122_,_patVar_n__112_,0
	lui	$5, 0
# was:	lui	_if__118_, 0
	slt	$5, $4, $3
# was:	slt	_if__118_, _less1__121_, _less2__122_
	beq	$5, $0, _elselabel__119_
# was:	beq	_if__118_, 0, _elselabel__119_
	addi	$16, $28, 0
# was:	addi	_compileTupleMem__125_, 28, 0
	addi	$17, $16, 0
# was:	addi	smaller_res__103_, _compileTupleMem__125_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__127_,_patVar_m__115_,0
	sw	$4, 0($16)
# was:	sw	_compileTuple1__127_, 0(_compileTupleMem__125_)
	addi	$16, $16, 4
# was:	addi	_compileTupleMem__125_, _compileTupleMem__125_, 4
	addi	$5, $28, 0
# was:	addi	_compileTupleMem__132_, 28, 0
	addi	$4, $5, 0
# was:	addi	_apply__131_, _compileTupleMem__132_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__134_,_patVar_n__112_,0
	sw	$3, 0($5)
# was:	sw	_compileTuple1__134_, 0(_compileTupleMem__132_)
	addi	$5, $5, 4
# was:	addi	_compileTupleMem__132_, _compileTupleMem__132_, 4
# 	ori	_compileTuple1__136_,_patVar_l__117_,0
	sw	$2, 0($5)
# was:	sw	_compileTuple1__136_, 0(_compileTupleMem__132_)
	addi	$5, $5, 4
# was:	addi	_compileTupleMem__132_, _compileTupleMem__132_, 4
	ori	$2, $4, 0
# was:	ori	2, _apply__131_, 0
	jal	smaller
# was:	jal	smaller, 2
# 	ori	_compileTuple1__129_,2,0
	sw	$2, 0($16)
# was:	sw	_compileTuple1__129_, 0(_compileTupleMem__125_)
	addi	$16, $16, 4
# was:	addi	_compileTupleMem__125_, _compileTupleMem__125_, 4
	j	_exitlabel__120_
_elselabel__119_:
	addi	$4, $28, 0
# was:	addi	_compileTupleMem__139_, 28, 0
	addi	$5, $4, 0
# was:	addi	_apply__138_, _compileTupleMem__139_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__141_,_patVar_n__112_,0
	sw	$3, 0($4)
# was:	sw	_compileTuple1__141_, 0(_compileTupleMem__139_)
	addi	$4, $4, 4
# was:	addi	_compileTupleMem__139_, _compileTupleMem__139_, 4
# 	ori	_compileTuple1__143_,_patVar_l__117_,0
	sw	$2, 0($4)
# was:	sw	_compileTuple1__143_, 0(_compileTupleMem__139_)
	addi	$4, $4, 4
# was:	addi	_compileTupleMem__139_, _compileTupleMem__139_, 4
	ori	$2, $5, 0
# was:	ori	2, _apply__138_, 0
	jal	smaller
# was:	jal	smaller, 2
	ori	$17, $2, 0
# was:	ori	smaller_res__103_, 2, 0
_exitlabel__120_:
	j	smaller_return__104_
_match__110_:
	j	smaller_fail__105_
smaller_return__104_:
	ori	$2, $17, 0
# was:	ori	2, smaller_res__103_, 0
	addi	$29, $29, 16
	lw	$17, -12($29)
	lw	$16, -8($29)
	lw	$31, -4($29)
	jr	$31
smaller_fail__105_:
	ori	$5, $0, 29
	j	_Error_
# 
larger:
	sw	$31, -4($29)
	sw	$17, -12($29)
	sw	$16, -8($29)
	addi	$29, $29, -16
# 	ori	larger_arg__145_,2,0
	beq	$2, $0, _match__149_
# was:	beq	larger_arg__145_, 0, _match__149_
	lw	$3, 0($2)
# was:	lw	_patTuple__150_, 0(larger_arg__145_)
# 	ori	_patVar_n__151_,_patTuple__150_,0
	lw	$3, 4($2)
# was:	lw	_patTuple__152_, 4(larger_arg__145_)
	bne	$3, $0, _match__149_
# was:	bne	_patTuple__152_, 0, _match__149_
	ori	$17, $0, 0
# was:	ori	larger_res__146_, 0, 0
	j	larger_return__147_
_match__149_:
	beq	$2, $0, _match__153_
# was:	beq	larger_arg__145_, 0, _match__153_
	lw	$3, 0($2)
# was:	lw	_patTuple__154_, 0(larger_arg__145_)
# 	ori	_patVar_n__155_,_patTuple__154_,0
	lw	$2, 4($2)
# was:	lw	_patTuple__156_, 4(larger_arg__145_)
	beq	$2, $0, _match__153_
# was:	beq	_patTuple__156_, 0, _match__153_
	lw	$4, 0($2)
# was:	lw	_patTuple__157_, 0(_patTuple__156_)
# 	ori	_patVar_m__158_,_patTuple__157_,0
	lw	$2, 4($2)
# was:	lw	_patTuple__159_, 4(_patTuple__156_)
# 	ori	_patVar_l__160_,_patTuple__159_,0
# 	ori	_less1__165_,_patVar_m__158_,0
# 	ori	_less2__166_,_patVar_n__155_,0
	lui	$5, 0
# was:	lui	_not__164_, 0
	slt	$5, $4, $3
# was:	slt	_not__164_, _less1__165_, _less2__166_
	xori	$5, $5, 1
# was:	xori	_if__161_, _not__164_, 1
	beq	$5, $0, _elselabel__162_
# was:	beq	_if__161_, 0, _elselabel__162_
	addi	$16, $28, 0
# was:	addi	_compileTupleMem__169_, 28, 0
	addi	$17, $16, 0
# was:	addi	larger_res__146_, _compileTupleMem__169_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__171_,_patVar_m__158_,0
	sw	$4, 0($16)
# was:	sw	_compileTuple1__171_, 0(_compileTupleMem__169_)
	addi	$16, $16, 4
# was:	addi	_compileTupleMem__169_, _compileTupleMem__169_, 4
	addi	$5, $28, 0
# was:	addi	_compileTupleMem__176_, 28, 0
	addi	$4, $5, 0
# was:	addi	_apply__175_, _compileTupleMem__176_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__178_,_patVar_n__155_,0
	sw	$3, 0($5)
# was:	sw	_compileTuple1__178_, 0(_compileTupleMem__176_)
	addi	$5, $5, 4
# was:	addi	_compileTupleMem__176_, _compileTupleMem__176_, 4
# 	ori	_compileTuple1__180_,_patVar_l__160_,0
	sw	$2, 0($5)
# was:	sw	_compileTuple1__180_, 0(_compileTupleMem__176_)
	addi	$5, $5, 4
# was:	addi	_compileTupleMem__176_, _compileTupleMem__176_, 4
	ori	$2, $4, 0
# was:	ori	2, _apply__175_, 0
	jal	larger
# was:	jal	larger, 2
# 	ori	_compileTuple1__173_,2,0
	sw	$2, 0($16)
# was:	sw	_compileTuple1__173_, 0(_compileTupleMem__169_)
	addi	$16, $16, 4
# was:	addi	_compileTupleMem__169_, _compileTupleMem__169_, 4
	j	_exitlabel__163_
_elselabel__162_:
	addi	$4, $28, 0
# was:	addi	_compileTupleMem__183_, 28, 0
	addi	$5, $4, 0
# was:	addi	_apply__182_, _compileTupleMem__183_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__185_,_patVar_n__155_,0
	sw	$3, 0($4)
# was:	sw	_compileTuple1__185_, 0(_compileTupleMem__183_)
	addi	$4, $4, 4
# was:	addi	_compileTupleMem__183_, _compileTupleMem__183_, 4
# 	ori	_compileTuple1__187_,_patVar_l__160_,0
	sw	$2, 0($4)
# was:	sw	_compileTuple1__187_, 0(_compileTupleMem__183_)
	addi	$4, $4, 4
# was:	addi	_compileTupleMem__183_, _compileTupleMem__183_, 4
	ori	$2, $5, 0
# was:	ori	2, _apply__182_, 0
	jal	larger
# was:	jal	larger, 2
	ori	$17, $2, 0
# was:	ori	larger_res__146_, 2, 0
_exitlabel__163_:
	j	larger_return__147_
_match__153_:
	j	larger_fail__148_
larger_return__147_:
	ori	$2, $17, 0
# was:	ori	2, larger_res__146_, 0
	addi	$29, $29, 16
	lw	$17, -12($29)
	lw	$16, -8($29)
	lw	$31, -4($29)
	jr	$31
larger_fail__148_:
	ori	$5, $0, 35
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
