public enum EnumTag { 
    AND("&&"), OR("||"), NOT("!"), LT("<"), GT(">"), LE("<="), GE(">="), EQ("=="), DIFF("!="),
	PLUS("+"), MINUS("-"), MINUS_U("-"), MULT("*"), DIV("/"), MODULO("%");
    
    private final String tag;
    
    EnumTag(String s){
	tag = s;
    }
    
    public String toString(){
	return tag;
    }
    
}
