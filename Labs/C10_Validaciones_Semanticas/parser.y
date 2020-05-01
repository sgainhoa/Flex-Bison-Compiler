%define parse.error verbose

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
     printf("Line %d: %s\n", yylineno, msg) ;
   }

   #include "Codigo.hpp"

   expresionstruct makecomparison(std::string &s1, std::string &s2, std::string &s3) ;
   expresionstruct makearithmetic(std::string &s1, std::string &s2, std::string &s3) ;

// Añado la declaración de la función unir. Si la hacéis diferente, debéis cambiar esta declaración.
   vector<int> *unir(vector<int> &list1, vector<int> &list2);
   void printVector(vector<int> &vec);
   int nWhiles = 0;
   Codigo codigo;

%}

/* 
   qué atributos tienen los símbolos 
*/
%union {
    string *str ; 
    vector<string> *list ;
    expresionstruct *expr ;
    sentenciastruct *sent ;
    int number ;
    vector<int> *numlist;
}

/* 
   declaración de tokens. Esto debe coincidir con tokens.l 
*/
%token <str> TIDENTIFIER TINTEGER TDOUBLE
%token <str> TCEQ TCNE TCLT TCLE TCGT TCGE TEQUAL
%token <str> TLPAREN TRPAREN TLBRACE TRBRACE TCOMMA TDOT
%token <str> TPLUS TMINUS TMUL TDIV
%token <str> TCOLON TSEMIC TASSIG
%token <str> RPROGRAM RIS RBEGIN RENDPROGRAM RVAR RINTEGER RFLOAT RENDPROCEDURE RPROCEDURE RIN ROUT RIF RTHEN RELSE RENDIF RGET RPUT_LINE RWHILE RDO RENDWHILE RCONTINUE RSUPERCONT
//Faltan declarar los nuevos tokens

%type <str> ident
%type <str> numeric 
%type <expr> expr
%type <str> program 
%type <str> decls 
%type <str> type 
%type <list> list 
%type <number> M
%type <numlist> N
//Falta declarar stmt stmts 
%type<sent> stmt;
%type<sent> stmts;


%nonassoc TCEQ TCNE TCLT TCLE TCGT TCGE
%left TPLUS TMINUS
%left TMUL TDIV

%start program

%%

program : RPROGRAM { codigo.anadirInstruccion("prog;" ) ;} 
          ident RIS
	      decls
	      RBEGIN
	      stmts 
	      RENDPROGRAM TSEMIC {
                    codigo.anadirInstruccion("halt;");
		    if (!$7->cont.empty() || !$7->supercont.empty()) {
                        yyerror("Error semántico. Hay un continue fuera de un bucle.");
                    } else {
                        codigo.escribir() ;
                    } 
              }
        ;

decls : /*blank*/ {}
      | decls decl {} 
      ;

decl : RVAR list TCOLON type TSEMIC {
         codigo.anadirDeclaraciones(*$2,*$4);
         delete $2; delete $4 ;
        }
	;

type : RFLOAT 
     | RINTEGER 
     ;

list : ident {
         $$ = new vector<string> ; 
	     $$->push_back(*$1);
        }
     | list TCOMMA ident { 
         $$ = $1 ;
         $$->push_back(*$3);
        } 
     ;

stmts : stmt TSEMIC //Añadir la acción correspondiente
        {
        $$ = new sentenciastruct; $$->cont = $1->cont; $$->supercont = $1->supercont;
        }
      | stmts stmt TSEMIC //Añadir la acción correspondiente
        {
        $$ = new sentenciastruct;
        $$->cont = *unir($1->cont,$2->cont);
        $$->supercont = *unir($1->supercont,$2->supercont);
        }
      ;

stmt :  ident TASSIG expr { 
          codigo.anadirInstruccion(*$1 + *$2 + $3->str + ";") ; 
    	  delete $1 ; delete $3;
	 //Falta inicializar el atributo de stmt
         $$ = new sentenciastruct;
         }
	
	|  RIF expr RTHEN M
        stmts   N 
		RELSE
        M stmts M RENDIF 
	{
	      	codigo.completarInstrucciones($2->trues,$4) ;
    	  	codigo.completarInstrucciones($2->falses,$8) ;
    	  	
    	  	codigo.completarInstrucciones(*$6, $10) ;
	      	delete $2 ;
 		//Falta inicializar el atributo de stmt
		$$ = new sentenciastruct; $$->cont = *unir($5->cont,$9->cont);
                delete $5; delete $9;
         }

        | RWHILE {nWhiles++;} M
        expr RDO M
	stmts M RENDWHILE
	{ codigo.completarInstrucciones($4->trues,$6) ;
    	  codigo.completarInstrucciones($4->falses,$8+1) ;
	 
    	  codigo.anadirInstruccion("goto");
	  vector<int> tmp1 ; tmp1.push_back($8) ;
    	  codigo.completarInstrucciones(tmp1, $3) ;

          //Falta completar stmts.cont
          codigo.completarInstrucciones($7->cont, $3);
          nWhiles--;
          if (nWhiles == 0) {
                codigo.completarInstrucciones($7->supercont, $3);
          }
 	  //Falta inicializar el atributo de stmt
          $$ = new sentenciastruct;

	  delete $4 ;

	}  
	
	| RCONTINUE RIF expr M
	{ 
	 //Falta su traducción
          codigo.completarInstrucciones($3->falses, $4);
          $$ = new sentenciastruct; $$->cont = $3->trues;
	  delete $3;
	}

        | RCONTINUE M
        {
                $$ = new sentenciastruct; $$->cont.push_back($2);
                codigo.anadirInstruccion("goto");
        }

        | RSUPERCONT RIF expr M
	{ 
	 //Falta su traducción
          codigo.completarInstrucciones($3->falses, $4);
          $$ = new sentenciastruct; $$->supercont = $3->trues;
	  delete $3;
	}

        | RSUPERCONT M
        {
                $$ = new sentenciastruct; $$->supercont.push_back($2);
                codigo.anadirInstruccion("goto");
        }
       ;

M:  { $$ = codigo.obtenRef() ; }
	;

N:  {
	$$ = new vector<int>;	
        // vector<int> tmp1 ; tmp1.push_back(codigo.obtenRef()) ;
	$$->push_back(codigo.obtenRef());
	codigo.anadirInstruccion("goto");}
        ;

expr : ident   { $$ = new expresionstruct; $$->str = *$1; }
     | numeric { $$ = new expresionstruct; $$->str = *$1; }
     | TLPAREN expr TRPAREN { $$ = $2; }

     | expr TPLUS expr  { $$ = new expresionstruct;
			 *$$ = makearithmetic($1->str,*$2,$3->str) ;
			delete $1; delete $3; }
     | expr TMINUS expr { $$ = new expresionstruct;
			 *$$ = makearithmetic($1->str,*$2,$3->str) ;
			delete $1; delete $3; }
     | expr TMUL expr   { $$ = new expresionstruct;
			 *$$ = makearithmetic($1->str,*$2,$3->str) ;
			delete $1; delete $3; }
     | expr TDIV expr   {$$ = new expresionstruct;
                         codigo.anadirInstruccion("if " + $3->str + " = 0 goto ErrorDiv0;");
			 *$$ = makearithmetic($1->str,*$2,$3->str) ;
			delete $1; delete $3; }
     | expr TCEQ expr { $$ = new expresionstruct;
			 *$$ = makecomparison($1->str,*$2,$3->str) ; 
			delete $1; delete $3; }
     | expr TCNE expr { $$ = new expresionstruct;
			 *$$ = makecomparison($1->str,*$2,$3->str) ; 
			delete $1; delete $3; }
     | expr TCLT expr { $$ = new expresionstruct;
			 *$$ = makecomparison($1->str,*$2,$3->str) ; 
			delete $1; delete $3; }
     | expr TCLE expr { $$ = new expresionstruct;
			 *$$ = makecomparison($1->str,*$2,$3->str) ; 
			delete $1; delete $3; }
     | expr TCGT expr { $$ = new expresionstruct;
			 *$$ = makecomparison($1->str,*$2,$3->str) ; 
			delete $1; delete $3; }
     | expr TCGE expr { $$ = new expresionstruct;
			 *$$ = makecomparison($1->str,*$2,$3->str) ; 
			delete $1; delete $3; }
     ;

ident : TIDENTIFIER { $$ = $1 ; }
      ;

numeric : TINTEGER { $$ = $1; }
        | TDOUBLE  { $$ = $1; }
        ;

%%

expresionstruct makecomparison(std::string &s1, std::string &s2, std::string &s3) {
  expresionstruct tmp ; 
  tmp.trues.push_back(codigo.obtenRef()) ;
  tmp.falses.push_back(codigo.obtenRef()+1) ;
  codigo.anadirInstruccion("if " + s1 + s2 + s3 + " goto") ;
  codigo.anadirInstruccion("goto") ;
  return tmp ;
}

expresionstruct makearithmetic(std::string &s1, std::string &s2, std::string &s3) {
  expresionstruct tmp ;
  tmp.str = codigo.nuevoId() ;
  codigo.anadirInstruccion(tmp.str + ":=" + s1 + s2 + s3 + ";") ;     
  return tmp ;
}

vector<int> *unir(vector<int> &list1, vector<int> &list2) {
        vector<int> *merged = new vector<int>(list1);
        merged->insert(merged->end(),list2.begin(),list2.end());
        return merged;
}

void printVector(vector<int> &vec){
        for (std::vector<int>::const_iterator i = vec.begin(); i != vec.end(); ++i){
                cout << *i << ' ';
        }
        cout << endl;
}