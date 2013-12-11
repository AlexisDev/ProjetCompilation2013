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
  Entier_Neg = ("-"{Entier})
  Reel       = ("-"?{Entier}("."{Entier})?([Ee][+-]?{Entier})?)
  
  Booleen    = ("vrai" | "faux")

  Comment    = (("#!" [^*] ~"!#")|("#!" "!"+ "#"))

  Lettre     = [a-zA-Z]
  Alphabet   = ({Lettre}|[0-9])

  Identificateur = ({Lettre}({Alphabet}|"_")*)

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
"Entier"  { return createSymbol(CompilateurSymbol.ENTIER);              }

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
        Nombres
   ------------------------------------------------- */
{Entier}|{Entier_Neg}  { return createSymbol(CompilateurSymbol.VAL_ENTIER, Integer.parseInt(yytext())); }

/* -------------------------------------------------
        Commentaires - Caracteres non pris en compte
   ------------------------------------------------- */
{Comment} { }

/* -------------------------------------------------
   ------------------------------------------------- */
{Identificateur} { return createSymbol(CompilateurSymbol.IDENTIFICATEUR, new String(yytext())); }
<<EOF>>          { return createSymbol(CompilateurSymbol.COMP_EOF); }
.|\n 	         { }
