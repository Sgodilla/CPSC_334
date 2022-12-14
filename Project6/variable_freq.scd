s.waitForBoot {
    var freq;
    n = NetAddr.new("127.0.0.1", 57120);    // create the NetAddr
    OSCFunc.trace(false);
    OSCFunc({ | args |
     freq = LinLin.ar(args[1].asFloat, -10, 32767, -500, 4186);
}, '/frequency');
    freq.postln;
}