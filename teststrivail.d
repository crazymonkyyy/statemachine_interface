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