%{
int contID = 0;
int contReal = 0;
%}

%%
\/\/.+\n 							 ;
[Pp][Rr][Oo][Cc][Ee][Dd][Uu][Rr][Ee] ;
[Bb][Ee][Gg][Ii][Nn]                 ;
[Ee][Nn][Dd]                         ;
[a-zA-Z]+(([a-zA-Z0-9]*|\_)[a-zA-Z0-9])*  {contID++;}
[0-9]+\.[0-9]+([Ee](\+|\-)?[0-9]+)?  {contReal++;}
\n    				     ;
.      				     ;
%%
void main() {
  yylex() ;
  printf("Num Id's: %d\n",contID);
  printf("Num Reales: %d\n",contReal);
}
