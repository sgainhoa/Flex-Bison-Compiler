%option yylineno
%option nounput

%{
 #include <string>
 #include <vector>
 #include <algorithm>
 using namespace std ;
 #include "Aux/Aux.hpp"
 #include "parserAMB.hpp"

 #define TOKEN(t) yylval.str = new std::string(yytext, yyleng) ; return t 
 extern "C" int yywrap() { return(1) ; }  
%}

%%

\/\/.+\n                ;

program                 TOKEN( RPROGRAM ) ;
is                      TOKEN( RIS ) ;
begin                   TOKEN( RBEGIN ) ;
endprogram              TOKEN( RENDPROGRAM ) ;

 
[ \t\n]                 ;
[a-zA-Z_][a-zA-Z0-9_]*  TOKEN( TIDENTIFIER ) ; 
[0-9]+\.[0-9]*          TOKEN( TDOUBLE ) ;
[0-9]+                  TOKEN( TINTEGER ) ;


";"                     TOKEN( TSEMIC ) ;

":="                    TOKEN( TASSIG ) ;
"+"                     TOKEN( TPLUS ) ;
"-"                     TOKEN( TMINUS ) ;
"*"                     TOKEN( TMUL ) ;
"/"                     TOKEN( TDIV ) ;

.                       printf("Unknown token!\n"); yyterminate();

%%

