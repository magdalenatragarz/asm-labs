.text
.global	encode
.type	encode, @function

# %rdi - char* str
# %rsi - int charset
# %rdx - int case

# %r8 - zapiszemy tu wynik

encode:
	
	XOR	%r15,	%r15 			#licznik pętli
	XOR	%r14b,	%r14b			#rejestr pomocniczy, do dodawania i odejmowania
	XOR	%r13,	%r13			#rejestr na elementy
#CHARSET CHECKING
#----------- charset==0 -------------
	
charset0:
	CMP	$0,	%rsi			#(if carset==0)
	JNE	charset1			#else sprawdź kolejny charset
while0:
	CMPB	$0,	(%rdi,%r15,1)
	JE	check_case
	
	MOV	(%rdi,%r15,1),	%r13b
#----------------------------------
	
	CMP 	$'A',	%r13b
	JL	no_change0
	
	CMP	$'z',	%r13b
	JG	no_change0
	
	CMPB	$'a',	%r13b
	JGE	change_small0
	
	CMPB 	$'Z',	%r13b
	JLE	change_big0
	
	JMP 	no_change0	
	

change_big0:
	#MOV	(%rdi,%r15,1),	%r14b
	SUB	$'A',		%r13b
	MOV	$'Z',		%r14b
	SUB	%r13b,		%r14b
	MOV	%r14b,		(%rdi,%r15,1)
	INC	%r15
	JMP	while0

change_small0:
	SUB	$'a',		%r13b
	MOV	$'z',		%r14b
	SUB	%r13b,		%r14b
	MOV	%r14b,		(%rdi,%r15,1)
	INC	%r15
	JMP	while0
	
	
no_change0:
	#MOV	(%rdi,%r15,1),	%r14b
	#MOV	%r13b,		(%rdi,%r15,1)
	INC	%r15
	JMP 	while0		
	

#----------------------------------
#----------- charset==1 -------------	
charset1:
	CMP	$1,	%rsi			#(if carset==1)
	JNE	charset2			#else sprawdź kolejny charset
	
while3:
	CMPB	$0,	(%rdi,%r15,1)
	JE	check_case
	
	MOV	(%rdi,%r15,1),	%r13b
#----------------------------------
	
	CMP 	$'9',	%r13b
	JG	no_change3
	
	CMP	$'0',	%r13b
	JL	no_change3
	
	
	JMP 	change_nums	
	

change_nums:
	
	SUB	$'0',		%r13b
	MOV	$'9',		%r14b
	SUB	%r13b,		%r14b
	MOV	%r14b,		(%rdi,%r15,1)
	INC	%r15
	JMP	while3
	
no_change3:

	INC	%r15
	JMP 	while3		
	

#----------------------------------
#----------- charset==2 -------------
charset2:
	CMP	$2,	%rsi			#(if carset==2)
	JNE	end			#else nie ma już co sprawdzać
	
while4:
	CMPB	$0,	(%rdi,%r15,1)
	JE	check_case
	
	MOV	(%rdi,%r15,1),	%r13b
#----------------------------------
	
	CMP	$'0',	%r13b
	JL	no_change4
	
	CMP 	$'9',	%r13b
	JLE	change_nums2
	
	CMP 	$'A',	%r13b
	JL	no_change4
	
	CMP	$'z',	%r13b
	JG	no_change4
	
	CMPB	$'a',	%r13b
	JGE	change_small2
	
	CMPB 	$'Z',	%r13b
	JLE	change_big2
	
	JMP 	no_change4
	
change_big2:
	SUB	$'A',		%r13b
	MOV	$'Z',		%r14b
	SUB	%r13b,		%r14b
	MOV	%r14b,		(%rdi,%r15,1)
	INC	%r15
	JMP	while4

change_small2:
	SUB	$'a',		%r13b
	MOV	$'z',		%r14b
	SUB	%r13b,		%r14b
	MOV	%r14b,		(%rdi,%r15,1)
	INC	%r15
	JMP	while4	


change_nums2:	
	SUB	$'0',		%r13b
	MOV	$'9',		%r14b
	SUB	%r13b,		%r14b
	MOV	%r14b,		(%rdi,%r15,1)
	INC	%r15
	JMP	while4
	
no_change4:

	INC	%r15
	JMP 	while4	
	
#----------------------------------
#CASE CHECKING
check_case:
	MOV	$'0',	%r14b
	XOR	%r15,	%r15 
	XOR	%r13,	%r13
#----------------------------------

case0:
	CMP	$0,	%rdx
	JNE	case1
	JMP	end
#----------------------------------
case1:
	CMP	$1,	%rdx
	JNE	case2
	
while1:
	CMPB	$0,	(%rdi,%r15,1)
	JE	end
	
	MOV	(%rdi,%r15,1),	%r13b
	
	CMP 	$'A',	%r13b
	JL	no_change1
	
	CMP	$'z',	%r13b
	JG	no_change1
	
	CMPB	$'a',	%r13b
	JGE	change_to_big
	
	
	JMP 	no_change1
	
	
no_change1:
	INC	%r15
	JMP	while1
	
change_to_big:
	SUB	$32,		%r13b
	MOV	%r13b,		(%rdi,%r15,1)
	INC	%r15
	JMP	while1
		
#----------------------------------
case2:	
	CMP	$2,	%rdx
	JNE	end
	
while2:
	CMPB	$0,	(%rdi,%r15,1)
	JE	end
	
	MOV	(%rdi,%r15,1),	%r13b
	
	CMP 	$'A',	%r13b
	JL	no_change2
	
	CMP	$'z',	%r13b
	JG	no_change2
	
	CMPB	$'a',	%r13b
	JGE	no_change2
	
	CMPB 	$'Z',	%r13b
	JLE	change_to_small	
	
	JMP 	no_change2
	
	
no_change2:
	INC	%r15
	JMP	while2
	
change_to_small:
	ADD	$32,		%r13b
	MOV	%r13b,		(%rdi,%r15,1)
	INC	%r15
	JMP	while2
#----------------------------------

end:	
	MOV	%rdi,	%rax
	RET
