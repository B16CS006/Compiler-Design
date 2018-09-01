


all:scanner

scanner:lex.yy.o stack.o
	gcc stack.o lex.yy.o -ll -o scanner

stack.o: stack.h stack.c
	gcc -c stack.c

lex.yy.o:lex.yy.c
	gcc -c lex.yy.c

lex.yy.c: source.l stack.h
	lex source.l

clean_no_exe:
	rm lex.yy.c lex.yy.o stack.o

clean:
	rm scanner lex.yy.c lex.yy.o stack.o
