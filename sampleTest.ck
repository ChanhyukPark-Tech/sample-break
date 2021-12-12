SndBuf oneMoreTime => dac;
SndBuf hihat => dac;
SndBuf kick => dac;

Hid hid;
HidMsg msg;
0 => int device;

if(!hid.openKeyboard(device)){
    <<< "Can't open this device!!", "Sorry.">>>;
    me.exit();
}



<<< me.dir() >>>;
me.dir() + "/oneMoreTime.wav" => oneMoreTime.read;
me.dir() + "/hihat_02.wav" => hihat.read;
me.dir() + "/kick.wav" => kick.read;

kick.samples() => kick.pos;
hihat.samples() => hihat.pos;
0 => oneMoreTime.pos;
0.5 => hihat.gain;
1.5 => kick.gain;

<<< oneMoreTime.samples() >>>;


// z x c => scale z x c x x x z x x x z x x x z c c c c c c c c z
oneMoreTime.rate(0.25); 
while (true) {
    
    hid => now;
    while (hid.recv(msg)) {
        if (msg.isButtonDown()) {  
            <<< msg.ascii >>>;  
            if(msg.ascii == 65){ 
                <<< oneMoreTime.pos() >>>;
                oneMoreTime.pos() => oneMoreTime.pos;
            }else if(msg.ascii == 46 || msg.ascii == 76){
                oneMoreTime.pos() + 10000 => oneMoreTime.pos;
                                <<< oneMoreTime.pos() >>>;

            }else if(msg.ascii == 44 || msg.ascii == 75){
                oneMoreTime.pos() - 10000 => oneMoreTime.pos;
                                <<< oneMoreTime.pos() >>>;

                }
         
        }
        
    }               
    
}