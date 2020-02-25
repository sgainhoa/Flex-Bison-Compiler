%{
   #include <stdio.h>
   #include <iostream>
   #include <vector>
   #include <string>
   using namespace std; 

   extern int yylex();
   extern int yylineno;
   extern char *yytext;
   void yyerror (const char *msg) {
     printf("line %d: %s at '%s'\n", yylineno, msg, yytext) ;
   }

%}

/* 
   qué atributos tienen los tokens 
*/
%union {
    string *str ; 
}

/* 
   declaración de tokens. Esto debe coincidir con tokens.l 
*/
%token <str> TIDENTIFIER TINTEGER TFLOAT
%token <str> TCEQ TCGT TCLT TCGE TCLE TCNE
%token <str> TMUL TDIV TPLUS TMINUS 
%token <str> TSEMIC TASSIG TLBRACE TRBRACE TLPAREN TRPAREN
%token <str> RPROGRAM RBEGIN RENDPROGRAM RINTEGER RFLOAT RIF RTHEN RWHILE RFOREVER RLOOP RFINALLY REXITIF RREAD RPRINT RPROC 

/* 
   declaración de no terminales. Por ej:
%type <str> expr
*/



%start programa

%%

programa : RPROGRAM  
           TIDENTIFIER 
	   TLBRACE
	   listasentencias
	   TRBRACE TSEMIC
         ;

listasentencias : listasentencias sentencia
      | /*vacio*/
      ;

sentencia :  TIDENTIFIER TASSIG expr TSEMIC;

expr : TIDENTIFIER
     | TINTEGER
     | TDOUBLE
     ;

