#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char* cpy(char* buf, char* a); 
// chcemy przepisać a do bufora, pamięc alokowana w mainie, zakładamy tą samą wielkość

char* cpy_c(char* buf, char* a){
	int i = 0;
	while(a[i]!=0){
		buf[i] = a[i];
		i++;
	}	
	return buf;
}


int main(void){

    char a[] ="bbbb";
    char *bufC;
    char *bufA;
    
    int n = strlen(a);
    
    bufC = malloc(n);
    printf("c %s\n",cpy_c(bufC,a));
    
    bufA = malloc(n);
    printf("a %s\n",cpy(bufA,a));
    
    free(bufC);
	free(bufA);
}
