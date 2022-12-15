s.waitForBoot{
    n = NetAddr.new("127.0.0.1", 57120);    // create the NetAddr
    OSCFunc.trace(false);

    SynthDef(\tone, {
        arg p1 = 14000, p2 = 14000, p3 = 14000, p4 = 14000;
        var car, mod, carHz, modHz, modAmp;
        carHz = LinExp.kr(p1, 4000, 32767, 50, 500);
        modHz = LinLin.kr(p2, 4000, 32767, 50, 2000);
        modAmp = LFNoise0.kr(LinLin.kr(p3, 4000, 32767, 0, 1000)).range(5, 500);
        mod = SinOsc.ar(modHz, mul:modAmp)
        car = SinOsc.ar(carHz + mod);
        Out.ar(0, car);
        Out.ar(1, car);
    }).add;
    s.sync;

    x = Synth(\tone);
    s.sync;

    (
    OSCdef.new(\play, {
    arg msg, time, addr, port;
    msg.postln;
    if (msg[1].asFloat > 3000, {
        x.set(\p1, msg[1].asFloat);
    })
    if (msg[2].asFloat > 3000, {
        x.set(\p2, msg[2].asFloat);
    })
    if (msg[3].asFloat > 3000, {
        x.set(\p3, msg[3].asFloat);
    })
    }, '/frequency');
    );
}