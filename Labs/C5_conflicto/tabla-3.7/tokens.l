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
i                 TOKEN(RIF) ;
e                 TOKEN(RELSE) ;
a				  TOKEN(TIDENTIFIER) ; 

[ \t\n]                 ;
.                       { cout << "Token desconocido: " << yytext << endl; yyterminate();}
%%


