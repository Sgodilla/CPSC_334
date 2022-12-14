s.waitForBoot {
    {SinOsc.ar(LFNoise0.kr(10).range(500, 1500), mul: 0.1)}.play;
}