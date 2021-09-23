import machineulity;
/** counts from 0 to n, noninclusive, then halts */
struct counter(int to){
	int i;
	auto get(){return i;}
	void poke(){i++;assert(i<to);}
	bool ishalt(){return i==to-1;}
	mixin machineopoverloads!();
}
/** takes input, repeats it back*/
struct parroit(T){
	T[] store;
	auto get(){
		if(store.length==0){return T.init;}
		return store[0];
	}
	void poke(){
		if(store.length>0){
			store=store[1..$];}}
	bool iserror(){return store.length==0;}
	void give(T a){store~=a;}
	mixin machineopoverloads!();
}
import metricintrspection;
/** return last input, but doesnt change (valid) state inbetween pokes*/
struct delaiedassign(T,T init=bullshitof!T){
	T old_=init;
	T new_=init;
	auto get(){return old_;}
	void poke(){old_=new_;}
	void give(T a){
		new_=a;
		if(old_.isbullshit){old_=a;}
	}
	bool isstable(){return old_==new_;}
	bool iserror(){return old_.isbullshit;}
	mixin machineopoverloads!();
}