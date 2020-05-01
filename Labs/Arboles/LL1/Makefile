CFLAGS=-Wall

all: parser prueba

clean:
	rm parser.cpp parser.hpp parser tokens.cpp *~ 

parser.cpp: parser3.y
	bison -d -o $@ $^

parser.hpp: parser.cpp

tokens.cpp: tokens3.l parser.hpp
	lex -o $@ $^

parser: parser.cpp main.cpp tokens.cpp
	g++ $(CFLAGS) -o $@ *.cpp 

prueba: parser prueba3.in
	./parser < prueba3.in
