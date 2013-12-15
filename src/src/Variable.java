package src;

import java.lang.*;

public class Variable{
	public String type;
	public String value;
	// The place of the variable, ie. the line where it appears the first time (where it's declared)
	// so we can load it later in the code using the place
	public Integer place;
	
	public Variable( String _type, String _value, Integer _place ) {
		type = _type;
		value = _value;
		place = _place;
	}
}