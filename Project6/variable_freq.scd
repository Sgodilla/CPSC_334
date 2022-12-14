s.waitForBoot {
    var freq;
    n = NetAddr.new("127.0.0.1", 57120);    // create the NetAddr
    OSCFunc.trace(false);
    (
    OSCDef.new(\freq, {
    arg msg, time, addr, port;
    msg[1].asFloat.postln;
    }, "/frequency");
    )
}