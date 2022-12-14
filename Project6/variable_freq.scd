s.waitForBoot {
    n = NetAddr.new("127.0.0.1", 57120);    // create the NetAddr
    OSCFunc.trace(false);
    (
    OSCdef.new(\print, {
    arg msg, time, addr, port;
    if (msg[1].asFloat > 3000) {
        msg[1].asFloat.postln;
    }
    }, "/frequency");
    )

    (
    SynthDef.new(\tone, {
        arg freq = 440, out = 0;
        var sig, env;
        env = Line.kr(1, 0, 0.125);
        sig = SinOsc.ar(freq, 0, 0.4) * env;
        Out.ar(out, sig);
    }).add;
    )

    (
    OSCdef.new(\play, {
    arg msg, time, addr, port;
    if (msg[1].asFloat > 3000) {
        Synth.new(\tone, [\freq, msg[1]]);
    }
    }, "/frequency");
    )
}