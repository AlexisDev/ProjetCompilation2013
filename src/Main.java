import java.io.FileReader;
import java_cup.runtime.Symbol;
//import java_cup.runtime.*;

public class Main {

    public static void main(String[] args) {
	System.out.println("==============================================");
	try {
	    System.out.println("Début de la compilation !");

	    System.out.println("#1 : Ouverture du fichier \"" + args[0] + "\"");
	    FileReader  myFile = new FileReader(args[0]);

	    System.out.println("#2 : Création du lexer");
	    CompilateurLexer myLex = new CompilateurLexer(myFile);

	    System.out.println("#3 : Création du parser");
	    CompilateurParser myParser = new CompilateurParser(myLex);

	    try {
		System.out.println("#4 : Début de l'analyse...");
		System.out.println("==============================================");
		
		myParser.parse();
	    } catch(Exception ex) {
		System.out.println("==============================================");
		System.err.println("#erreur : parse error !");
		System.out.println("==============================================");
	    }

	} catch(ArrayIndexOutOfBoundsException ex) {
	    System.err.println("#erreur : aucun fichier à analyser !");
	    System.out.println("==============================================");
	} catch(Exception ex) {
	    System.err.println("#erreur : fichier \"" + args[0] + "\" invalide !");
	    System.out.println("==============================================");
	}
    }
}
