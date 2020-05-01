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
%token <str> TIDENTIFIER TINTEGER
%token <str> TPLUS TMINUS TMUL TDIV
%left TMUL TDIV
%left TPLUS TMINUS



%type <str> E
%type <str> EP
%type <str> T
%type <str> TP
%type <str> F

%start E

%%

E : T EP {cout << *$1 << " " << *$2 << endl;};

EP : TPLUS T EP
   { cout << "Suma\: " << *$2 << " " << *$3 << endl; $$ = new string; *$$ = "+ " + *$1 + " " + *$3; }
   | TMINUS T EP
   { cout << "Resta\: " << *$2 << " " << *$3 << endl; $$ = new string; *$$ = "- " + *$1 + " " + *$3; }
   | %empty
   {cout << "EP Empty" << endl; $$ = new string; *$$ = "Empty";}
   ;

T : F TP {cout << *$1 << *$2 << endl;};

TP : TMUL F TP
   { cout << "Mult\: " << *$2 << " " << *$3 << endl; $$ = new string; *$$ = "* " + *$2 + " " + *$3; }
   | TDIV F TP
   { cout << "Div\: "<< *$2 << " " << *$3 << endl; $$ = new string; *$$ = "/ " + *$2 + " " + *$3; }
   | %empty
   { cout << "TP Empty" << endl ; $$ = new string; *$$ = "Empty";}
   ;

F: TIDENTIFIER
   { $$ = $1; cout<<"Id : "<< yytext << endl;}
   | TINTEGER
   { $$ = $1; cout<<"Ent : "<< yytext << endl;}
   ;

