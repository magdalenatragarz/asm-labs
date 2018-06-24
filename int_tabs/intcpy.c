#include <stdio.h>
#include <stdlib.h>
int* intcpy (int* buf, int len, int* a){
		
	for (int i = 0; i < len; ++i){
		a[i] = buf[i];
	}
	return buf;	
}

int* intcpy_asm(int* buf, int len, int* a);
	
void main( void ) {
	
	int tab[] = {0,0,0,1,1,1,1,2};
	int len = 8;
	
	int * copy = malloc(len);

	printf("Orginal: {");
	for (int  i = 0; i<len; ++i){
		printf("%d ",tab[i]);
	}
	printf("}\n");
	copy = intcpy(tab, len, copy);
	
	printf("Copy: {");
	for (int  i = 0; i<len; ++i){
		printf("%d ",copy[i]);
	}
	printf("}\n");
	//free(copy);
	
}
