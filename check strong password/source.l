%{
#include <stdlib.h>
#include <stdio.h>
_Bool display_input = 0;
void print(char*,int);
%}
digit [a-zA-Z !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~]
small [A-Z0-9 !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~]
capital [0-9a-z !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~]
special [0-9a-zA-Z]
%%

{digit}* 		{print(yytext,0);}
{small}+ 		{print(yytext,0);}
{capital}+ 		{print(yytext,0);}
{special}+ 		{print(yytext,0);}

.* 			{print(yytext,1);}

%%

void print(char *s,int type){
	if(display_input)
		printf("%s\n",s);
	switch(type){
		case 0: printf("Weak password\n"); break;
		case 1: printf("Strong password\n"); break;
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
		printf("Program to check whether a given password is strong or weak.\n\n");
		yylex();
		fclose(file);
	}else{
		printf("Program to check whether a given password is strong or weak.\n\n");
		yylex();
	}
	return 0;
}
