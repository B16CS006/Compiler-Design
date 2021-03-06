%{
#include <stdlib.h>
#include <stdio.h>
_Bool display_input = 0;
void print(char*,int);
%}
bin [0-1]

%%

{bin}+ 		{print(yytext,0);}

.* 		{print(yytext,1);}

%%

void print(char *s,int type){
	if(display_input)
		printf("%s\n",s);
	switch(type){
		case 0: printf("Binary\n"); break;
		case 1: printf("Invalid Binary Nubmer\n"); break;
	}
}

int main(int argc, char* argv[]){
	if(argc>2){
		printf("%s: fatal error: too many arguments\n",argv[0]);
		return 0;
	}
	
	if(argc == 2){
		display_input = 1;
		FILE *file;
		if(!(file = fopen(argv[1],"r"))){
			printf("error: %s file don't exist\n",argv[1]);
			return -1;
		}
		yyset_in(file);
		printf("Program to check whether a given number is binary or not.\n\n");
		yylex();
		fclose(file);
	}else{
		printf("Program to check whether a given number is binary or not.\n\n");
		yylex();
	}
	return 0;
}
