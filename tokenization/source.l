%{
#include <stdio.h>
#include "hash.h"

#define ERRORS			-2
#define EXTRA_SPACES		-1
#define PREPROCESSORS		0
#define KEYWORDS		1
#define SEPARATORS 		2
#define CHAR			3
#define LITERALS		4
#define IDENTIFIERS 		5
#define ARITHMATIC_OPERATORS	6
#define LOGICAL_OPERATORS	7
#define RELATIONAL_OPERATORS	8
#define BITWISE_OPERATORS	9
#define ASSIGNMENT_OPERATORS	10
#define INC_DEC_OPERATORS	11
#define CONDITIONAL_OPERATORS	12
#define SPECIAL_OPERATORS	13
#define INTEGER			14
#define FLOAT			15
#define COMMENT			16	//In this program I treated comment as EXTRA SPACES

void print(int,char*);			//modify function of printf

struct Hash hash;

%}

comment1 "//".*
comment2 "/*"([^\*]|([*][^/])|\n)*"*/"

extra_spaces [ ]*|\n|\t

preprocessors "#define"|"#include"|"#undef"|"#ifdef"|"#ifndef"|"#if"|"#else"|"#elif"|"#endif"|"#error"|"#pragma"

keywords1 auto|const|double|float|int|short|struct|unsigned|break|continue|else|for|long|signed|switch|void|case
keywords2 default|enum|got|register|typedef|volatile|char|do|extern|if|return|static|union|while

arithmatic_op [-+*/%]
logical_op "&&"|"||"|"!"
relational_op "=="|"!="|"<"|"<="|">"|">="
bitwise_op "&"|"|"|"^"|"~"|"<<"|">>"
assignment_op "="|"+="|"-="|"*="|"/="|"%="|"<<="|">>="|"&="|"|="|"^="
inc_dec_op "++"|"--"
conditional_op [?]
special_op "sizeof"|"*."|"->"

separators "("|")"|"{"|"}"|";"|"}"|"["|"]"|":"|","
letters	[a-zA-Z_]
digits [0-9]
char .|\\n|\\a|\\t|\\v|\\b|\n|\a|\t|\v|\b
literals \"([^\"]|\n|\a|\t|\v|\b)*\"

%%

\<.*\>					;//			file to be include
{comment1}|{comment2}			;//			{print(COMMENT, yytext);}
{extra_spaces}				;//			{print(EXTRA_SPACES, yytext);}
{preprocessors}							{print(PREPROCESSORS, yytext);}
{keywords1}|{keywords2}						{print(KEYWORDS, yytext);}
{separators} 							{print(SEPARATORS, yytext);}

\'{char}?\'								{print(CHAR, yytext);}
{literals}							{print(LITERALS, yytext);}
{letters}({digits}|{letters})*					{	if(yyleng <= 255){
										print(IDENTIFIERS, yytext);
									}else
										print(ERRORS, yytext);
								}
{arithmatic_op}							{print(ARITHMATIC_OPERATORS, yytext);}
{logical_op}							{print(LOGICAL_OPERATORS, yytext);}
{relational_op}							{print(RELATIONAL_OPERATORS, yytext);}
{bitwise_op}							{print(BITWISE_OPERATORS, yytext);}
{assignment_op}							{print(ASSIGNMENT_OPERATORS, yytext);}
{inc_dec_op}							{print(INC_DEC_OPERATORS, yytext);}
{conditional_op}						{print(CONDITIONAL_OPERATORS, yytext);}
{special_op}							{print(SPECIAL_OPERATORS, yytext);}
[+-]?{digits}+([eE][+-]?{digits}+)?				{print(INTEGER, yytext);}
[+-]?{digits}*[\.]{digits}+([eE][+-]?{digits}+)?		{print(FLOAT, yytext);}


{digits}*[\.]({digits}*[\.])+{digits}*	;//			{print(ERRORS, yytext);}
{digits}+{letters}+			;//			{print(ERRORS, yytext);}
{char} 					;//			{print(ERRORS, yytext);}
[@][@]					;//			{return 0;}					//to exit while taking input from terminal.
%%
/*
*/
void print(int type,char* s){
	char ty[256] ="\0";
	switch(type){		
		case ERRORS: strcpy(ty, "Error"); break;
		case EXTRA_SPACES: return;
		case PREPROCESSORS: strcpy(ty, "Preprocessor"); break;
		case KEYWORDS: strcpy(ty, "Keyword"); break;
		case SEPARATORS: strcpy(ty, "Separator"); break;
		case CHAR: strcpy(ty, "Char"); break;
		case LITERALS: strcpy(ty, "Literal"); break;
		case IDENTIFIERS: strcpy(ty, "Identifier"); break;
		case ARITHMATIC_OPERATORS: strcpy(ty, "Arithmatic_Operator"); break;
		case LOGICAL_OPERATORS: strcpy(ty, "Logical_Operator"); break;
		case RELATIONAL_OPERATORS: strcpy(ty, "Relational_Operator"); break;
		case BITWISE_OPERATORS: strcpy(ty, "Bitwise_Operator"); break;
		case ASSIGNMENT_OPERATORS: strcpy(ty, "Assignment_Operator"); break;
		case INC_DEC_OPERATORS: strcpy(ty, "Inc_Dec_Operator"); break;
		case CONDITIONAL_OPERATORS: strcpy(ty, "Conditional_Operator"); break;
		case SPECIAL_OPERATORS: strcpy(ty, "Special_Operator"); break;
		case INTEGER: strcpy(ty, "Int"); break;
		case FLOAT: strcpy(ty, "Float"); break;
		case COMMENT: strcpy(ty, "Comment"); break;
		default: return;
		
	}
//	printf("< %s, %s >\n",ty,s);										//to display on terminal
	insert_hash(&hash,ty,s);
}

int main(){
	hash = create_hash_table();
	yylex();
	print_hash(hash);
	return 0;
}
