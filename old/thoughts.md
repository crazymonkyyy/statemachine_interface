The fundamental functions of a machine are `get` and `poke`, in the same way ranges have `front`, `pop` and `empty`.
Since i'm sane, these should correspond to the op overloads, `alias this` and `++`.
After these fundamental functions, there are several optional functions, same idea as `popback`:

* give, `+=`; which takes input ***async*** from the machine getting poked; maybe it should only affect the machine after future pokes?

* ishalt; the machine halted for some reason, should be true if get will produce nonsense; 
  shouldn't be defined if the machine is expected to always be sane; use when empty would have been correct for ranges?

* iserror; the machine is in some sort of error state that wants outside intervention, maybe the the window didnt resize?, 
  maybe the main charater is out of bounds? use when `nullable!T` would make sense?

* isstable; the machine is in a stable state; either `mach.get == mach++.get`, or it's in a meaningful point in a cycle, foreach a 3n+1 machine would be stable if i==1; 
  it can become unstable if input is given (or you reach in and affect metadata) but without outside influence, poking would just waste cpu time.

* isdone
  
* pull, `--`; go back in time one poke; `mach.get == mach++--.get;` — undo functions.

* foresight, `[n]`; given n pokes the thoerical state the machine is in; assuming no input