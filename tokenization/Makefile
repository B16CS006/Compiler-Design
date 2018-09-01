

all:scanner

scanner:lex.yy.o hash.o
	gcc hash.o lex.yy.o -ll -o scanner

hash.o: hash.h hash.c
	gcc -c hash.c

lex.yy.o:lex.yy.c
	gcc -c lex.yy.c

lex.yy.c: source.l hash.h
	lex source.l

clean_no_exe:
	rm lex.yy.c lex.yy.o hash.o

clean:
	rm scanner lex.yy.c lex.yy.o hash.o
