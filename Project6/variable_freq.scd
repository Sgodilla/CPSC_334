s.waitForBoot {
    n = NetAddr.new("127.0.0.1", 57120);    // create the NetAddr
    OSCFunc.trace(false);

    SynthDef(\tone, {
        arg freq = 440;
        var sig;
        sig = SinOsc.ar(freq, 0, 0.2);
        Out.ar(0, sig);
        Out.ar(1, sig);
    }).add;
    s.sync;

    x = Synth(\tone);
    s.sync;

    (
    OSCdef.new(\play, {
    arg msg, time, addr, port;
    if (msg[1].asFloat > 3000, {
        msg[1].asFloat.postln;
        x.set(\freq, msg[1].asFloat);
    })
    }, '/frequency');
    );
}