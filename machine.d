public import interface;
public import smallmachines;

struct addops(T){
	T payload; alias payload this;
	alias payload.get this;
	++(){poke;}
	+=(){give;}
	--(){pull;}
	[](int i){forsight[i];}
}
struct zip(M, args..){
	M mainmachine; alias mainmachine this;
	alias machines=args...
	alias names=args...
	static foreach(i,name;names){
		mixin("machines[i] "~name~";");}
	poke,pull,etc.
}
hotswap
renamemetadata
struct changespeed(M, int num, int dom){
	M mach; alias mach this;
	int i;
	void poke(){
		i+=num;
		while(i>dom){
			mach.poke;
			i-=dom;
		}
	}
	T forsight(int j){
		j*=num; j/=dom;
		return mach[j];
	}
}
rememberstate
struct lerp(M,int by){
	M mach; alias mach this;
	T get(){
		return mach.lerp(mach[by],.5);}
	forsight(int j){
		return mach[j].lerp(mach[by+j],.5);}
	...
}