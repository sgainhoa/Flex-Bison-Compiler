CFLAGS=-Wall

all: parser prueba

clean:
	rm parser.cpp parser.hpp parser tokens.cpp *~ 

parser.cpp: parser.y
	bison -d -o $@ $^

parser.hpp: parser.cpp

tokens.cpp: tokens.l parser.hpp
	lex -o $@ $^

FUENTES = parser.cpp main.cpp tokens.cpp
parser: $(FUENTES)
	g++ $(CFLAGS) -o $@ $(FUENTES)

prueba:  parser prueba1.in prueba2.in 
	./parser <prueba1.in
	./parser <prueba2.in

