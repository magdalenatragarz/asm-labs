#include <stdio.h>
#include <stdlib.h>
int* intcpy (int* buf, int len, int* a){
		
	for (int i = 0; i < len; ++i){
		buf[i] = a[i];
	}
	return buf;	
}

int* intcpy_asm(int* buf, int len, int* a);
	
void main( void ) {
	
	int tab[] = {78,85,2,444,6,1,1,2};
	int len = 8;
	
	int * copy = malloc(len);
	int * copy_asm = malloc(len);

	printf("Orginal: {");
	for (int  i = 0; i<len; ++i){
		printf("%d ",tab[i]);
	}
	printf("}\n");
	//==============================================
	copy = intcpy(copy, len, tab);
	
	printf("Copy C: {");
	for (int  i = 0; i<len; ++i){
		printf("%d ",copy[i]);
	}
	printf("}\n");
	//==============================================
	
	copy_asm = intcpy_asm(copy_asm, len, tab);
	printf("Copy ASM: {");
	for (int  i = 0; i<len; ++i){
		printf("%d ",copy_asm[i]);
	}
	printf("}\n");
	//free(copy);
	
}


