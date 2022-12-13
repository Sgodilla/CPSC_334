s.waitForBoot {
    NetAddr.localAddr;    // retrieve the current IP and port
    n = NetAddr.new("127.0.0.1", 57120);    // create the NetAddr
    OSCFunc.trace(false);
    // this example is basically like OSCFunc.trace but filters out
    // /status.reply messages
    o = OSCFunc({ arg msg, time, addr, recvPort; [msg, time, addr, recvPort].postln; }, '/tester'); // create the OSCFunc
    o.free;    // remove the OSCFunc when you are done.
}