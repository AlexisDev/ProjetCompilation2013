
import java.util.*;
import java.lang.*;

public class TableSymbole{
	Map<String,Variable> variables;
	
	public TableSymbole() {
		variables = new HashMap<String,Variable>();
	}
	
	public void addVar( String name, Variable v ) {
		variables.put(name,v);
	}
	
	public Variable getVar( String var ) {
		return variables.get( var );
	}
}