%{
#include <stdlib.h>
#include <stdio.h>
_Bool display_input = 0;
void print(char*,int);
%}
hex [0-9a-fA-F]

%%

{hex}+ 		{print(yytext,0);}

.* 		{print(yytext,1);}

%%

void print(char *s,int type){
	if(display_input)
		printf("%s\n",s);
	switch(type){
		case 0: printf("It is Hexadecimal\n"); break;
		case 1: printf("Invalid Hexadecimal\n"); break;
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
		printf("Program to check whether a given number is hexadecimal or not.\n\n");
		yylex();
		fclose(file);
	}else{
		printf("Program to check whether a given number is hexadecimal or not.\n\n");
		yylex();
	}
	return 0;
}
