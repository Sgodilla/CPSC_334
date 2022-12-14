var freq;
s.waitForBoot {
    NetAddr.localAddr.postln;    // retrieve the current IP and port
    n = NetAddr.new("127.0.0.1", 57120);    // create the NetAddr
    OSCFunc.trace(false);
    OSCFunc({ | args |
	 "Freq Val: ':".post;
     freq = args[1].asFloat.postln;
     freq.postln;
}, '/frequency');
}