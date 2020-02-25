CFLAGS=-Wall
TESTDIR=tests

all: parser prueba

clean:
	rm parser.cpp parser.hpp parser tokens.cpp 

parser.cpp: parser.y
	bison -d -o $@ $^

parser.hpp: parser.cpp

tokens.cpp: tokens.l parser.hpp
	lex -o $@ $^

parser: parser.cpp main.cpp tokens.cpp
	g++ $(CFLAGS) -o $@ *.cpp 

prueba:  parser ../$(TESTDIR)/prueba1.in ../$(TESTDIR)/prueba2.in ../$(TESTDIR)/pruebamala1.in
	./parser <../$(TESTDIR)/prueba1.in
	./parser <../$(TESTDIR)/prueba2.in
	./parser <../$(TESTDIR)/pruebamala1.in
