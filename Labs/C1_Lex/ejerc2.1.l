digit [0-9]
%%
[-+]?{digit}+\.{digit}+([eE][-+]?[1-9]{digit}*)?	 { printf("%s:\tSI\n",yytext); }

.+   	                       		 { printf("%s:\tNO\n",yytext); }
%%

    /*RESULTS

    10.0
    10.0:	SI

    10.00e10
    10.00e10:	SI

    0.001e+10
    0.001e+10:	SI

    0.10E-3
    0.10E-3:	SI

    98.009e+32
    98.009e+32:	SI

    10e3
    10e3:	NO

    10E-3
    10E-3:	NO

    10.0e+-6
    10.0e+-6:	NO

    23
    23:	NO

    12.54ee12
    12.54ee12:	NO

    */
