s.waitForBoot {
    var freq;
    n = NetAddr.new("127.0.0.1", 57120);    // create the NetAddr
    OSCFunc.trace(false);
    (
    OSCdef.new(\freq, {
    arg msg, time, addr, port;
    if (msg[1].asFloat > 3000) {
        msg[1].asFloat.postln;
    }
    }, "/frequency");
    )
}