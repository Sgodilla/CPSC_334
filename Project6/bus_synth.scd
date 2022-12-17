s.waitForBoot{
    n = NetAddr.new("127.0.0.1", 57120);    // create the NetAddr
    OSCFunc.trace(false);
    ~a = Bus.control(s, 1); a.set(20);
    ~b = Bus.control(s, 1); b.set(0);
    ~c = Bus.control(s, 1); c.set(25);
    ~d = Bus.control(s, 1); d.set(1);

    SynthDef(\tone, {
        arg p1 = 20, p2 = 0, p3 = 25, p4 = 1;
        var car, modHz, pulse;
        modHz = LFTri.ar(p2, mul:p3);
        pulse = LFTri.ar(p4, mul:0.2);
        car = LFTri.ar(p1 + modHz, mul:pulse);
        Out.ar(0, car);
        Out.ar(1, car);
    }).add;
    s.sync;

    x = Synth(\tone);
    x.map(\p1, a.index, \p2, b.index, \p3, c.index, \p4, d.index);
    s.sync;

    (
    OSCdef.new(\play, {
    arg msg, time, addr, port;
    msg.postln;
    if (msg[1].asFloat > 3000, {
        a.set(msg[1].asFloat.linexp(4000, 32767, 20, 500));
    });
    if (msg[2].asFloat > 3000, {
        b.set(msg[2].asFloat.linlin(14000, 32767, 0, 1000));
    });
    if (msg[3].asFloat > 3000, {
        c.set(msg[3].asFloat.linlin(12000, 32767, 25, 500));
    });
    if (msg[4].asFloat > 3000, {
        d.set(msg[4].asFloat.linexp(12000, 32767, 1, 500));
    });
    }, '/frequency');
    );
}