.text
        .type cpy, @function
        .global cpy
        
#rdi buf
#rsi a

cpy:
	XOR 	%r8,	%r8 			#int i = 0;
	
	XOR	%r9b,	%r9b			#tmp na znaki
	
while:
	CMPB 	$0,	(%rsi,%r8,1)		#sprawdzenie warunku pętli, sprawdzamy tylko bajta
	JE	end		
	
	MOV	(%rsi,%r8,1),	%r9b		#jeśli ok i jestesmy jeszcze w petli to przepisz tego bajta w to samo miejsce w tablicy
	MOV	%r9b,		(%rdi,%r8,1)
	
	INC	%r8				#licznik inkrementuj
	JMP 	while
	
end:
	MOV 	%rdi, 	%rax
	RET
	
	
	
