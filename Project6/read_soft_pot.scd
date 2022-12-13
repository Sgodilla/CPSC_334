s.waitForBoot {
    NetAddr.localAddr;    // retrieve the current IP and port
    n = NetAddr.new("127.0.0.1", 57120);    // create the NetAddr
    //OSCFunc.trace(true);
    // this example is basically like OSCFunc.trace but filters out
    // /status.reply messages
    f = { |msg, time, addr|
        if(msg[0] != '/status.reply') {
            "message: %\n".postf(time, addr, msg);
        }
    };
    thisProcess.addOSCRecvFunc(f);
}