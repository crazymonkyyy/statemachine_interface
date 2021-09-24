import machineulitity;
/** disables poke and makes it a user defined unit, consider a turn based game with animated piece, user time and turns are two different spectrums of time*/
struct renametime(M,T){
	M mach; alias mach this;
	void poke(){}
	void give(T a){mach.poke;}
	enum isstable=true;//since it wont change no matter how often its poked and time is now a input??? maybe?
	mixin machineopoverloads!();
}