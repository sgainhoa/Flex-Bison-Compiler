%option yylineno 

%{
 #include <string>
 #include <iostream>
 #include <vector>
 using namespace std ;
 #include "parser.hpp" 
 using namespace std;

 #define TOKEN(t) yylval.str = new string(yytext, yyleng) ; return t 

 extern "C" int yywrap() { return(1) ; }  

%}

%%
prog                                                 TOKEN(RPROGRAM);
int                                                  TOKEN(RINTEGER);
float                                                TOKEN(RFLOAT);
"*"                                                  TOKEN(TMUL);
"="                                                  TOKEN(TASSIG);
";"                                                  TOKEN(TSEMIC);
"{"                                                  TOKEN(TLBRACE);
"}"                                                  TOKEN(TRBRACE);
"("                                                  TOKEN(TLPAREN);
")"                                                  TOKEN(TRPAREN);
"=="                                                 TOKEN(TCEQ);
">"                                                  TOKEN(TCGT);
"<"                                                  TOKEN(TCLT);
">="                                                 TOKEN(TCGE);
"<="                                                 TOKEN(TCLE);
"/="                                                 TOKEN(TCNE);
"+"                                                  TOKEN(TPLUS);
\(\*(\*+[^*)]|[^*]\)+|[^*)])*\*+\)                   ;
#([^#\n])*$                                          ;
[ \t\n]                                              ;
[a-zA-Z](_?[a-zA-Z0-9])*                             TOKEN(TIDENTIFIER) ; 
[0-9]+\.[0-9]+([Ee](\+|\-)?[0-9]+)?                  TOKEN(TDOUBLE);
[0-9]+                                               TOKEN(TINTEGER); 

.                       { cout << "Token desconocido: " << yytext << endl; yyterminate();}
%%


