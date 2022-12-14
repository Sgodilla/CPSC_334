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
        f = LinExp.kr(msg[1].asFloat, 4000, 32767, 25, 4186);
        x.set(\freq, f);
    }, {
        x.set(\freq, 440);
    })
    }, '/frequency');
    );
}