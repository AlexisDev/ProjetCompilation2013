import java_cup.runtime.Symbol;

%%
%class CompilateurLexer
%line
%column
%cupsym CompilateurSymbol
%cup
%8bit
 
  Chiffre    = [0-9]
  Entier     = ({Chiffre}+)
  Reel       = ("-"?{Entier}("."{Entier})?([Ee][+-]?{Entier})?)
  
  Booleen    = ("vrai" | "faux")

  Comment    = (("#!" [^*] ~"!#")|("#!" "!"+ "#"))

  Lettre     = [a-zA-Z]
  Alphabet   = ({Lettre}|[0-9])

  Identificateur = ({Lettre}({Alphabet}|"_")*)
  ChaineCar  = (\" [^*] ~\")

  EofComp    = ("$EOF$") /* <<EOF>> */

%{
  private static final boolean isDebug = false;

  private void debug(int l, int c, String s) {
    if(isDebug)
      System.err.println(String.format("[%03d,%03d] %s", l, c, s));
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
":" { return createSymbol(CompilateurSymbol.AFFECT);   }
"(" { return createSymbol(CompilateurSymbol.PAR_OUVR); }
")" { return createSymbol(CompilateurSymbol.PAR_FERM); }

"+" { return createSymbol(CompilateurSymbol.PLUS);     }
"-" { return createSymbol(CompilateurSymbol.MOINS);    }
"*" { return createSymbol(CompilateurSymbol.MULT);     }
"/" { return createSymbol(CompilateurSymbol.DIV);      }
"%" { return createSymbol(CompilateurSymbol.MOD);      }


/* -------------------------------------------------
        Comparaison
   ------------------------------------------------- */
">"  { return createSymbol(CompilateurSymbol.SUP);   }
"<"  { return createSymbol(CompilateurSymbol.INF);   }
"="  { return createSymbol(CompilateurSymbol.EGAL);  }
">=" { return createSymbol(CompilateurSymbol.SUP_E); }
"<=" { return createSymbol(CompilateurSymbol.INF_E); }

/* -------------------------------------------------
        Operateurs booléens
   ------------------------------------------------- */
"OU"  { return createSymbol(CompilateurSymbol.OU);   }
"OUX" { return createSymbol(CompilateurSymbol.OU_X); }
"ET"  { return createSymbol(CompilateurSymbol.ET);   }
"NON" { return createSymbol(CompilateurSymbol.NON);  }
"NOU" { return createSymbol(CompilateurSymbol.N_OU); }
"NET" { return createSymbol(CompilateurSymbol.N_ET); }

/* -------------------------------------------------
        Types simples
   ------------------------------------------------- */
"Entier"  { return createSymbol(CompilateurSymbol.ENTIER);  }
"Reel"    { return createSymbol(CompilateurSymbol.REEL);    }
"Booleen" { return createSymbol(CompilateurSymbol.BOOLEEN); }

/* -------------------------------------------------
        Types complexes
   ------------------------------------------------- */
"Tableau"  { return createSymbol(CompilateurSymbol.TABLEAU);  }
"Pointeur" { return createSymbol(CompilateurSymbol.POINTEUR); }
"Chaine"   { return createSymbol(CompilateurSymbol.CHAINE);   }

/* -------------------------------------------------
        Tests
   ------------------------------------------------- */
"Si"     { return createSymbol(CompilateurSymbol.SI);     }
"Alors"  { return createSymbol(CompilateurSymbol.ALORS);  }
"Sinon"  { return createSymbol(CompilateurSymbol.SINON);  }

"Fin-si" { return createSymbol(CompilateurSymbol.FIN_SI); }

/* -------------------------------------------------
        Boucle
   ------------------------------------------------- */
"Pour"    { return createSymbol(CompilateurSymbol.POUR);     }
"Faire"   { return createSymbol(CompilateurSymbol.FAIRE);    }
"Tantque" { return createSymbol(CompilateurSymbol.TANT_QUE); }
"Repeter" { return createSymbol(CompilateurSymbol.REPETER);  }

"Fin-tantque" { return createSymbol(CompilateurSymbol.FIN_TANT_QUE); }
"Fin-pour"    { return createSymbol(CompilateurSymbol.FIN_POUR);     }

/* -------------------------------------------------
        Bloc
   ------------------------------------------------- */
"Debut"   { return createSymbol(CompilateurSymbol.DEBUT); }
"Fin"     { return createSymbol(CompilateurSymbol.FIN);   }

/* -------------------------------------------------
        Nombres et valeurs
   ------------------------------------------------- */
{Entier}  { return createSymbol(CompilateurSymbol.VAL_ENTIERE, Integer.parseInt(yytext()));   }
{Reel}    { return createSymbol(CompilateurSymbol.VAL_REELLE, Double.parseDouble(yytext()));  }
{Booleen} {
             String str = yytext();
             Boolean b;
             if(str.equalsIgnoreCase("vrai"))
               b = true;
             else
               b = false;
             return createSymbol(CompilateurSymbol.VAL_BOOLEENNE, b);
          }

{Identificateur} { return createSymbol(CompilateurSymbol.IDENTIFICATEUR, new String(yytext())); }
{ChaineCar} { return createSymbol(CompilateurSymbol.VAL_CHAINE, new String(yytext())); }

/* -------------------------------------------------
        Commentaires - Caracteres non pris en compte
   ------------------------------------------------- */
{Comment} { }

/* -------------------------------------------------
        Autres...
   ------------------------------------------------- */
{EofComp} { return createSymbol(CompilateurSymbol.COMP_EOF); }
(.|\n) 	  { }
