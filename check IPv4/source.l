%{
#include <stdlib.h>
#include <stdio.h>
_Bool display_input = 0;
void print(char*,int);
void ipv4(char[]);
%}

num [0-9]
dot [\.]

%%

{num}+{dot}{num}+{dot}{num}+{dot}{num}+ 	{ipv4(yytext);}

.* 						{print(yytext,1);}

%%

void ipv4(char s[]){
	int number = 0;
	for(int i=0;s[i]!='\0';i++){
		if(s[i]=='.'){
			if(number>255){
				print(s,1);
				return;
			}
			number = 0;
		}else{
			number= number*10 + s[i]-'0';
		}
	}
	if(number > 255)
		print(s,1);
	else
		print(s,0);
}

void print(char* s,int type){
	if(display_input)
		printf("%s\n",s);
	switch(type){
		case 0: printf("Valid IPv4\n"); break;
		case 1: printf("Invalid IPv4\n"); break;
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
		printf("Program to check whether a given IPv4 is valid or not.\n\n");
		yylex();
		fclose(file);
	}else{
		printf("Program to check whether a given IPv4 is valid or not.\n\n");
		yylex();
	}
	return 0;
}
