* isstable
	- true for endless cycles, possibly once per cycle
* iserror
	- a machine which takes input(or fiddling with its interal state) is unhappy with its state, and is giving a meaningless value
* ishalt
	- empty for ranges/ machine will break if you keep poking it
	- dont define if machine will always produce input?
* isdone
	- if any of the above are true, logic to make should be a mixin