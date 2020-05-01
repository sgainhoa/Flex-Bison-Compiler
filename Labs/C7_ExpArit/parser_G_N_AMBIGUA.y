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

%type<str> Expr
%type <str> E
%type <str> T 
%type <str> F

%start Expr

%% 

Expr : TIDENTIFIER TASSIG E {codigo.anadirInstruccion(*$1 + " := " + *$3); codigo.escribir(); delete $3;}

E : E TPLUS T { $$ = new string();
      *$$ = codigo.nuevoId();
      codigo.anadirInstruccion(*$$ + " := " + *$1 + " + " + *$3 + ";") ;
      delete $1; delete $3; }
  | E TMINUS T { $$ = new string();
      *$$ = codigo.nuevoId();
      codigo.anadirInstruccion(*$$ + " := " + *$1 + " - " + *$3 + ";") ;
      delete $1; delete $3; }
  | T { $$ = new string();
      *$$ = codigo.nuevoId();
      codigo.anadirInstruccion(*$$ + " := " + *$1 + ";") ;
      delete $1; }
  ;

T : T TMUL F { $$ = new string();
      *$$ = codigo.nuevoId();
      codigo.anadirInstruccion(*$$ + " := " + *$1 + " * " + *$3 + ";") ;
      delete $1; delete $3; }
  | T TDIV F { $$ = new string();
      *$$ = codigo.nuevoId();
      codigo.anadirInstruccion(*$$ + " := " + *$1 + " / " + *$3 + ";") ;
      delete $1; delete $3; }
  | F { $$ = new string();
      *$$ = codigo.nuevoId();
      codigo.anadirInstruccion(*$$ + " := " + *$1 + ";") ;
      delete $1; }
  ;

F : TIDENTIFIER {$$ = new string(); *$$ = *$1;}
  | TINTEGER {$$ = new string(); *$$ = *$1;}

%%

