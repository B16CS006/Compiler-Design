%{
#include <stdlib.h>
#include <stdio.h>
_Bool display_input = 0;
void print(char*,int);
%}

digit [0-9]
dot [\.]

%%

[+]?{digit}+ 					{print(yytext,0);}

[-]{digit}+ 					{print(yytext,1);}

[+-]?{digit}*{dot}{digit}+ 			{print(yytext,2);}

[+]?{digit}+[Ee][+-]?{digit}+ 			{print(yytext,3);}

[-]{digit}+[Ee][+-]?{digit}+ 			{print(yytext,4);}

[+-]?{digit}*{dot}{digit}+[Ee][+-]?{digit}+ 	{print(yytext,5);}

.* 						{print(yytext,6);}

%%

void print(char *s,int type){
	if(display_input)
		printf("%s\n",s);
	switch(type){
		case 0: printf("Positive Integer\n"); break;
		case 1:	printf("Negative Integer\n"); break;
		case 2: printf("Real Number\n"); break;
		case 3: printf("Positive Integer with Exponent\n"); break;
		case 4: printf("Negative Integer with Exponent\n"); break;
		case 5: printf("Real Number with exponent\n"); break;
		case 6: printf("It is neither Integer nor Float\n"); break;
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
		printf("Program to check the type of the Number.\n\n");
		yylex();
		fclose(file);
	}else{
		printf("Program to check the type of the Number.\n\n");
		yylex();
	}
	return 0;
}
