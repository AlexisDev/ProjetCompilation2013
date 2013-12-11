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
":" { return createSymbol(CompilateurSymbol.AFFECT); }


/* -------------------------------------------------
        Comparaison
   ------------------------------------------------- */

/* -------------------------------------------------
        Operateurs booléens
   ------------------------------------------------- */

/* -------------------------------------------------
        Types simples
   ------------------------------------------------- */
"Entier"  { return createSymbol(CompilateurSymbol.ENTIER);  }
"Reel"    { return createSymbol(CompilateurSymbol.REEL);    }
"Booleen" { return createSymbol(CompilateurSymbol.BOOLEEN); }

/* -------------------------------------------------
        Types complexes
   ------------------------------------------------- */

/* -------------------------------------------------
        Tests
   ------------------------------------------------- */

/* -------------------------------------------------
        Boucle
   ------------------------------------------------- */

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

/* -------------------------------------------------
        Commentaires - Caracteres non pris en compte
   ------------------------------------------------- */
{Comment}        { }

/* -------------------------------------------------
        Autres...
   ------------------------------------------------- */
<<EOF>>          { return createSymbol(CompilateurSymbol.COMP_EOF); }
(.|\n) 	         { }
