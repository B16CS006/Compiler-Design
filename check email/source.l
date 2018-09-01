%{
#include <stdlib.h>
#include <stdio.h>
_Bool display_input = 0;
void print(char*,int);
%}

all [0-9a-zA-Z_@\.]
username [0-9a-zA-Z_\.]
domain [0-9a-zA-Z\.]
dot [\.]
consicute [\.][\.]

%%
{all}*{consicute}+{all}*		{print(yytext,0);}

{dot}{all}*				{print(yytext,0);}
{all}*{dot}				{print(yytext,0);}

{username}+{dot}[@]{domain}+		{print(yytext,0);}
{username}+[@]{dot}{domain}+		{print(yytext,0);}

{username}+[@]{domain}+{dot}{domain}+	{print(yytext,1);}

.*					{print(yytext,0);}
%% 

void print(char *s,int type){
	if(display_input)
		printf("%s\n",s);
	switch(type){
		case 0: printf("Invalid Email id\n"); break;
		case 1: printf("Valid Email id\n"); break;
	}
}

int main(int argc, char* argv[]){
	if(argc>2){
		printf("%s: fatal error: too many arguments\n",argv[0]);
		return 0;
	}else if(argc == 2){
		display_input = 1;
		FILE *file;
		if(!(file = fopen(argv[1],"r"))){
			printf("error: %s file don't exist\n",argv[1]);
			return -1;
		}
		yyset_in(file);
		printf("Program to check whether a given email address is valid or not.\n\n");
		yylex();
		fclose(file);
	}else{
		printf("Program to check whether a given email address is valid or not.\n\n");
		yylex();
	}
	return 0;
}
