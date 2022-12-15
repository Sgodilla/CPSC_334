~a = Bus.control(s, 1);
~b = Bus.control(s, 1);
~c = Bus.control(s, 1);
~d = Bus.control(s, 1);

s.waitForBoot{
    n = NetAddr.new("127.0.0.1", 57120);    // create the NetAddr
    OSCFunc.trace(false);

    SynthDef(\tone, {
        var car, modHz, modAmp, pulse;
        modHz = LFTri.ar(b.kr, mul:c.kr);
        pulse = LFTri.ar(d.kr, mul:0.2);
        car = LFTri.ar(a.kr + modHz, mul:pulse);
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
        a.value = msg[1].asFloat.linexp(4000, 32767, 20, 500);
    });
    if (msg[2].asFloat > 3000, {
        b.value = msg[2].asFloat.linlin(14000, 32767, 0, 1000);
    });
    if (msg[3].asFloat > 3000, {
        c.value = msg[3].asFloat.linlin(12000, 32767, 25, 500);
    });
    if (msg[4].asFloat > 3000, {
        d.value = msg[4].asFloat.linexp(12000, 32767, 1, 500);
    });
    }, '/frequency');
    );
}