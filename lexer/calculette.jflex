import java_cup.runtime.Symbol;

%%
%class CalculetteLexer
%line
%column
%cupsym CalculetteSymbol
%cup
%8bit

Number    = "-"?[[:digit:]]+(\.[[:digit:]]+)?([Ee][+-]?[[:digit:]]+)?
Boolean   = "true" | "false"
Comment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"

%{
    private void debug(int l, int c, String s) {
	/*
	  System.err.println(String.format("[%03d,%03d] %s", l, c, s));
	//*/
    }

    private Symbol createSymbol(int type) {
	debug(yyline, yycolumn, yytext());
	return new Symbol(type, yyline, yycolumn);
    }

    private Symbol createSymbol(int type, Object value) {
    	debug(yyline, yycolumn, yytext());
	return new Symbol(type, yyline, yycolumn, value);
    }
%}

%%

/* -------------------------------------------------
        Operateurs
   ------------------------------------------------- */
"+"    	     { return createSymbol(CalculetteSymbol.PLUS);	}
"-"    	     { return createSymbol(CalculetteSymbol.MINUS);	}
"*"          { return createSymbol(CalculetteSymbol.TIMES);	}
"/"          { return createSymbol(CalculetteSymbol.DIVIDE);	}
"%"	     { return createSymbol(CalculetteSymbol.MODULO);	}
"("          { return createSymbol(CalculetteSymbol.LPAR);	}
")"          { return createSymbol(CalculetteSymbol.RPAR);	}
";"          { return createSymbol(CalculetteSymbol.SEMIC);	}
","	     { return createSymbol(CalculetteSymbol.COMA);	}


/* -------------------------------------------------
        Comparaison
   ------------------------------------------------- */
"=="	     { return createSymbol(CalculetteSymbol.EQ);	}
"!="         { return createSymbol(CalculetteSymbol.DIFF);	}
"<="         { return createSymbol(CalculetteSymbol.LE);	}
">="         { return createSymbol(CalculetteSymbol.GE);	}
"<"	     { return createSymbol(CalculetteSymbol.LT);	}
">"          { return createSymbol(CalculetteSymbol.GT);	}

/* -------------------------------------------------
        Operateurs booléens
   ------------------------------------------------- */
"&&"         { return createSymbol(CalculetteSymbol.AND);	}
"||"         { return createSymbol(CalculetteSymbol.OR);	}
"!"          { return createSymbol(CalculetteSymbol.NOT);	}

/* -------------------------------------------------
        Operateurs ternaires
   ------------------------------------------------- */
"?"         { return createSymbol(CalculetteSymbol.THEN);	}
":"         { return createSymbol(CalculetteSymbol.ELSE);	}


/* -------------------------------------------------
        Nombres
   ------------------------------------------------- */
{Number}     { return createSymbol(CalculetteSymbol.NUMBER,	new Float(yytext()));	}
{Boolean}    { return createSymbol(CalculetteSymbol.BOOLEAN,	new Boolean(yytext()));	}

/* -------------------------------------------------
        Commentaires - Caracteres non pris en compte
   ------------------------------------------------- */
{Comment}    { }

/* -------------------------------------------------
   ------------------------------------------------- */
.|\n 	     { }
