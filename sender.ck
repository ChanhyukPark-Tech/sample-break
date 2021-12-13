OscOut oout;
2580 => int port;
oout.dest("192.168.0.25", port);
Hid hid;
HidMsg msg;
1 => int device;

if(!hid.openKeyboard(device)){
    <<< "Can't open this device!!", "Sorry.">>>;
    me.exit();
}


while (true) {
    hid => now;
    while (hid.recv(msg)) {
        if (msg.isButtonDown()) {
            <<< msg.ascii>>>;
         oout.start("/chuckie/osctest");    
            
         if(msg.ascii == 65){
                  Std.mtof(66) => oout.add;
                  0.4 => oout.add;
         }else if(msg.ascii == 83){
             Std.mtof(64) => oout.add;
             0.4 => oout.add;
         }else if(msg.ascii == 68){
             Std.mtof(62) => oout.add;
             0.2 => oout.add;
         }else if(msg.ascii == 70){
             Std.mtof(59) => oout.add;
             0.4 => oout.add;
         }
      oout.send();
        }
    }               
}   