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
%token <str> TSEMIC TASSIG
%token <str> RPROGRAM RBEGIN RENDPROGRAM
%token <str> RIF RTHEN RELSE

%type <str> programa
%type <str> listasentencias
%type <str> sentencia
%type <str> expr

%start programa

%%

programa : RPROGRAM  
           TIDENTIFIER 
	   RBEGIN
	   listasentencias 
	   RENDPROGRAM 
        ;

listasentencias : sentencia {$$ = new string; *$$ = *$1 ;cout<< "LS: R1 " << *$$<<endl;}
      | sentencia TSEMIC listasentencias {$$ = new string; *$$ = *$1 + " " + *$2 + " " + *$3;cout<< "LS: R2 "<< *$$ <<endl;}
      ;

sentencia :  TIDENTIFIER TASSIG expr {$$ = new string; *$$ = *$1 + " " + *$2 + " " + *$3 ;cout<< "S: R1 "<< *$$ <<endl;}
      | RIF expr RTHEN sentencia {$$ = new string; *$$ = *$1 + " " + *$2 + " " + *$3 + " " + *$4; cout<< "S: R2 "<<*$$<<endl;}
      | RIF expr RTHEN sentencia RELSE sentencia {$$ = new string; *$$ = *$1 + " " + *$2 + " " + *$3 + " " + *$4 + " " + *$5 + " " + *$6;cout<< "S: R3 "<< *$$ <<endl;}
      ;

expr : TIDENTIFIER {$$ = new string; *$$ = *$1;cout<<"id: " << *$1 <<endl;}
     | TINTEGER {$$ = new string; *$$ = *$1;cout<<"integer: " << *$1 <<endl;}
     | TDOUBLE {$$ = new string; *$$ = *$1;cout<<"double: " << *$1 <<endl;}
     ;

