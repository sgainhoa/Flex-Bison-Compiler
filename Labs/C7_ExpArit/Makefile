CFLAGS=-Wall
TESTDIR=./Tests/
AUXDIR=./Aux/
FUENTES_AMB=parserAMB.cpp main.cpp tokensAMB.cpp $(AUXDIR)Codigo.cpp
FUENTES_NAMB=parserNAMB.cpp main.cpp tokensNAMB.cpp $(AUXDIR)Codigo.cpp

all: parserAMB parserNAMB prueba

clean:
	rm parserAMB.cpp parserAMB.hpp parserAMB tokensAMB.cpp parserNAMB.cpp parserNAMB.hpp parserNAMB tokensNAMB.cpp 

parserAMB.cpp parserAMB.hpp: parser_G_AMBIGUA.y $(AUXDIR)Codigo.hpp $(AUXDIR)Aux.hpp
	bison -d -o $@ $<

parserNAMB.cpp parserNAMB.hpp: parser_G_N_AMBIGUA.y $(AUXDIR)Codigo.hpp $(AUXDIR)Aux.hpp
	bison -d -o $@ $<

tokensAMB.cpp: tokensAMB.l parserAMB.hpp $(AUXDIR)Aux.hpp
	lex -o $@ $<

tokensNAMB.cpp: tokensNAMB.l parserNAMB.hpp $(AUXDIR)Aux.hpp
	lex -o $@ $<

parserAMB: $(FUENTES_AMB) $(AUXDIR)Codigo.hpp $(AUXDIR)Aux.hpp
	g++ $(CFLAGS) -o $@ $(FUENTES_AMB)

parserNAMB: $(FUENTES_NAMB) $(AUXDIR)Codigo.hpp $(AUXDIR)Aux.hpp
	g++ $(CFLAGS) -o $@ $(FUENTES_NAMB) 

prueba:
	@echo -e "\n\n------ PRUEBAS GRAMATICA AMBIGUA ------\n\n"
	./parserAMB < $(TESTDIR)prueba1.in	
	./parserAMB < $(TESTDIR)prueba2.in
	./parserAMB < $(TESTDIR)prueba3.in
	@echo -e "\n\n------ PRUEBA GRAMATICA NO AMBIGUA ------\n\n"
	./parserNAMB < $(TESTDIR)pruebaPDF.in
