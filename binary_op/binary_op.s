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

length:
	CMPB	$0,	(%rsi,%r8,1)	
	JE	numerize
	
	INC	%r8			# r8 to dlugosc 
	JMP 	length

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
		JE 	numerize_arg2
		
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
		JE 	end
		
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
			
end:
	AND	%r9,	%r10
	
	MOV	%r8,	%rbx
	DEC 	%rbx
	MOV	$'0',	%r15b	# char '0'
	MOV	$'1',	%r11b	# char '1'
	
	XOR	%r13,	%r13			#maska
	MOVB	$1,	%r13b	 
 	
przepisz:
	
	CMPB	$0,	%bl
	JE 	endend
	
	MOV	%r10,	%r9	# kopia wyniku
	AND	%r13,	%r9
	CMP	%r13,	%r15 	#maska ma wszedzie zera, jesli ten bit byl ustawiony to to bedzie rowna sobie
	JNE 	zeroResult
	
	MOV	%r11b,	(%rdi,%rbx,1)
	SHL	$1,		%r13
	DEC	%rbx
	JMP 	przepisz
	
zeroResult:
	MOV	%r15b,	(%rdi,%rbx,1)
	SHL	$1,		%r13
	DEC	%rbx
	JMP 	przepisz
	
	
endend:
	MOV	%rdi,	%rdi

	RET
			
		
	/*while_arg2:
		CMPB	$0,	(%rdx,%r12,1)	
		JE 	case0
		
		CMPB	$'1',	(%rsi,%r12,1)
		JE	jedynka2
	zero2:
		MOV	%r14d,	(%r11,%r12,4)
		INC 	%r12
		JMP	while_arg1
		
	jedynka2:
		MOV	%r13d,	(%r11,%r12,4)
		INC 	%r12
		JMP	while_arg1	
		
		
		
		
		
		
		
		
		
		
		
/*
		
#======= ADD
		
case0:
	#CMP 	$0,	%cl
	#JNE 	case1	
	

	MOV	%r10, %rax
	RET
	
	
	
		
#======= AND
case1:
	CMP 	$1,	%cl
	JNE 	case2

#======= OR
case2:
	CMP 	$2,	%cl
	JNE 	case3

#======= XOR
case3:
	CMP 	$3,	%cl
	RET*/
