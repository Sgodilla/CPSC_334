s.waitForBoot {
    NetAddr.localAddr;    // retrieve the current IP and port
    n = NetAddr.new("127.0.0.1", 57120);    // create the NetAddr
    //OSCFunc.trace(true);
    // this example is basically like OSCFunc.trace but filters out
    // /status.reply messages
    OSCdef(\tester,
        {|msg, time, addr, recvPort|

        post('Revceived message to path: ');
        msg[0].postln;

        post('With value: ');
        msg[1].postln;

        },'/tester', n);
}