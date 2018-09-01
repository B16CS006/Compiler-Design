
LEX_FILE=source.l

all:scanner

scanner:lex.yy.c
	gcc lex.yy.c -ll -o scanner

lex.yy.c: source.l
	lex $(LEX_FILE)

clean_no_exe:
	rm lex.yy.c

clean:
	rm scanner lex.yy.c
