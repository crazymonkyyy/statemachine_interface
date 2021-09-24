mixin template machineopoverloads(){
	void opUnary(string s:"++")(){
		this.poke;}
	alias get this;
	void opOpAssign(string s:"+",T)(T a){
		give(a);
	}
}
mixin template compositionopoverloads(){
	void opUnary(string s:"++")(){
		this.poke;}
	void opOpAssign(string s:"+",T)(T a){
		give(a);
	}
}
