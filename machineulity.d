mixin template machineopoverloads(){
	void opUnary(string s:"++")(){
		this.poke;}
	alias get this;
	void opOpAssign(string s:"+",T)(T a){
		give(a);
	}
}
