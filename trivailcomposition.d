import machineulity;
/** if the machine halts, restart.
detect loops may work if the machine is fairly deterministic,
just dont trust it to much tho
*/
struct selfrebooting(M,bool detectloops=false){
	M mach; alias mach this;
	static if(detectloops){
		M storedfailedstate;
	}
	void checkhalt(){
		if(mach.ishalt){
			static if(detectloops){
				if(mach==storedfailedstate){goto exit;}
				storedfailedstate=mach;
			}
			mach=M.init;
		}
		exit:
	}
	/* ref? */ auto get(){
		checkhalt();
		return mach.get;
	}
	void poke(){if( ! ishalt){mach++;}}
	bool ishalt(){
		checkhalt();
		static if(detectloops){
			return mach.ishalt&&storedfailedstate;
		} else {
			return false;
		}
	}
	static if(detectloops){
		bool isstable(){
			return /*mach.isstable ||*/ storedfailedstate==mach;//need interspection tools to look for is stable defination
		}
	}
	mixin compositionopoverloads!();
}
struct printy(M){
	M mach; alias mach this;
	import std.stdio;
	void poke(){
		mach++;
		mach.get.writeln(" was poke");
	}
	void give(T)(T a){
		a.writeln(" was give");
		mach+=a;
	}
	mixin compositionopoverloads!();
}
struct zip(M,N){
	M mach1; alias mach1 this;//should be an awful opdispatch
	N mach2;
	struct pair{//should allow more then 2
		typeof(M.get()) _1;
		typeof(N.get()) _2;
	}
	void poke(){mach1++; mach2++;}
	pair get(){
		return pair(mach1.get,mach2.get);}
	void give(T)(T a){
		mach1+=a;
		mach2+=a;//should intelligently detect if it accepted
	}
	//todo AHHHHHHHHHHHH
	mixin compositionopoverloads!();
}