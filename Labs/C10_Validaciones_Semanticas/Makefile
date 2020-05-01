CFLAGS=-Wall
FUENTES=parser.cpp main.cpp tokens.cpp Codigo.cpp

all: parser prueba

clean:
	rm parser.cpp parser.hpp parser tokens.cpp

parser.cpp parser.hpp: parser.y 
	bison -d -o $@ $<

tokens.cpp: tokens.l
	lex -o $@ $<

parser: $(FUENTES)
	g++ $(CFLAGS) -o $@ $(FUENTES) 

prueba:  
	./parser <prueba1.in	
	./parser <prueba2.in
	./parser <prueba3.in
	./parser <prueba4.in
	./parser <prueba5.in
	./parser <prueba6.in
	./parser <prueba7.in