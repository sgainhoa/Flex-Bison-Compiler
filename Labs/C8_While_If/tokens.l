%option yylineno
%option nounput

%{
 #include <string>
 #include <vector>
 #include <algorithm>
 using namespace std ;
 #include "Aux.hpp"
 #include "parser.hpp"

 #define TOKEN(t) yylval.str = new std::string(yytext, yyleng) ; return t 
 extern "C" int yywrap() { return(1) ; }  
%}

%%

\/\/.+\n                ;

program                 TOKEN( RPROGRAM ) ;
is                      TOKEN( RIS ) ;
begin                   TOKEN( RBEGIN ) ;
endprogram              TOKEN( RENDPROGRAM ) ;
var                     TOKEN( RVAR ) ;
integer                 TOKEN( RINTEGER ) ;
float                   TOKEN( RFLOAT ) ;
if                      TOKEN( RIF ) ;
then                    TOKEN( RTHEN ) ;
else                    TOKEN( RELSE ) ;
endif                   TOKEN( RENDIF ) ;
do                      TOKEN( RDO ) ;
while			        TOKEN( RWHILE ) ;
endwhile		        TOKEN( RENDWHILE ) ;
endrepeat               TOKEN( RENDREPEAT );
repeat                  TOKEN( RREPEAT );
until                   TOKEN( RUNTIL ); 

[ \t\n]                 ;
[a-zA-Z_][a-zA-Z0-9_]*  TOKEN( TIDENTIFIER ) ; 
[0-9]+\.[0-9]*          TOKEN( TDOUBLE ) ;
[0-9]+                  TOKEN( TINTEGER ) ;

"="                     TOKEN( TCEQ ) ;
"<"                     TOKEN( TCLT ) ;
"<="                    TOKEN( TCLE ) ;
">"                     TOKEN( TCGT ) ;
">="                    TOKEN( TCGE ) ;

"("                     TOKEN( TLPAREN ) ;
")"                     TOKEN( TRPAREN ) ;

 ","                    TOKEN( TCOMMA ) ;    

":"                     TOKEN( TCOLON ) ;
";"                     TOKEN( TSEMIC ) ;

":="                    TOKEN( TASSIG ) ;
"+"                     TOKEN( TPLUS ) ;
"-"                     TOKEN( TMINUS ) ;
"*"                     TOKEN( TMUL ) ;
"/"                     TOKEN( TDIV ) ;

.                       printf("Unknown token!\n"); yyterminate();

%%

