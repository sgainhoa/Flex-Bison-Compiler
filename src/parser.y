%{
   #include <stdio.h>
   #include <iostream>
   #include <vector>
   #include <string>
   #include "Codigo.hpp"
   using namespace std; 

   extern int yylex();
   extern int yylineno;
   extern char *yytext;
   string tab = "\t" ;
   void yyerror (const char *msg) {
     printf("line %d: %s at '%s'\n", yylineno, msg, yytext) ;
   }
   Codigo codigo;

%}

/* 
   qué atributos tienen los tokens 
*/
%union {
	std::string *str ; 
}

/* 
   declaración de tokens. Esto debe coincidir con tokens.l 
*/

%token <str> TIDENTIFIER TINTEGER TFLOAT
%token <str> TMUL TDIV TPLUS TMINUS
%token <str> TCEQ TCGT TCLT TCGE TCLE TCNE
%token <str> TSEMIC TCOMMA TCOLON TASSIG TLBRACE TRBRACE TLPAREN TRPAREN
%token <str> RPROGRAM RINTEGER RFLOAT RIF RTHEN RWHILE RFOREVER RLOOP RFINALLY REXIT RREAD RPRINT RPROC RIN ROUT 

%nonassoc TCEQ TCGT TCLT TCGE TCLE TCNE
%left TPLUS TMINUS
%left TMUL TDIV

/* 
   declaración de no terminales.
*/

%type <str> programa
%type <str> bloqueppl
%type <str> bloque
%type <str> declaraciones
%type <vector<str>> lista_de_ident
%type <vector<str>> resto_lista_id
%type <str> tipo
%type <str> decl_de_subprogs
%type <str> decl_de_subprograma
%type <str> argumentos
%type <str> lista_de_param
%type <str> clase_par
%type <str> resto_lis_de_param
%type <str> lista_de_sentencias
%type <str> sentencia
%type <str> variable
%type <str> expresion

%start programa

%%

programa : RPROGRAM TIDENTIFIER bloqueppl  ; 

bloqueppl : TLBRACE declaraciones decl_de_subprogs lista_de_sentencias TRBRACE ;

bloque : TLBRACE declaraciones lista_de_sentencias TRBRACE  ;

declaraciones : tipo lista_de_ident TSEMIC declaraciones 
	      | %empty 
	      ;

lista_de_ident : TIDENTIFIER resto_lista_id 
			   { vector<string> $${*$1}; $$.insert($$.end(), $2.begin(), $2.end());};

resto_lista_id : TCOMMA TIDENTIFIER resto_lista_id 
		   { vector<string> $${*$2}; $$.insert($$.end(), $3.begin(), $3.end()); delete $3;}
	       | %empty 
		   { vector<string> $$;}
	       ;

tipo : RINTEGER {$$ = new string(); *$$ = *$1;}
     | RFLOAT {$$ = new string(); *$$ = *$1;}
     ;

decl_de_subprogs : decl_de_subprograma decl_de_subprogs 
		 | %empty 
		 ;
		 
decl_de_subprograma : RPROC TIDENTIFIER argumentos bloqueppl ;

argumentos : TLPAREN lista_de_param TRPAREN 
	   | %empty 
	   ;
	   
lista_de_param : tipo lista_de_ident TCOLON clase_par resto_lis_de_param ;

clase_par : RIN 
	  | ROUT 
	  | RIN ROUT 
	  ;

resto_lis_de_param : TSEMIC tipo lista_de_ident TCOLON clase_par resto_lis_de_param 
	  	   | %empty 
	           ;

lista_de_sentencias : sentencia lista_de_sentencias 
		    | %empty 
		    ;
		    
sentencia : variable TASSIG expresion TSEMIC 
	  | RIF expresion RTHEN bloque TSEMIC 
	  | RWHILE RFOREVER bloque TSEMIC 
	  | RWHILE expresion RLOOP bloque RFINALLY bloque TSEMIC 
	  | REXIT RIF expresion TSEMIC 
	  | RREAD TLPAREN variable TRPAREN TSEMIC 
	  | RPRINT TLPAREN expresion TRPAREN TSEMIC 
	  ;

variable : TIDENTIFIER {$$ = new string(); *$$ = *$1;};

expresion : expresion TCEQ expresion 
	  | expresion TCGT expresion 
	  | expresion TCLT expresion 
	  | expresion TCGE expresion 
	  | expresion TCLE expresion 
	  | expresion TCNE expresion 
	  | expresion TPLUS expresion 
	  { $$ = new string(); *$$ = codigo.nuevoId();
	    codigo.anadirInstruccion(*$$ + " := " + *$1 + " + " + *$3 + ";");
		delete $1; delete $3;}
	  | expresion TMINUS expresion 
	  { $$ = new string(); *$$ = codigo.nuevoId();
	    codigo.anadirInstruccion(*$$ + " := " + *$1 + " - " + *$3 + ";");
		delete $1; delete $3;}
	  | expresion TMUL expresion 
	  { $$ = new string(); *$$ = codigo.nuevoId();
	    codigo.anadirInstruccion(*$$ + " := " + *$1 + " * " + *$3 + ";");
		delete $1; delete $3;}
	  | expresion TDIV expresion 
	  { $$ = new string(); *$$ = codigo.nuevoId();
	    codigo.anadirInstruccion(*$$ + " := " + *$1 + " / " + *$3 + ";");
		delete $1; delete $3;}
	  | variable {$$ = new string(); *$$ = *$1; delete $1;}
	  | TINTEGER {$$ = new string(); *$$ = *$1;}
	  | TFLOAT {$$ = new string(); *$$ = *$1;}
	  | TLPAREN expresion TRPAREN {$$ = new string(); *$$ = *$1; delete $1;}
	  ;
