SndBuf oneMoreTime => dac;
SndBuf hihat => dac;
SndBuf kick => dac;

<<< me.dir() >>>;
me.dir() + "/oneMoreTime.wav" => oneMoreTime.read;
me.dir() + "/hihat_02.wav" => hihat.read;
me.dir() + "/kick.wav" => kick.read;

Hid hid;
HidMsg msg;
0 => int device;

if(!hid.openKeyboard(device)){
    <<< "Can't open this device!!", "Sorry.">>>;
    me.exit();
}

[0,0,0] @=> int start[];
[0,0,0] @=> int end[];
0 => int startPos;
0 => int endPos;

kick.samples() => kick.pos;
hihat.samples() => hihat.pos;
0 => oneMoreTime.pos;

0.5 => hihat.gain;
1.5 => kick.gain;

Play p;

while (true) {
    
    hid => now;
    while (hid.recv(msg)) {
        if (msg.isButtonDown()) {  
            <<< msg.ascii >>>;
            if(msg.ascii == 65){ 
                <<< "sample",startPos+1," startPos : ", oneMoreTime.pos() >>>;
               oneMoreTime.pos() => start[startPos];
                1 +=> startPos;         
            }
            else if (msg.ascii == 10){
                <<< "sample",endPos+1," endPos : ", oneMoreTime.pos() >>>;
                oneMoreTime.pos() => end[endPos];
                1 +=> endPos;                
            }
            else if (msg.ascii == 90)
            {
                <<< "This is first sample ! " >>>;
                p.playRecord(oneMoreTime,start[0], end[0]);
            }
            else if (msg.ascii == 88)
            {
               <<< "This is second sample ! " >>>;
                p.playRecord(oneMoreTime,start[1], end[1]);
            }
            
            else if (msg.ascii == 67)
            {
                <<< "This is third sample ! " >>>;
                p.playRecord(oneMoreTime,start[2], end[2]);
            }
            else if(msg.ascii == 48)
            {
               spork~p.playSequence(oneMoreTime,start,end);
            }
            
            else if (msg.ascii == 76)
            {
                spork~p.playHihat(hihat);
            }
            else if (msg.ascii == 77)
            {
                spork~p.playDrum(kick);
            }
            else if (msg.ascii == 49)
            {
                spork~p.playPiano();
            }
            
        }
        
    }               
    
}