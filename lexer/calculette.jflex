import java_cup.runtime.Symbol;

%%
%class CalculetteLexer
%line
%column
%cupsym CalculetteSymbol
%cup
%8bit

Entier    = [[:digit:]]
Reel      = "-"?[[:digit:]]+(\.[[:digit:]]+)?([Ee][+-]?[[:digit:]]+)?
Boolean   = "vrai" | "faux"
Comment   = "#!" [^*] ~"!#" | "#!" "!"+ "#"

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
"-"    	     { return createSymbol(CalculetteSymbol.MOINS);	}
"*"          { return createSymbol(CalculetteSymbol.FOIS);	}
"/"          { return createSymbol(CalculetteSymbol.DIVISER);	}
"%"	     { return createSymbol(CalculetteSymbol.MODULO);	}
"("          { return createSymbol(CalculetteSymbol.PAR_OUV);	}
")"          { return createSymbol(CalculetteSymbol.PAR_FER);	}
","	     { return createSymbol(CalculetteSymbol.VIRGULE);	}
"["          { return createSymbol(CalculetteSymbol.CRO_OUV);   }
"]"          { return createSymbol(CalculetteSymbol.CRO_FER);   }
"."          { return createSymbol(CalculetteSymbol.POINT);     }
"@"          { return createSymbol(CalculetteSymbol.AROBASE);   }
":"          { return createSymbol(CalculetteSymbol.AFFECT);	}


/* -------------------------------------------------
        Comparaison
   ------------------------------------------------- */
"=="	     { return createSymbol(CalculetteSymbol.EGAL);	}
"!="         { return createSymbol(CalculetteSymbol.DIFF);	}
"<="         { return createSymbol(CalculetteSymbol.IE);	}
">="         { return createSymbol(CalculetteSymbol.SE);	}
"<"	     { return createSymbol(CalculetteSymbol.INF);	}
">"          { return createSymbol(CalculetteSymbol.SUP);	}

/* -------------------------------------------------
        Operateurs booléens
   ------------------------------------------------- */
"OU"         { return createSymbol(CalculetteSymbol.OU);  }
"ET"         { return createSymbol(CalculetteSymbol.ET);  }
"OU-X"       { return createSymbol(CalculetteSymbol.OUX); }
"N-OU"       { return createSymbol(CalculetteSymbol.NOU); }
"N-ET"       { return createSymbol(CalculetteSymbol.NET); }
"NON"        { return createSymbol(CalculetteSymbol.NON); }

/* -------------------------------------------------
        Types simples
   ------------------------------------------------- */
"Entier"             { return createSymbol(CalculetteSymbol.ENTIER);              }
"GrosEntier"         { return createSymbol(CalculetteSymbol.GROS_ENTIER);         }
"EntierPositif"      { return createSymbol(CalculetteSymbol.ENTIER_POSITIF);      }
"GrosEntierPositif"  { return createSymbol(CalculetteSymbol.GROS_ENTIER_POSITIF); }

"Booleen"            { return createSymbol(CalculetteSymbol.BOOLEEN);     }

"Caractere"          { return createSymbol(CalculetteSymbol.CARACTERE);   }

"Reel"               { return createSymbol(CalculetteSymbol.REEL);        }

"Enumeration"        { return createSymbol(CalculetteSymbol.ENUMERATION); }
"Rien"               { return createSymbol(CalculetteSymbol.RIEN);}

/* -------------------------------------------------
        Types complexes
   ------------------------------------------------- */
"Chaine"             { return createSymbol(CalculetteSymbol.CHAINE);   }
"Tableau"            { return createSymbol(CalculetteSymbol.TABLEAU);  }
"Pointeur"           { return createSymbol(CalculetteSymbol.POINTEUR); }

/* -------------------------------------------------
        Tests
   ------------------------------------------------- */
"Si"                 { return createSymbol(CalculetteSymbol.SI);      }
"alors"              { return createSymbol(CalculetteSymbol.ALORS);   }
"Sinon-si"           { return createSymbol(CalculetteSymbol.SINONSI); }
"Sinon"              { return createSymbol(CalculetteSymbol.SINON);   }
"Fin-si"             { return createSymbol(CalculetteSymbol.FINSI);   }


/* -------------------------------------------------
        Boucle
   ------------------------------------------------- */
"Pour"                 { return createSymbol(CalculetteSymbol.POUR);       }
"dans"                 { return createSymbol(CalculetteSymbol.DANS);       }
"faire"                { return createSymbol(CalculetteSymbol.FAIRE);      }
"Fin-pour"             { return createSymbol(CalculetteSymbol.FINPOUR);    }

"Tantque"              { return createSymbol(CalculetteSymbol.TANTQUE);    }
"Fin-tantque"          { return createSymbol(CalculetteSymbol.FINTANTQUE); }

/* -------------------------------------------------
        Bloc
   ------------------------------------------------- */
"Fonction"             { return createSymbol(CalculetteSymbol.FONCTION);}
"Fin-fonction"         { return createSymbol(CalculetteSymbol.FINFONCTION);} 
"Debut"                { return createSymbol(CalculetteSymbol.DEBUT); }
"Fin"                  { return createSymbol(CalculetteSymbol.FIN);   }

/* -------------------------------------------------
        Nombres
   ------------------------------------------------- */
{Entier}     { return createSymbol(CalculetteSymbol.VALENTIER,  new Integer(yytext())); }
{Reel}       { return createSymbol(CalculetteSymbol.VALREEL,	new Double(yytext()));	}
{Boolean}    { return createSymbol(CalculetteSymbol.VALBOOLEEN,	new Boolean(yytext()));	}

/* -------------------------------------------------
        Commentaires - Caracteres non pris en compte
   ------------------------------------------------- */
{Comment}    { }

/* -------------------------------------------------
   ------------------------------------------------- */
[a-zA-Z][a-zA-Z0-9]* { return createSymbol(CalculetteSymbol.CHAINE_CARACTERES, new String( yytext() )); }
.|\n 	     { }
