s.waitForBoot {
    n = NetAddr.new("127.0.0.1", 57120);    // create the NetAddr
    OSCFunc.trace(false);

    (
    SynthDef.new(\tone, {
        arg freq = 440;
        var sig, env;
        env = Line.kr(1, 0, 1, doneAction:2);
        sig = SinOsc.ar(freq, 0, 0.2) * env;
        Out.ar(0, sig);
    }).add;
    );

    Synth.new(\tone, [\freq, 440]);

    (
    OSCdef.new(\play, {
    arg msg, time, addr, port;
    if (msg[1].asFloat > 3000, {
        msg[1].asFloat.postln;
        Synth.new(\tone, [\freq, msg[1]]);
    });
    }, '/frequency');
    );
}