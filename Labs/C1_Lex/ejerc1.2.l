%%
[Pp][Rr][Oo][Cc][Ee][Dd][Uu][Rr][Ee] ;
[Bb][Ee][Gg][Ii][Nn]                 ;
[Ee][Nn][Dd]                         ;
[Tt][Rr][Aa][Zz][Aa]                 ;
[a-zA-Z][a-zA-Z0-9]*                 {printf("[ID]");}
\/\/.+\n                             ;
\n				                     {printf("\n");}
(" "|\t)+                            {printf(" ");}
.                                    ;
%%
