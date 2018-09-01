%{
#include "stack.h"

Stack* stack;
_Bool valid = 1;
char opposite(char*);
%}

open [({[]
close [)}\]]


%%

{open}	{push(stack,yytext[0]);}
{close}	{if(pop(stack) != opposite(yytext))valid = 0;}
.|\n
%%
char opposite(char* t){
	switch(t[0]){
		case ')': return '(';
		case '}': return '{';
		case ']': return '[';
		default: return '\0';
	}
}

int main(){
	stack = create_stack(-1);
	yylex();
	if(!empty(stack))
		valid = 0;
	if(valid)
		printf("Balanced Parentheses\n");
	else
		printf("Unbalanced Parentheses\n");
	return 0;
}
