.text
        .type intcpy_asm, @function
        .global intcpy_asm
        
#rdi buf
#rsi len
#rdx a

intcpy_asm:
	XOR	%r9,	%r9	#counter
	MOV	%esi,	%r10d
while:	
	CMP	%r10d,	%r9d	#sprawdzanie licznika i długości
	JE 	end
	
	MOV	(%rdx,%r9,4),	%r8d
	MOV	%r8d,		(%rdi,%r9,4)

	INC	%r9d
	JMP 	while
	
end:
	MOV	%rdi,	%rax
	RET
	
	
