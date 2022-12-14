s.boot;
s.waitForBoot {
    n = NetAddr.new("127.0.0.1", 57120);    // create the NetAddr
    OSCFunc.trace(false);

    SynthDef(\test, {Out.ar(0, SinOsc.ar(770, 0, 0.1))}).add;
    s.sync;

    x = Synth(\test);
    s.sync;

    (
    OSCdef.new(\play, {
    arg msg, time, addr, port;
    if (msg[1].asFloat > 3000) {
        msg[1].asFloat.postln;
        //Synth.new(\tone, [\freq, msg[1]]);
    }
    }, '/frequency');
    );
}