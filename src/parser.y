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
%type <str> lista_de_ident
%type <str> resto_lista_id
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

programa : RPROGRAM TIDENTIFIER bloqueppl ;

bloqueppl : TLBRACE declaraciones decl_de_subprogs lista_de_sentencias TRBRACE ;

bloque : TLBRACE declaraciones lista_de_sentencias TRBRACE ;

declaraciones : tipo lista_de_ident TSEMIC declaraciones
	      | %empty
	      ;

lista_de_ident : TIDENTIFIER resto_lista_id ;

resto_lista_id : TCOMMA TIDENTIFIER resto_lista_id
	       | %empty
	       ;

tipo : RINTEGER
     | RFLOAT
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

variable : TIDENTIFIER ;

expresion : expresion TCEQ expresion
	  | expresion TCGT expresion
	  | expresion TCLT expresion
	  | expresion TCGE expresion
	  | expresion TCLE expresion
	  | expresion TCNE expresion
	  | expresion TPLUS expresion
	  | expresion TMINUS expresion
	  | expresion TMUL expresion
	  | expresion TDIV expresion
	  | variable
	  | TINTEGER
	  | TFLOAT
	  | TLPAREN expresion TRPAREN
	  ;
