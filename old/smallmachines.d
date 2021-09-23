import interface;
import machine;
struct slowassign_(T,int ticks){
	static assert(ismetric!T, T.stringof~" must define lerp");
	T old_;
	T new_;
	count!ticks i;
	T get(){
		return old_.lerp(new_,float(i)/ticks));}
	void poke(){i++}
	void give(T input){
		if(old_.isbullshit){old_=input;} //should metrics be required to define an invalid state function?
		old_=get;
		i=typeof(i).init;
		new_=input;
	}
	bool isstable(){
		return i.isstable;}
	bool iserror(){
		return old_.isbullshit;}
	void pull(){i--;}
	T foresight(int j){
		return old_.lerp(new_,float(i[j])/ticks));}
}
template slowassign(T,int ticks){
	alias slowassign=addops!slowassign_!(T,ticks);}
struct cycle_(T[] data_){
	enum data=data_;
	countcycle_!data.length i;
	T get(){
		return data[i];}
	void poke(){i++;}
	void pull(){i--;}
	T foresight(int j){return data[i[j]];}
	bool isstable(){return i.isstable;}
}
struct count_(int to){
	int i;
	int get(){
		return i;}
	void poke(){ 
		i++;
		if(i >ticks){
			i=ticks;
	}}
	//give? or should that requore reaching in?
	void pull(){
		i--;
		if(i<0){
			i=0;
	}}
	int foresight(int i){
		return min(to,max(0,i));}
	bool isstable(){
		return i==to;}
}
template count(T,int ticks){
	alias count=addops!count_!(T,ticks);}
struct countcycle_(int to){
	int i;
	int get(){
		return i;}
	void poke(){
		i++; i%=to;}
	void pull(){
		i--; i%=to;}//I know this doesnt work, but I'm not looking into modulous defination right now
	int forsight(int j){
		return (i+j)%to;}
	bool isstable(){
		i==to-1;}
}
template evenodd(){
	alias evenodd=countcycle!2.map!(tobool);
}