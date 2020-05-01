digit [0-9]
%%
[a-zA-Z]+([a-zA-Z]|{digit})*((_([a-zA-Z]|{digit})+)?)*	 { printf("%s:\tSI\n",yytext); }

.+   	                       		 { printf("%s:\tNO\n",yytext); }
%%

    /*RESULTS:

    obj
    obj:	SI

    obj_tipo1
    obj_tipo1:	SI

    ObJ11
    ObJ11:	SI

    obj_11_tipo2
    obj_11_tipo2:	SI

    1obj
    1obj:	NO

    _obj
    _obj:	NO

    obj_
    obj_:	NO

    obj__tipo1
    obj__tipo1:	NO

    obj_1__aa
    obj_1__aa:	NO

    aux_Var_87
    aux_Var_87:	SI

    */