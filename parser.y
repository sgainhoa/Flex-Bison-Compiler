%{
   #include <stdio.h>
   #include <iostream>
   #include <vector>
   #include <string>
   using namespace std; 

   extern int yylex();
   extern int yylineno;
   extern char *yytext;
   string tab = "\t" ;
   void yyerror (const char *msg) {
     printf("line %d: %s at '%s'\n", yylineno, msg, yytext) ;
   }

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

programa : RPROGRAM TIDENTIFIER bloqueppl { cout << "\n<programa>\n" + *$1 + tab + *$2 + tab + *$3 + "\n<\\programa>\n" << endl ;} ; 

bloqueppl : TLBRACE declaraciones decl_de_subprogs lista_de_sentencias TRBRACE {$$ = new string; *$$ = "\n<bloqueppl>\n" + *$1 + tab + *$2 + tab + *$3 + tab + *$4 + tab + *$5 + "\n<\\bloqueppl>\n";};

bloque : TLBRACE declaraciones lista_de_sentencias TRBRACE {$$ = new string; *$$ = "\n<bloque>\n" + *$1 + tab + *$2 + tab + *$3 + tab + *$4 + "\n<\\bloque>\n";} ;

declaraciones : tipo lista_de_ident TSEMIC declaraciones {$$ = new string; *$$ = "\n<declaraciones>\n" + *$1 + tab + *$2 + tab + *$3 + tab + *$4 + "\n<\\declaraciones>\n";}
	      | %empty {$$ = new string; *$$ = "\n<declaraciones><\\declaraciones>\n";}
	      ;

lista_de_ident : TIDENTIFIER resto_lista_id {$$ = new string; *$$ = "\n<lista_de_ident>\n" + *$1 + tab + *$2 + "\n<\\lista_de_ident>\n";};

resto_lista_id : TCOMMA TIDENTIFIER resto_lista_id {$$ = new string; *$$ = "\n<resto_lista_id>\n" + *$1 + tab + *$2 + tab + *$3 + "\n<\\resto_lista_id>\n";}
	       | %empty {$$ = new string; *$$ = "\n<resto_lista_id><\\resto_lista_id>\n";}
	       ;

tipo : RINTEGER {$$ = new string; *$$ = "\n<tipo> " + *$1 + " <\\tipo>\n";}
     | RFLOAT {$$ = new string; *$$ = "\n<tipo> " + *$1 + " <\\tipo>\n";}
     ;

decl_de_subprogs : decl_de_subprograma decl_de_subprogs {$$ = new string; *$$ = "\n<decl_de_subprogs>\n" + *$1 + tab + *$2 + "\n<\\decl_de_subprogs>\n";}
		 | %empty {$$ = new string; *$$ = "\n<decl_de_subprogs><\\decl_de_subprogs>\n";}
		 ;
		 
decl_de_subprograma : RPROC TIDENTIFIER argumentos bloqueppl {$$ = new string; *$$ = "\n<decl_de_subprograma>\n" + *$1 + tab + *$2 + tab + *$3 + tab + *$4 + "\n<\\decl_de_subprograma>\n";};

argumentos : TLPAREN lista_de_param TRPAREN {$$ = new string; *$$ = "\n<argumentos>\n" + *$1 + tab + *$2 + tab + *$3 + "\n<\\argumentos>\n";}
	   | %empty {$$ = new string; *$$ = "\n<argumentos><\\argumentos>\n";}
	   ;
	   
lista_de_param : tipo lista_de_ident TCOLON clase_par resto_lis_de_param {$$ = new string; *$$ = "\n<lista_de_param>\n" + *$1 + tab + *$2 + tab + *$3 + tab + *$4 + tab + *$5 + "\n<\\lista_de_param>\n";};

clase_par : RIN {$$ = new string; *$$ = "\n<clase_par> " + *$1 + " <\\clase_par>\n";}
	  | ROUT {$$ = new string; *$$ = "\n<clase_par> " + *$1 + " <\\clase_par>\n";}
	  | RIN ROUT {$$ = new string; *$$ = "\n<clase_par> " + *$1 + " " + *$2 + " <\\clase_par>\n";}
	  ;

resto_lis_de_param : TSEMIC tipo lista_de_ident TCOLON clase_par resto_lis_de_param {$$ = new string; *$$ = "\n<resto_lis_de_param>\n" + *$1 + tab + *$2 + tab + *$3 + tab + *$4 + tab + *$5 + tab + *$6 + "\n<\\resto_lis_de_param>\n";}
	  	   | %empty {$$ = new string; *$$ = "\n<resto_lis_de_param><\\resto_lis_de_param>\n";}
	           ;

lista_de_sentencias : sentencia lista_de_sentencias {$$ = new string; *$$ = "\n<lista_de_sentencias>\n" + *$1 + tab + *$2 + "\n<\\lista_de_sentencias>\n";}
		    | %empty {$$ = new string; *$$ = "\n<lista_de_sentencias><\\lista_de_sentencias>\n";}
		    ;
		    
sentencia : variable TASSIG expresion TSEMIC {$$ = new string; *$$ = "\n<sentencia>\n" + *$1 + tab + *$2 + tab + *$3 + tab + *$4 + "\n<\\sentencia>\n";}
	  | RIF expresion RTHEN bloque TSEMIC {$$ = new string; *$$ = "\n<sentencia>\n" + *$1 + tab + *$2 + tab + *$3 + tab + *$4 + tab + *$5 + "\n<\\sentencia>\n";}
	  | RWHILE RFOREVER bloque TSEMIC {$$ = new string; *$$ = "\n<sentencia>\n" + *$1 + tab + *$2 + tab + *$3 + tab + *$4 + "\n<\\sentencia>\n";}
	  | RWHILE expresion RLOOP bloque RFINALLY bloque TSEMIC {$$ = new string; *$$ = "\n<sentencia>\n" + *$1 + tab + *$2 + tab + *$3 + tab + *$4 + tab + *$5 + tab + *$6 + "\n<\\sentencia>\n";}
	  | REXIT RIF expresion TSEMIC {$$ = new string; *$$ = "\n<sentencia>\n" + *$1 + tab + *$2 + tab + *$3 + tab + *$4 + "\n<\\sentencia>\n";}
	  | RREAD TLPAREN variable TRPAREN TSEMIC {$$ = new string; *$$ = "\n<sentencia>\n" + *$1 + tab + *$2 + tab + *$3 + tab + *$4 + tab + *$5 + "\n<\\sentencia>\n";}
	  | RPRINT TLPAREN expresion TRPAREN TSEMIC {$$ = new string; *$$ = "\n<sentencia>\n" + *$1 + tab + *$2 + tab + *$3 + tab + *$4 + tab + *$5 + "\n<\\sentencia>\n";}
	  ;

variable : TIDENTIFIER {$$ = new string; *$$ = "\n<variable> " + *$1 + " <\\variable>\n";};

expresion : expresion TCEQ expresion {$$ = new string; *$$ = "\n<expresion>\n" + *$1 + tab + *$2 + tab + *$3 + "\n<\\expresion>\n";}
	  | expresion TCGT expresion {$$ = new string; *$$ = "\n<expresion>\n" + *$1 + tab + *$2 + tab + *$3 + "\n<\\expresion>\n";}
	  | expresion TCLT expresion {$$ = new string; *$$ = "\n<expresion>\n" + *$1 + tab + *$2 + tab + *$3 + "\n<\\expresion>\n";}
	  | expresion TCGE expresion {$$ = new string; *$$ = "\n<expresion>\n" + *$1 + tab + *$2 + tab + *$3 + "\n<\\expresion>\n";}
	  | expresion TCLE expresion {$$ = new string; *$$ = "\n<expresion>\n" + *$1 + tab + *$2 + tab + *$3 + "\n<\\expresion>\n";}
	  | expresion TCNE expresion {$$ = new string; *$$ = "\n<expresion>\n" + *$1 + tab + *$2 + tab + *$3 + "\n<\\expresion>\n";}
	  | expresion TPLUS expresion {$$ = new string; *$$ = "\n<expresion>\n" + *$1 + tab + *$2 + tab + *$3 + "\n<\\expresion>\n";}
	  | expresion TMINUS expresion {$$ = new string; *$$ = "\n<expresion>\n" + *$1 + tab + *$2 + tab + *$3 + "\n<\\expresion>\n";}
	  | expresion TMUL expresion {$$ = new string; *$$ = "\n<expresion>\n" + *$1 + tab + *$2 + tab + *$3 + "\n<\\expresion>\n";}
	  | expresion TDIV expresion {$$ = new string; *$$ = "\n<expresion>\n" + *$1 + tab + *$2 + tab + *$3 + "\n<\\expresion>\n";}
	  | variable {$$ = new string; *$$ = "\n<expresion> " + *$1 + " <\\expresion>\n";}
	  | TINTEGER {$$ = new string; *$$ = "\n<expresion> " + *$1 + " <\\expresion>\n";}
	  | TFLOAT {$$ = new string; *$$ = "\n<expresion> " + *$1 + " <\\expresion>\n";}
	  | TLPAREN expresion TRPAREN {$$ = new string; *$$ = "\n<expresion>\n" + *$1 + tab + *$2 + tab + *$3 + "\n<\\expresion>\n";}
	  ;
