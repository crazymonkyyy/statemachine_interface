import basic;
struct lerpstring{
	string s;
	lerpstring lerp(lerpstring a, float perc){
		return lerpstring(s~" was lerped "~(perc*100).to!string~"% with "~a.s);}
	enum isbullshit=false;
}
auto torange(T)(T a){
	struct range{
		auto front(){return a.get;}
		auto popFront(){a.poke;}
		auto empty(){return a.isstable;}
	}
	return range();
}
struct countcycle(int to){
	int i;
	int get(){
		return i;}
	void poke(){
		i++; i%=to;}
	void pull(){
		i--; i%=to;}//I know this doesnt work, but I'm not looking into modulous defination right now
	int foresight(int j){
		return (i+j)%to;}
	bool isstable(){
		return i==to-1;}
}

struct cycle(alias data_){
	alias T=typeof(data_[0]);
	enum T[] data=data_;
	countcycle!(data.length+1) i;//+1 to make a off by one error go away, it probaly shouldnt be here
											// I dont see how countcycle could be incorrect tho
	T get(){
		return data[i.get%$];}//why is this % nessery? is cycle count super wrong?
	void poke(){i.poke;}
	void pull(){i.pull;}
	T foresight(int j){return data[i.foresight(j)];}
	bool isstable(){return i.isstable;}
}
unittest{
	alias rainbow=cycle!(["red","yellow","blue"]);
	foreach(s;rainbow().torange){
		s.writeln;}
}
unittest{
	enum lerpstring[] colors=[lerpstring("red"),lerpstring("green"),lerpstring("blue")];
	alias rainbow_=cycle!(colors);
	foreach(s;rainbow_().torange){
		s.writeln;}
}
unittest{
	alias rainbow=cycle!([1,2,3]);
	foreach(s;rainbow().torange){
		s.writeln;}
}
struct delayassign(T){
	T current;
	T future;
	T get(){ return current;}
	void poke(){current=future;}
	T foresight(int i){
		if(i!=0){return future;}
		else{return current;}
	}
	bool isstable(){return current==future;}
	bool iserror(){return false;}//current.isbullshit;}
	void give(T a){
		//if(current.isbullshit){current=a;}
		future=a;
	}
}
//need those opoverloads :skull:
//struct slowlerp(M,int ticks){
//	M mach; alias mach this;
//	alias T=typeof(mach.get());
//	delayassign!T activeelement;
//	countcycle!ticks count;
//	void init(){
//		activeelement.give(mach);
//		activeelement.give(mach);
//	}
//	T get(){
//		return activeelement.lerp(activeelement[1],float(count)/ticks);}
//	void poke(){
//		count.poke;
//		if(count.isstable){
//			activeelement.poke;
//			activeelement.give(mach);
//			mach.poke;
//			count.poke; assert(count==0);
//		}
//	}
//	//todo foresight
//}
struct slowlerp(M,int ticks){
	M mach; alias mach this;
	alias T=typeof(mach.get());
	delayassign!T activeelement;
	delayassign!bool wasmachstable;
	countcycle!ticks count;
	void init(){
		wasmachstable.give(mach.isstable);
		activeelement.give(mach.get);
		mach.poke;
		activeelement.poke;
		wasmachstable.give(mach.isstable);
		activeelement.give(mach.get);
		mach.poke;
	}
	T get(){
		return activeelement.get.lerp(activeelement.foresight(1),cast(float)count.get/ticks);}
	void poke(){
		if(count.isstable){
			activeelement.poke;
			wasmachstable.poke;
			wasmachstable.give(mach.isstable);
			activeelement.give(mach.get);
			mach.poke;
			count.poke; assert(count.get==0);
		} else{
			count.poke;
	}}
	bool isstable(){
		return wasmachstable.get && count.isstable;}
	//todo foresight
}
unittest{
	enum lerpstring[] colors=[lerpstring("red"),lerpstring("green"),lerpstring("blue")];
	alias smoothrainbow=slowlerp!(cycle!(colors),4);
	smoothrainbow rainbow; rainbow.init;
	foreach(s;rainbow.torange){
		s.writeln;}
}