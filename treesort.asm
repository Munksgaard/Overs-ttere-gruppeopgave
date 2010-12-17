	.text	0x00400000
	.globl	main
main:
	la	$28, _heap_
	ori	$2, $0, 5
# was:	ori	2, 0, 5
	syscall
# 	ori	_apply__187_,2,0
# 	ori	2,_apply__187_,0
	jal	readList
# was:	jal	readList, 2
# 	ori	_apply__186_,2,0
# 	ori	2,_apply__186_,0
	jal	tsort
# was:	jal	tsort, 2
# 	ori	_apply__185_,2,0
# 	ori	2,_apply__185_,0
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
	ori	$5, $0, 15
	j	_Error_
# 
printList:
	sw	$31, -4($29)
	addi	$29, $29, -8
# 	ori	printList_arg__18_,2,0
	bne	$2, $0, _match__22_
# was:	bne	printList_arg__18_, 0, _match__22_
	ori	$2, $0, 1
# was:	ori	printList_res__19_, 0, 1
	j	printList_return__20_
_match__22_:
	beq	$2, $0, _match__23_
# was:	beq	printList_arg__18_, 0, _match__23_
	lw	$6, 0($2)
# was:	lw	_patTuple__24_, 0(printList_arg__18_)
# 	ori	_patVar_n__25_,_patTuple__24_,0
	lw	$3, 4($2)
# was:	lw	_patTuple__26_, 4(printList_arg__18_)
# 	ori	_patVar_l__27_,_patTuple__26_,0
# 	ori	_dec__31_,_patVar_n__25_,0
	ori	$4, $6, 0
# was:	ori	4, _dec__31_, 0
	ori	$2, $0, 1
# was:	ori	2, 0, 1
	syscall
	la	$4, _cr_
# was:	la	4, _cr_
	ori	$2, $0, 4
# was:	ori	2, 0, 4
	syscall
# 	ori	_patVar_t__32_,_dec__31_,0
	ori	$2, $3, 0
# was:	ori	_apply__33_, _patVar_l__27_, 0
# 	ori	2,_apply__33_,0
	jal	printList
# was:	jal	printList, 2
# 	ori	printList_res__19_,2,0
	j	printList_return__20_
_match__23_:
	j	printList_fail__21_
printList_return__20_:
# 	ori	2,printList_res__19_,0
	addi	$29, $29, 8
	lw	$31, -4($29)
	jr	$31
printList_fail__21_:
	ori	$5, $0, 20
	j	_Error_
# 
insert:
	sw	$31, -4($29)
	sw	$19, -20($29)
	sw	$18, -16($29)
	sw	$17, -12($29)
	sw	$16, -8($29)
	addi	$29, $29, -24
	ori	$3, $2, 0
# was:	ori	insert_arg__34_, 2, 0
	beq	$3, $0, _match__38_
# was:	beq	insert_arg__34_, 0, _match__38_
	lw	$2, 0($3)
# was:	lw	_patTuple__39_, 0(insert_arg__34_)
	bne	$2, $0, _match__38_
# was:	bne	_patTuple__39_, 0, _match__38_
	lw	$3, 4($3)
# was:	lw	_patTuple__40_, 4(insert_arg__34_)
# 	ori	_patVar_n__41_,_patTuple__40_,0
	addi	$2, $28, 0
# was:	addi	_compileTupleMem__42_, 28, 0
	addi	$18, $2, 0
# was:	addi	insert_res__35_, _compileTupleMem__42_, 0
	addi	$28, $28, 12
# was:	addi	28, 28, 12
	ori	$4, $0, 0
# was:	ori	_compileTuple1__44_, 0, 0
	sw	$4, 0($2)
# was:	sw	_compileTuple1__44_, 0(_compileTupleMem__42_)
	addi	$2, $2, 4
# was:	addi	_compileTupleMem__42_, _compileTupleMem__42_, 4
# 	ori	_compileTuple1__46_,_patVar_n__41_,0
	sw	$3, 0($2)
# was:	sw	_compileTuple1__46_, 0(_compileTupleMem__42_)
	addi	$2, $2, 4
# was:	addi	_compileTupleMem__42_, _compileTupleMem__42_, 4
	ori	$3, $0, 0
# was:	ori	_compileTuple1__48_, 0, 0
	sw	$3, 0($2)
# was:	sw	_compileTuple1__48_, 0(_compileTupleMem__42_)
	addi	$2, $2, 4
# was:	addi	_compileTupleMem__42_, _compileTupleMem__42_, 4
	j	insert_return__36_
_match__38_:
	beq	$3, $0, _match__50_
# was:	beq	insert_arg__34_, 0, _match__50_
	lw	$4, 0($3)
# was:	lw	_patTuple__51_, 0(insert_arg__34_)
	beq	$4, $0, _match__50_
# was:	beq	_patTuple__51_, 0, _match__50_
	lw	$2, 0($4)
# was:	lw	_patTuple__52_, 0(_patTuple__51_)
# 	ori	_patVar_t1__53_,_patTuple__52_,0
	lw	$17, 4($4)
# was:	lw	_patTuple__54_, 4(_patTuple__51_)
# 	ori	_patVar_m__55_,_patTuple__54_,0
	lw	$16, 8($4)
# was:	lw	_patTuple__56_, 8(_patTuple__51_)
# 	ori	_patVar_t2__57_,_patTuple__56_,0
	lw	$3, 4($3)
# was:	lw	_patTuple__58_, 4(insert_arg__34_)
# 	ori	_patVar_n__59_,_patTuple__58_,0
# 	ori	_less1__63_,_patVar_n__59_,0
# 	ori	_less2__64_,_patVar_m__55_,0
	lui	$4, 0
# was:	lui	_if__60_, 0
	slt	$4, $3, $17
# was:	slt	_if__60_, _less1__63_, _less2__64_
	beq	$4, $0, _elselabel__61_
# was:	beq	_if__60_, 0, _elselabel__61_
	addi	$19, $28, 0
# was:	addi	_compileTupleMem__67_, 28, 0
	addi	$18, $19, 0
# was:	addi	insert_res__35_, _compileTupleMem__67_, 0
	addi	$28, $28, 12
# was:	addi	28, 28, 12
	addi	$4, $28, 0
# was:	addi	_compileTupleMem__72_, 28, 0
	addi	$5, $4, 0
# was:	addi	_apply__71_, _compileTupleMem__72_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__74_,_patVar_t1__53_,0
	sw	$2, 0($4)
# was:	sw	_compileTuple1__74_, 0(_compileTupleMem__72_)
	addi	$4, $4, 4
# was:	addi	_compileTupleMem__72_, _compileTupleMem__72_, 4
# 	ori	_compileTuple1__76_,_patVar_n__59_,0
	sw	$3, 0($4)
# was:	sw	_compileTuple1__76_, 0(_compileTupleMem__72_)
	addi	$4, $4, 4
# was:	addi	_compileTupleMem__72_, _compileTupleMem__72_, 4
	ori	$2, $5, 0
# was:	ori	2, _apply__71_, 0
	jal	insert
# was:	jal	insert, 2
# 	ori	_compileTuple1__69_,2,0
	sw	$2, 0($19)
# was:	sw	_compileTuple1__69_, 0(_compileTupleMem__67_)
	addi	$19, $19, 4
# was:	addi	_compileTupleMem__67_, _compileTupleMem__67_, 4
# 	ori	_compileTuple1__78_,_patVar_m__55_,0
	sw	$17, 0($19)
# was:	sw	_compileTuple1__78_, 0(_compileTupleMem__67_)
	addi	$19, $19, 4
# was:	addi	_compileTupleMem__67_, _compileTupleMem__67_, 4
# 	ori	_compileTuple1__80_,_patVar_t2__57_,0
	sw	$16, 0($19)
# was:	sw	_compileTuple1__80_, 0(_compileTupleMem__67_)
	addi	$19, $19, 4
# was:	addi	_compileTupleMem__67_, _compileTupleMem__67_, 4
	j	_exitlabel__62_
_elselabel__61_:
	addi	$19, $28, 0
# was:	addi	_compileTupleMem__82_, 28, 0
	addi	$18, $19, 0
# was:	addi	insert_res__35_, _compileTupleMem__82_, 0
	addi	$28, $28, 12
# was:	addi	28, 28, 12
# 	ori	_compileTuple1__84_,_patVar_t1__53_,0
	sw	$2, 0($19)
# was:	sw	_compileTuple1__84_, 0(_compileTupleMem__82_)
	addi	$19, $19, 4
# was:	addi	_compileTupleMem__82_, _compileTupleMem__82_, 4
# 	ori	_compileTuple1__86_,_patVar_m__55_,0
	sw	$17, 0($19)
# was:	sw	_compileTuple1__86_, 0(_compileTupleMem__82_)
	addi	$19, $19, 4
# was:	addi	_compileTupleMem__82_, _compileTupleMem__82_, 4
	addi	$2, $28, 0
# was:	addi	_compileTupleMem__91_, 28, 0
	addi	$4, $2, 0
# was:	addi	_apply__90_, _compileTupleMem__91_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__93_,_patVar_t2__57_,0
	sw	$16, 0($2)
# was:	sw	_compileTuple1__93_, 0(_compileTupleMem__91_)
	addi	$2, $2, 4
# was:	addi	_compileTupleMem__91_, _compileTupleMem__91_, 4
# 	ori	_compileTuple1__95_,_patVar_n__59_,0
	sw	$3, 0($2)
# was:	sw	_compileTuple1__95_, 0(_compileTupleMem__91_)
	addi	$2, $2, 4
# was:	addi	_compileTupleMem__91_, _compileTupleMem__91_, 4
	ori	$2, $4, 0
# was:	ori	2, _apply__90_, 0
	jal	insert
# was:	jal	insert, 2
# 	ori	_compileTuple1__88_,2,0
	sw	$2, 0($19)
# was:	sw	_compileTuple1__88_, 0(_compileTupleMem__82_)
	addi	$19, $19, 4
# was:	addi	_compileTupleMem__82_, _compileTupleMem__82_, 4
_exitlabel__62_:
	j	insert_return__36_
_match__50_:
	j	insert_fail__37_
insert_return__36_:
	ori	$2, $18, 0
# was:	ori	2, insert_res__35_, 0
	addi	$29, $29, 24
	lw	$19, -20($29)
	lw	$18, -16($29)
	lw	$17, -12($29)
	lw	$16, -8($29)
	lw	$31, -4($29)
	jr	$31
insert_fail__37_:
	ori	$5, $0, 25
	j	_Error_
# 
flatten:
	sw	$31, -4($29)
	sw	$19, -20($29)
	sw	$18, -16($29)
	sw	$17, -12($29)
	sw	$16, -8($29)
	addi	$29, $29, -24
# 	ori	flatten_arg__97_,2,0
	beq	$2, $0, _match__101_
# was:	beq	flatten_arg__97_, 0, _match__101_
	lw	$3, 0($2)
# was:	lw	_patTuple__102_, 0(flatten_arg__97_)
	bne	$3, $0, _match__101_
# was:	bne	_patTuple__102_, 0, _match__101_
	lw	$2, 4($2)
# was:	lw	_patTuple__103_, 4(flatten_arg__97_)
# 	ori	_patVar_l__104_,_patTuple__103_,0
# 	ori	flatten_res__98_,_patVar_l__104_,0
	j	flatten_return__99_
_match__101_:
	beq	$2, $0, _match__105_
# was:	beq	flatten_arg__97_, 0, _match__105_
	lw	$3, 0($2)
# was:	lw	_patTuple__106_, 0(flatten_arg__97_)
	beq	$3, $0, _match__105_
# was:	beq	_patTuple__106_, 0, _match__105_
	lw	$5, 0($3)
# was:	lw	_patTuple__107_, 0(_patTuple__106_)
# 	ori	_patVar_t1__108_,_patTuple__107_,0
	lw	$4, 4($3)
# was:	lw	_patTuple__109_, 4(_patTuple__106_)
# 	ori	_patVar_n__110_,_patTuple__109_,0
	lw	$3, 8($3)
# was:	lw	_patTuple__111_, 8(_patTuple__106_)
# 	ori	_patVar_t2__112_,_patTuple__111_,0
	lw	$2, 4($2)
# was:	lw	_patTuple__113_, 4(flatten_arg__97_)
# 	ori	_patVar_l__114_,_patTuple__113_,0
	addi	$17, $28, 0
# was:	addi	_compileTupleMem__116_, 28, 0
	addi	$16, $17, 0
# was:	addi	_apply__115_, _compileTupleMem__116_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__118_,_patVar_t1__108_,0
	sw	$5, 0($17)
# was:	sw	_compileTuple1__118_, 0(_compileTupleMem__116_)
	addi	$17, $17, 4
# was:	addi	_compileTupleMem__116_, _compileTupleMem__116_, 4
	addi	$19, $28, 0
# was:	addi	_compileTupleMem__122_, 28, 0
	addi	$18, $19, 0
# was:	addi	_compileTuple1__120_, _compileTupleMem__122_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__124_,_patVar_n__110_,0
	sw	$4, 0($19)
# was:	sw	_compileTuple1__124_, 0(_compileTupleMem__122_)
	addi	$19, $19, 4
# was:	addi	_compileTupleMem__122_, _compileTupleMem__122_, 4
	addi	$5, $28, 0
# was:	addi	_compileTupleMem__129_, 28, 0
	addi	$4, $5, 0
# was:	addi	_apply__128_, _compileTupleMem__129_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__131_,_patVar_t2__112_,0
	sw	$3, 0($5)
# was:	sw	_compileTuple1__131_, 0(_compileTupleMem__129_)
	addi	$5, $5, 4
# was:	addi	_compileTupleMem__129_, _compileTupleMem__129_, 4
# 	ori	_compileTuple1__133_,_patVar_l__114_,0
	sw	$2, 0($5)
# was:	sw	_compileTuple1__133_, 0(_compileTupleMem__129_)
	addi	$5, $5, 4
# was:	addi	_compileTupleMem__129_, _compileTupleMem__129_, 4
	ori	$2, $4, 0
# was:	ori	2, _apply__128_, 0
	jal	flatten
# was:	jal	flatten, 2
# 	ori	_compileTuple1__126_,2,0
	sw	$2, 0($19)
# was:	sw	_compileTuple1__126_, 0(_compileTupleMem__122_)
	addi	$19, $19, 4
# was:	addi	_compileTupleMem__122_, _compileTupleMem__122_, 4
	sw	$18, 0($17)
# was:	sw	_compileTuple1__120_, 0(_compileTupleMem__116_)
	addi	$17, $17, 4
# was:	addi	_compileTupleMem__116_, _compileTupleMem__116_, 4
	ori	$2, $16, 0
# was:	ori	2, _apply__115_, 0
	jal	flatten
# was:	jal	flatten, 2
# 	ori	flatten_res__98_,2,0
	j	flatten_return__99_
_match__105_:
	j	flatten_fail__100_
flatten_return__99_:
# 	ori	2,flatten_res__98_,0
	addi	$29, $29, 24
	lw	$19, -20($29)
	lw	$18, -16($29)
	lw	$17, -12($29)
	lw	$16, -8($29)
	lw	$31, -4($29)
	jr	$31
flatten_fail__100_:
	ori	$5, $0, 32
	j	_Error_
# 
tsort:
	sw	$31, -4($29)
	sw	$17, -12($29)
	sw	$16, -8($29)
	addi	$29, $29, -16
# 	ori	tsort_arg__135_,2,0
	ori	$4, $2, 0
# was:	ori	_patVar_l__140_, tsort_arg__135_, 0
	addi	$16, $28, 0
# was:	addi	_compileTupleMem__142_, 28, 0
	addi	$17, $16, 0
# was:	addi	_apply__141_, _compileTupleMem__142_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
	addi	$3, $28, 0
# was:	addi	_compileTupleMem__147_, 28, 0
	addi	$2, $3, 0
# was:	addi	_apply__146_, _compileTupleMem__147_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__149_,_patVar_l__140_,0
	sw	$4, 0($3)
# was:	sw	_compileTuple1__149_, 0(_compileTupleMem__147_)
	addi	$3, $3, 4
# was:	addi	_compileTupleMem__147_, _compileTupleMem__147_, 4
	ori	$4, $0, 0
# was:	ori	_compileTuple1__151_, 0, 0
	sw	$4, 0($3)
# was:	sw	_compileTuple1__151_, 0(_compileTupleMem__147_)
	addi	$3, $3, 4
# was:	addi	_compileTupleMem__147_, _compileTupleMem__147_, 4
# 	ori	2,_apply__146_,0
	jal	insertAll
# was:	jal	insertAll, 2
# 	ori	_compileTuple1__144_,2,0
	sw	$2, 0($16)
# was:	sw	_compileTuple1__144_, 0(_compileTupleMem__142_)
	addi	$16, $16, 4
# was:	addi	_compileTupleMem__142_, _compileTupleMem__142_, 4
	ori	$2, $0, 0
# was:	ori	_compileTuple1__153_, 0, 0
	sw	$2, 0($16)
# was:	sw	_compileTuple1__153_, 0(_compileTupleMem__142_)
	addi	$16, $16, 4
# was:	addi	_compileTupleMem__142_, _compileTupleMem__142_, 4
	ori	$2, $17, 0
# was:	ori	2, _apply__141_, 0
	jal	flatten
# was:	jal	flatten, 2
# 	ori	tsort_res__136_,2,0
	j	tsort_return__137_
_match__139_:
	j	tsort_fail__138_
tsort_return__137_:
# 	ori	2,tsort_res__136_,0
	addi	$29, $29, 16
	lw	$17, -12($29)
	lw	$16, -8($29)
	lw	$31, -4($29)
	jr	$31
tsort_fail__138_:
	ori	$5, $0, 37
	j	_Error_
# 
insertAll:
	sw	$31, -4($29)
	sw	$17, -12($29)
	sw	$16, -8($29)
	addi	$29, $29, -16
	ori	$3, $2, 0
# was:	ori	insertAll_arg__155_, 2, 0
	beq	$3, $0, _match__159_
# was:	beq	insertAll_arg__155_, 0, _match__159_
	lw	$2, 0($3)
# was:	lw	_patTuple__160_, 0(insertAll_arg__155_)
	bne	$2, $0, _match__159_
# was:	bne	_patTuple__160_, 0, _match__159_
	lw	$2, 4($3)
# was:	lw	_patTuple__161_, 4(insertAll_arg__155_)
# 	ori	_patVar_t__162_,_patTuple__161_,0
# 	ori	insertAll_res__156_,_patVar_t__162_,0
	j	insertAll_return__157_
_match__159_:
	beq	$3, $0, _match__163_
# was:	beq	insertAll_arg__155_, 0, _match__163_
	lw	$4, 0($3)
# was:	lw	_patTuple__164_, 0(insertAll_arg__155_)
	beq	$4, $0, _match__163_
# was:	beq	_patTuple__164_, 0, _match__163_
	lw	$2, 0($4)
# was:	lw	_patTuple__165_, 0(_patTuple__164_)
# 	ori	_patVar_n__166_,_patTuple__165_,0
	lw	$4, 4($4)
# was:	lw	_patTuple__167_, 4(_patTuple__164_)
# 	ori	_patVar_l__168_,_patTuple__167_,0
	lw	$3, 4($3)
# was:	lw	_patTuple__169_, 4(insertAll_arg__155_)
# 	ori	_patVar_t__170_,_patTuple__169_,0
	addi	$16, $28, 0
# was:	addi	_compileTupleMem__172_, 28, 0
	addi	$17, $16, 0
# was:	addi	_apply__171_, _compileTupleMem__172_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__174_,_patVar_l__168_,0
	sw	$4, 0($16)
# was:	sw	_compileTuple1__174_, 0(_compileTupleMem__172_)
	addi	$16, $16, 4
# was:	addi	_compileTupleMem__172_, _compileTupleMem__172_, 4
	addi	$5, $28, 0
# was:	addi	_compileTupleMem__179_, 28, 0
	addi	$4, $5, 0
# was:	addi	_apply__178_, _compileTupleMem__179_, 0
	addi	$28, $28, 8
# was:	addi	28, 28, 8
# 	ori	_compileTuple1__181_,_patVar_t__170_,0
	sw	$3, 0($5)
# was:	sw	_compileTuple1__181_, 0(_compileTupleMem__179_)
	addi	$5, $5, 4
# was:	addi	_compileTupleMem__179_, _compileTupleMem__179_, 4
# 	ori	_compileTuple1__183_,_patVar_n__166_,0
	sw	$2, 0($5)
# was:	sw	_compileTuple1__183_, 0(_compileTupleMem__179_)
	addi	$5, $5, 4
# was:	addi	_compileTupleMem__179_, _compileTupleMem__179_, 4
	ori	$2, $4, 0
# was:	ori	2, _apply__178_, 0
	jal	insert
# was:	jal	insert, 2
# 	ori	_compileTuple1__176_,2,0
	sw	$2, 0($16)
# was:	sw	_compileTuple1__176_, 0(_compileTupleMem__172_)
	addi	$16, $16, 4
# was:	addi	_compileTupleMem__172_, _compileTupleMem__172_, 4
	ori	$2, $17, 0
# was:	ori	2, _apply__171_, 0
	jal	insertAll
# was:	jal	insertAll, 2
# 	ori	insertAll_res__156_,2,0
	j	insertAll_return__157_
_match__163_:
	j	insertAll_fail__158_
insertAll_return__157_:
# 	ori	2,insertAll_res__156_,0
	addi	$29, $29, 16
	lw	$17, -12($29)
	lw	$16, -8($29)
	lw	$31, -4($29)
	jr	$31
insertAll_fail__158_:
	ori	$5, $0, 41
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
