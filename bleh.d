struct foo{
	int opCall(){
		return 1;}
}
unittest{
	foo bar;
	int i=bar;
}