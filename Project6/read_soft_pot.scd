s.waitForBoot {
    NetAddr.localAddr;    // retrieve the current IP and port
    n = NetAddr.new("127.0.0.1", 57120);    // create the NetAddr
    OSCFunc.trace(true);
}