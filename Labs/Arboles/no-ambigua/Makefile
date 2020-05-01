CFLAGS=-Wall

all: parser prueba

clean:
	rm parser.cpp parser.hpp parser tokens.cpp *~ 

parser.cpp: parser2.y
	bison -d -o $@ $^

parser.hpp: parser.cpp

tokens.cpp: tokens2.l parser.hpp
	lex -o $@ $^

parser: parser.cpp main.cpp tokens.cpp
	g++ $(CFLAGS) -o $@ *.cpp 

prueba: parser prueba2.in
	./parser < prueba2.in
