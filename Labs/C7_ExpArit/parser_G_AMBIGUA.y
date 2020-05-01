%define parse.error verbose

%{
   #include <stdio.h>
   #include <iostream>
   #include <string>
   using namespace std; 

   extern int yylex();
   extern int yylineno;
   extern char *yytext;
   void yyerror (const char *msg) {
     printf("line %d: %s at '%s'\n", yylineno, msg, yytext) ;
   }

   #include "Aux/Codigo.hpp"
   #include "Aux/Aux.hpp"

   Codigo codigo;

%}

/* 
   qué atributos tienen los símbolos 
*/
%union {
    string *str ; 
 }
 
/*   declaración de tokens. Esto debe coincidir con tokens.l */

%token <str> TIDENTIFIER TINTEGER TDOUBLE

%token <str> TPLUS TMINUS TMUL TDIV
%token <str> TSEMIC TASSIG
%token <str> RPROGRAM RIS RBEGIN RENDPROGRAM 

%left TPLUS TMINUS
%left TMUL TDIV
%nonassoc TASSIG

%type <str> ident
%type <str> numeric 
%type <str> expr
%type <str> program stmts
%type <str> stmt  


%start program

%% 
program : RPROGRAM { codigo.anadirInstruccion("prog;" ) ;} 
          ident RIS
	      RBEGIN
	      stmts 
	      RENDPROGRAM TSEMIC {
            codigo.anadirInstruccion("halt;");
		    codigo.escribir() ; 
           }
        ;

stmts : stmt TSEMIC
      | stmts stmt TSEMIC
      ;

stmt :  ident TASSIG expr { 
          codigo.anadirInstruccion(*$1 + *$2 + *$3 + ";") ; 
    	  delete $1 ; delete $3;
         }
	
       ;

expr : ident   { $$ = $1; }
     | numeric { $$ = $1; }
    
     | expr TPLUS expr  { $$ = new string();
			  *$$ = codigo.nuevoId();
			  codigo.anadirInstruccion(*$$ + " := " + *$1 + *$2 + *$3 + ";") ;
			  delete $1; delete $3; }   
     | expr TMINUS expr  { $$ = new string();
			  *$$ = codigo.nuevoId();
			  codigo.anadirInstruccion(*$$ + " := " + *$1 + *$2 + *$3 + ";") ;
			  delete $1; delete $3; }   
     | expr TMUL expr  { $$ = new string();
			  *$$ = codigo.nuevoId();
			  codigo.anadirInstruccion(*$$ + " := " + *$1 + *$2 + *$3 + ";") ;
			  delete $1; delete $3; }   
     | expr TDIV expr  { $$ = new string();
			  *$$ = codigo.nuevoId();
			  codigo.anadirInstruccion(*$$ + " := " + *$1 + *$2 + *$3 + ";") ;
			  delete $1; delete $3; }   
     ;

ident : TIDENTIFIER  { $$ = $1 ; } ;

numeric : TINTEGER  { $$ = $1; }
        | TDOUBLE   { $$ = $1; }
        ;

%%

