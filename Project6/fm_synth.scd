s.waitForBoot{
    n = NetAddr.new("127.0.0.1", 57120);    // create the NetAddr
    OSCFunc.trace(false);

    SynthDef(\tone, {
        arg p1 = 4000, p2 = 14000, p3 = 12000, p4 = 12000;
        var car, mod, carHz, modHz, noiseHz, widthHz;
        carHz = LinExp.kr(p1, 4000, 32767, 20, 500);
        modHz = LinExp.kr(p2, 14000, 32767, 20, 20000);
        noiseHz = LFNoise0.kr(LinLin.kr(p3, 12000, 32767, 50, 10000)).range(0, 1);
        widthHz = LinLin.kr(p4, 12000, 32767, 0, 1);
        mod = SinOsc.ar(modHz, mul:noiseHz);
        car = LFSaw.ar(carHz + mod, mul:0.2);
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
    });
    if (msg[2].asFloat > 3000, {
        x.set(\p2, msg[2].asFloat);
    });
    if (msg[3].asFloat > 3000, {
        x.set(\p3, msg[3].asFloat);
    });
    }, '/frequency');
    );
}