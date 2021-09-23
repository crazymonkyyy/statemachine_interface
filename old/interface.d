//I primarily use pure duck typing, gaint todo
template ismachine(T){
	static if(true /*has get and poke*/){
		alias ismachine=true;
}}
template ispropermachine(T){
	static if(true /*doesnt have alias get this, or ++ overloaded*/){
		alias ispropermachine=false;
}}
template takesinput(T){
	static if(true /*has +=*/){
		alias takesinput=true;
}}
template primarydata(T){
	//the return type of get
}
template inputtypes(T){
	//types that the overload += work with
}
template ismertic(T){
	//has lerp, add, others?
	hasmetricfunctions=true;
	//isbullshit for isnan for floats? uninitalized states? divide by zeros?
}