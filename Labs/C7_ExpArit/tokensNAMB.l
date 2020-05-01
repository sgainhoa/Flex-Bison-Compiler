%option yylineno
%option nounput

%{
 #include <string>
 #include <vector>
 #include <algorithm>
 using namespace std ;
 #include "Aux/Aux.hpp"
 #include "parserNAMB.hpp"

 #define TOKEN(t) yylval.str = new std::string(yytext, yyleng) ; return t 
 extern "C" int yywrap() { return(1) ; }  
%}

%%

\/\/.+\n                ;

 
[ \t\n]                 ;
[a-zA-Z_][a-zA-Z0-9_]*  TOKEN( TIDENTIFIER ) ;
[0-9]+                  TOKEN( TINTEGER ) ;

":="                    TOKEN( TASSIG ) ;
"+"                     TOKEN( TPLUS ) ;
"-"                     TOKEN( TMINUS ) ;
"*"                     TOKEN( TMUL ) ;
"/"                     TOKEN( TDIV ) ;

.                       printf("Unknown token!\n"); yyterminate();

%%

