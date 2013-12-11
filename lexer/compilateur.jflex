import java_cup.runtime.Symbol;

%%
%class CompilateurLexer
%line
%column
%cupsym CompilateurSymbol
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
"+"    	     { return createSymbol(CompilateurSymbol.PLUS);	}
"-"    	     { return createSymbol(CompilateurSymbol.MOINS);	}
"*"          { return createSymbol(CompilateurSymbol.FOIS);	}
"/"          { return createSymbol(CompilateurSymbol.DIVISER);	}
"%"	     { return createSymbol(CompilateurSymbol.MODULO);	}
"("          { return createSymbol(CompilateurSymbol.PAR_OUV);	}
")"          { return createSymbol(CompilateurSymbol.PAR_FER);	}
","	     { return createSymbol(CompilateurSymbol.VIRGULE);	}
"["          { return createSymbol(CompilateurSymbol.CRO_OUV);   }
"]"          { return createSymbol(CompilateurSymbol.CRO_FER);   }
"."          { return createSymbol(CompilateurSymbol.POINT);     }
"@"          { return createSymbol(CompilateurSymbol.AROBASE);   }
":"          { return createSymbol(CompilateurSymbol.AFFECT);	}


/* -------------------------------------------------
        Comparaison
   ------------------------------------------------- */
"=="	     { return createSymbol(CompilateurSymbol.EGAL);	}
"!="         { return createSymbol(CompilateurSymbol.DIFF);	}
"<="         { return createSymbol(CompilateurSymbol.IE);	}
">="         { return createSymbol(CompilateurSymbol.SE);	}
"<"	     { return createSymbol(CompilateurSymbol.INF);	}
">"          { return createSymbol(CompilateurSymbol.SUP);	}

/* -------------------------------------------------
        Operateurs booléens
   ------------------------------------------------- */
"OU"         { return createSymbol(CompilateurSymbol.OU);  }
"ET"         { return createSymbol(CompilateurSymbol.ET);  }
"OU-X"       { return createSymbol(CompilateurSymbol.OUX); }
"N-OU"       { return createSymbol(CompilateurSymbol.NOU); }
"N-ET"       { return createSymbol(CompilateurSymbol.NET); }
"NON"        { return createSymbol(CompilateurSymbol.NON); }

/* -------------------------------------------------
        Types simples
   ------------------------------------------------- */
"Entier"             { return createSymbol(CompilateurSymbol.ENTIER);              }
"GrosEntier"         { return createSymbol(CompilateurSymbol.GROS_ENTIER);         }
"EntierPositif"      { return createSymbol(CompilateurSymbol.ENTIER_POSITIF);      }
"GrosEntierPositif"  { return createSymbol(CompilateurSymbol.GROS_ENTIER_POSITIF); }

"Booleen"            { return createSymbol(CompilateurSymbol.BOOLEEN);     }

"Caractere"          { return createSymbol(CompilateurSymbol.CARACTERE);   }

"Reel"               { return createSymbol(CompilateurSymbol.REEL);        }

"Enumeration"        { return createSymbol(CompilateurSymbol.ENUMERATION); }
"Rien"               { return createSymbol(CompilateurSymbol.RIEN);}

/* -------------------------------------------------
        Types complexes
   ------------------------------------------------- */
"Chaine"             { return createSymbol(CompilateurSymbol.CHAINE);   }
"Tableau"            { return createSymbol(CompilateurSymbol.TABLEAU);  }
"Pointeur"           { return createSymbol(CompilateurSymbol.POINTEUR); }

/* -------------------------------------------------
        Tests
   ------------------------------------------------- */
"Si"                 { return createSymbol(CompilateurSymbol.SI);      }
"alors"              { return createSymbol(CompilateurSymbol.ALORS);   }
"Sinon-si"           { return createSymbol(CompilateurSymbol.SINONSI); }
"Sinon"              { return createSymbol(CompilateurSymbol.SINON);   }
"Fin-si"             { return createSymbol(CompilateurSymbol.FINSI);   }


/* -------------------------------------------------
        Boucle
   ------------------------------------------------- */
"Pour"                 { return createSymbol(CompilateurSymbol.POUR);       }
"dans"                 { return createSymbol(CompilateurSymbol.DANS);       }
"faire"                { return createSymbol(CompilateurSymbol.FAIRE);      }
"Fin-pour"             { return createSymbol(CompilateurSymbol.FINPOUR);    }

"Tantque"              { return createSymbol(CompilateurSymbol.TANTQUE);    }
"Fin-tantque"          { return createSymbol(CompilateurSymbol.FINTANTQUE); }

/* -------------------------------------------------
        Bloc
   ------------------------------------------------- */
"Fonction"             { return createSymbol(CompilateurSymbol.FONCTION);}
"Fin-fonction"         { return createSymbol(CompilateurSymbol.FINFONCTION);} 
"Debut"                { return createSymbol(CompilateurSymbol.DEBUT); }
"Fin"                  { return createSymbol(CompilateurSymbol.FIN);   }

/* -------------------------------------------------
        Nombres
   ------------------------------------------------- */
{Entier}     { return createSymbol(CompilateurSymbol.VALENTIER,  new Integer(yytext())); }
{Reel}       { return createSymbol(CompilateurSymbol.VALREEL,	new Double(yytext()));	}
{Boolean}    { return createSymbol(CompilateurSymbol.VALBOOLEEN,	new Boolean(yytext()));	}

/* -------------------------------------------------
        Commentaires - Caracteres non pris en compte
   ------------------------------------------------- */
{Comment}    { }

/* -------------------------------------------------
   ------------------------------------------------- */
[a-zA-Z][a-zA-Z0-9]* { return createSymbol(CompilateurSymbol.CHAINE_CARACTERES, new String( yytext() )); }
.|\n 	     { }
