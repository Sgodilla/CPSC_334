s.waitForBoot {
    n = NetAddr.new("127.0.0.1", 57120);    // create the NetAddr
    OSCFunc.trace(false);

    SynthDef(\tone, {
        arg freq = 14000;
        var sig, frequency;
        frequency = LinExp.kr(freq, 4000, 32767, 50, 500);
        sig = SinOsc.ar(frequency, 0, 0.2);
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
        msg.postln;
        x.set(\freq, msg[1].asFloat);
    }, {
        x.set(\freq, 16000);
    })
    }, '/frequency');
    );
}