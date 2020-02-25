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
%token <str> TIDENTIFIER TINTEGER TDOUBLE
%token <str> TMUL
%token <str> TSEMIC TASSIG TLBRACE TRBRACE
%token <str> RPROGRAM RBEGIN RENDPROGRAM

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

