CFLAGS=-Wall
FUENTES = parser.cpp main.cpp tokens.cpp
all: parser prueba

clean:
	rm parser.cpp parser.hpp parser tokens.cpp *~ 

parser.cpp parser.hpp: parser.y
	bison -d -o $@ $^

tokens.cpp: tokens.l parser.hpp
	lex -o $@ $<

parser: $(FUENTES)
	g++ $(CFLAGS) -o $@ $(FUENTES)

prueba:  parser prueba1.in pruebamala1.in
	./parser <prueba1.in
	./parser <pruebamala1.in
