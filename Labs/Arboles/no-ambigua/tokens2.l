%option yylineno 
%option nounput

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
"+"                     TOKEN(TPLUS);
"-"                     TOKEN(TMINUS);
"*"                     TOKEN(TMUL);
"/"                     TOKEN(TDIV);

\(\*([^*]|\*+[^*)])*\*+\)          ;

[ \t\n]                 ;

[a-zA-Z][a-zA-Z0-9]*    TOKEN(TIDENTIFIER);
[0-9]+                  TOKEN(TINTEGER); 

.                       { cout << "Token desconocido: " << yytext << endl; yyterminate();}
%%


