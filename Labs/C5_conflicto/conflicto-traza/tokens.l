%option yylineno 

%{
 #include <string>
 #include <iostream>
 #include <vector>
 using namespace std ;
 #include "parser.hpp" 

 #define TOKEN(t) yylval.str = new std::string(yytext, yyleng) ; return t 

 extern "C" int yywrap() { return(1) ; }  

%}

%%
programa                TOKEN(RPROGRAM) ;
comienzo                TOKEN(RBEGIN) ;
fin                     TOKEN(RENDPROGRAM) ;
si                      TOKEN(RIF) ;
entonces                TOKEN(RTHEN) ;
sino                    TOKEN(RELSE) ;

"*"                     TOKEN(TMUL);

"="                     TOKEN(TASSIG);

";"                     TOKEN(TSEMIC);

\/\/.+\n                ;

[ \t\n]                 ;

[a-zA-Z][a-zA-Z0-9]*    TOKEN(TIDENTIFIER) ; 
[0-9]+\.[0-9]*          TOKEN(TDOUBLE);
[0-9]+                  TOKEN(TINTEGER); 

.                       { cout << "Token desconocido: " << yytext << endl; yyterminate();}
%%


