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
\(\*(\*+[^\)]|[^\*])*\*+\)                           ;
#([^#\n])*$                                          ;
[ \t\n]                                              ;
prog                                                 TOKEN(RPROGRAM);
int                                                  TOKEN(RINTEGER);
float                                                TOKEN(RFLOAT);
if                                                   TOKEN(RIF);
then                                                 TOKEN(RTHEN);
forever                                              TOKEN(RFOREVER);
while                                                TOKEN(RWHILE);
loop                                                 TOKEN(RLOOP);
finally                                              TOKEN(RFINALLY);
exit if                                              TOKEN(REXITIF);
read                                                 TOKEN(RREAD);
println                                              TOKEN(RPRINT);
proc                                                 TOKEN(RPROC);
in                                                   TOKEN(RIN);
out                                                  TOKEN(ROUT);
"*"                                                  TOKEN(TMUL);
"/"                                                  TOKEN(TDIV);
"="                                                  TOKEN(TASSIG);
";"                                                  TOKEN(TSEMIC);
","                                                  TOKEN(TCOMMA);
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
"-"                                                  TOKEN(TMINUS);
[a-zA-Z](_?[a-zA-Z0-9])*                             TOKEN(TIDENTIFIER) ; 
[0-9]+\.[0-9]+([Ee](\+|\-)?[0-9]+)?                  TOKEN(TFLOAT);
[0-9]+                                               TOKEN(TINTEGER); 

.                       { cout << "Token desconocido: " << yytext << endl; yyterminate();}
%%


