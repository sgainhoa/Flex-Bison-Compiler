digit [0-9]
%%
\(\*(\*+[^*)]|[^*]\)+|[^*)])*\*+\)	 { printf("%s:\tSI\n",yytext); }

.+   	                       		 { printf("%s:\tNO\n",yytext); }
%%

    /*RESULTS

    (*ak()))sr*)
    (*ak()))sr*):	SI

    (*-------*)
    (*-------*):	SI

    (*AS*09dkf$ls*)
    (*AS*09dkf$ls*):	SI

    (*9aesk3 asdl****)
    (*9aesk3 asdl****):	SI

    (******)
    (******):	SI

    (JSIAODF*)
    (JSIAODF*):	NO

    (*ksalfd*)09asdkfll*)
    (*ksalfd*)09asdkfll*):	NO

    (*poid*****)****)
    (*poid*****)****):	NO

    (*(*(*fkmdhbvhbdfah*)*)*)
    (*(*(*fkmdhbvhbdfah*)*)*):	NO

    *(jhvascd)*   
    *(jhvascd)*:	NO

    */

    /* EJEMPLO1.p

    program                  ejemplo                   (input,output);:	NO

    var estas,variables,no,sirven:integer;:	NO

        para,nada,ni,	   esta,pero_     esta_es_diferente:char;:	NO


    procedure ahora (var vienen:integer;los:integer);:	NO

    var procedimientos:integer;:	NO

    // Como ves	 hay anidamiento:	NO

    // * y comentarios:	NO

    // * de una       sola:	NO

    // * línea                                   :	NO


        procedure 	primer;:	NO

        var   		procedimiento:   	integer;:	NO

        begin:	NO

        no:=no+		1;:	NO

        end;  { primer }:	NO

    :	NO

        traza procedure segundo;:	NO

        var procedimiento:char		;:	NO

            i        :real;:	NO

        begin:	NO

        primer;:	NO

        // prueba de reales :	NO

        i := 1.456 ;:	NO

        i := 0.001E-10 ;:	NO

        i := 100.0e2 ;:	NO

        end;:	NO

    begin:	NO

    procedimientos := 0;:	NO

    while procedimientos < 10    do:	NO

            begin:	NO

            procedimientos := 	procedimientos + 1;:	NO

            segundo;:	NO

            end;:	NO

            // end :	NO

    end;:	NO


    begin // comienza el 	Programa      Principal :	NO

    read(estas);:	NO

    ahora(estas,variables		);:	NO

    writeln(estas);:	NO

    end.  // acaba el programa    	principal   :	NO

    */
