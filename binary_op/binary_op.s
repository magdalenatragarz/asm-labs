.text
.global	binary_op
.type	binary_op, @function

# %rdi - char* result
# %rsi - char* arg1
# %rdx - char* arg2
# %rcx - int operation

binary_op:
#-------------- LENGTH OF ARGS----------------#

	XOR 	%r8,	%r8 		#licznik do obliczenia długości
	
length_arg1:
	CMPB	$0,	(%rsi,%r8,1)	
	JE	numerize
	
	INC	%r8			# r8 to dlugosc 
	JMP 	length_arg1
/*
length_arg2:
	CMPB	$0,	(%rdx,%rbp,1)	
	JE	modify_l
	
	INC	%rbp			# rbp to dlugosc 
	JMP 	length_arg1
	
	
modify_l:
		
	CMP	%r8,	%rbp
	JE	numerize_b
	JG	popraw_pierwszy
	
	MOV	%r8,	%r10 	#mniejszy
	DEC	%r10	
	
	MOV	%rbp,	%r13
	DEC	%r13		#wiekszy
	
	
	
	modifier1:
		CMP 	$0,	%r10
		JL	przepiszx
		
		MOV	(%rsi,%r10,1),	%al
		MOV	%al,		(%rbx,%r13,1)
		DEC	%r13
		DEC	%r10
		JMP 	modifier1
			
		
	przepiszx:
		#MOV	%rbx,	%rdx	#rbx to tera jak rdx
		JMP numerize
		
numerize_b:
	MOV	%rdx,	%rbx
	MOV	%rsi,	%rbp	
		
	
	
popraw_pierwszy:
	
	MOV	%r8,	%r10 	#wiekszy
	DEC	%r10	
	
	MOV	%rbp,	%r13
	DEC	%r13		#mniejszy
	
	modifier2:
		CMP 	$0,	%r13
		JL	przepisz2
		
		MOV	(%rsi,%r13,1),	%al
		MOV	%al,		(%rbx,%r10,1)
		DEC	%r13
		DEC	%r10
		JMP	modifier2
			
		
	przepisz2:
		MOV	%rbx,	%rdx
		JMP numerize
		
		
*/	

numerize:
#-----------UTWORZENIE LICZB BINARNYCH--------------#
		
	XOR 	%r10,	%r10
			#miejsce dla numerka arg1
				
	MOV	%r8,	%r11		#licznik pętli do przejścia po wszystkich
	DEC	%r11
	
	XOR	%r13,	%r13		#maska
	MOVB	$1,	%r13b
	
numerize_arg1:	
	
	while_arg1:
		CMPB	$0,	%r11b 	#idziemy od tyłu, zaczynamy od końca			
		JL 	numerize_arg2
		
		CMPB	$'1',	(%rsi,%r11,1)
		JE	one_arg1
	zero_arg1:
		
		DEC 	%r11
		SHL	$1,	%r13
		JMP	while_arg1
		
	one_arg1:
		OR	%r13,	%r10
		SHL	$1,	%r13
		DEC 	%r11
		JMP	while_arg1
		
numerize_arg2:
	XOR	%r9,	%r9 			#arg2
	
	MOV	%r8,	%r11
	DEC 	%r11	
	
	XOR	%r13,	%r13			#maska
	MOVB	$1,	%r13b
	
			
	while_arg2:
		CMPB	$0,	%r11b	
		JL 	case0
		
		CMPB	$'1',	(%rdx,%r11,1)
		JE	one_arg2
	zero_arg2:
		
		DEC 	%r11
		SHL	$1,	%r13
		JMP	while_arg2
		
	one_arg2:
		OR	%r13,	%r9
		SHL	$1,	%r13
		DEC 	%r11
		JMP	while_arg2


#-----------ARG1 - R9, ARG2 - R10 (BINARNIE)--------------#
#-----------WSADZENIE DO R10 WYNIKU W ZALEZNOSCI OD CASE--------------#


case0:
	CMP	$0,	%rcx
	JNE	case1
		
	ADD	%r9,	%r10
	JMP end
	
case1:
	CMP	$1,	%rcx
	JNE	case2
		
	AND	%r9,	%r10
	JMP end
case2:
	CMP	$2,	%rcx
	JNE	case3
		
	OR	%r9,	%r10
	JMP end
case3:
	CMP	$3,	%rcx
	JNE	endend
		
	XOR	%r9,	%r10
	JMP end



end:	
	MOV	%r8,	%rbx
	DEC 	%rbx
	XOR	%r11,	%r11
	MOV	$'0',	%r15b	# char '0'
	MOV	$'1',	%r11b	# char '1'
	
	XOR	%r13,	%r13			#maska
	MOVB	$1,	%r13b	 
 	
przepisz:
	
	CMP	$0,	%rbx
	JL 	endend
	
	MOV	%r10,	%r9	# kopia wyniku
	AND	%r13,	%r9
	CMP	%r13,	%r9 	#maska ma wszedzie zera, jesli ten bit byl ustawiony to to bedzie rowna sobie
	JNE 	zeroResult
	
	MOV	%r11b,	(%rdi,%rbx,1)
	SHL	$1,	%r13
	
	DEC	%rbx
	JMP 	przepisz
	
zeroResult:
	MOV	%r15b,	(%rdi,%rbx,1)
	SHL	$1,		%r13
	DEC	%rbx
	JMP 	przepisz
	
	
endend:
	MOV	%rdi,	%rax

	RET
			
	
