
single_line_comment "//".*
multi_line_comment "/*"(\n|.)*"*/"

comment1 "//".*
comment2 "/*"([^\*]|([*][^/])|\n)*"*/"
literals \"([^\"]|\n|\a|\t|\v|\b)*\"

%%

{literals} ECHO;
{comment1}|{comment2}

%%

int main(){
	yylex();
	return 0;
}
