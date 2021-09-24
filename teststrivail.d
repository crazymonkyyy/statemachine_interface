import machine;
import basic;
unittest{
	counter!3 foo;
	foo.writeln;foo++;
	foo.writeln;foo++;
	foo.writeln;
	foo.ishalt.writeln;
}
unittest{
	"---".writeln;
	parroit!int foo;
	foo.iserror.writeln;
	foo+=1;
	foo.writeln;
	foo++;
	foo.writeln;
	foo++;
}
unittest{
	"---".writeln;
	delaiedassign!int foo;
	foo.get.writeln;
	foo+=1;
	foo.get.writeln;
	foo+=2;
	foo.get.writeln;
	foo++;
	foo.get.writeln;
}
unittest{
	"---".writeln;
	selfrebooting!(counter!3) foo;
	foreach(i;1..10){
		foo.get.writeln;foo++;}
}
unittest{
	"---".writeln;
	selfrebooting!(counter!3,true) foo;
	foreach(i;1..10){
		foo.get.writeln;foo++;}
}
unittest{
	"---".writeln;
	alias M=parroit!int;
	alias N=delaiedassign!int;
	alias zippy=zip!(M,N);
	printy!zippy foo;
	import basic;
	foreach(i;1..30){
		if(uniform(0,2)){
			foo+=uniform(1,10);
		}else{
			foo++;}
}}
