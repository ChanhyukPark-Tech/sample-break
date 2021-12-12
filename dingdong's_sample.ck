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


[292432,401379,489300] @=> int start[];
[340000,446500,513700] @=> int end[];

0 => int startPos;
0 => int endPos;


<<< me.dir() >>>;
me.dir() + "/oneMoreTime.wav" => oneMoreTime.read;
me.dir() + "/hihat_02.wav" => hihat.read;
me.dir() + "/kick.wav" => kick.read;

kick.samples() => kick.pos;
hihat.samples() => hihat.pos;
0 => oneMoreTime.pos;
0.5 => hihat.gain;
1.5 => kick.gain;

fun void playRecord(int start, int end){
    start => oneMoreTime.pos;
   // 0.97 => oneMoreTime.rate;
    end - start => int len;
    len::samp - 5000::samp => now;
    oneMoreTime.samples() => oneMoreTime.pos;
}
        
fun void playInstrument(SndBuf instrument)
{
    while (true){
        0 => instrument.pos;
        0.23::second => now;
        0 => instrument.pos;
        0.13::second => now;
        0 => instrument.pos;
        0.13::second => now;
        
    }
}

fun void playDrum(SndBuf drum){
    0 => drum.pos;
    0.2::second => now;
}


fun void playSequence(int start[] , int end[]){
    playRecord(start[0] ,end[0]);
    while(true){
                playRecord(start[1],end[1]);
                playRecord(start[1],end[1]);

                playRecord(start[1],end[1]);

                playRecord(start[0],end[0]);
        
                if(Math.random2(1,4) == 2){
                    playRecord(start[2],end[2]);
                    playRecord(start[2],end[2]);
                    playRecord(start[2],end[2]);
                    playRecord(start[2],end[2]);

                }

    }
}

//fun void playLoop(){
    

// z x c => scale z x c x x x z x x x z x x x z c c c c c c c  z

while (true) {
    
    hid => now;
    while (hid.recv(msg)) {
        if (msg.isButtonDown()) {  
            if(msg.ascii == 65){ 
                <<< "sample",startPos+1," startPos : ", oneMoreTime.pos() >>>;
               // oneMoreTime.pos() => start[startPos];
                1 +=> startPos;         
            }
            else if (msg.ascii == 10){
                <<< "sample",endPos+1," endPos : ", oneMoreTime.pos() >>>;
              //  oneMoreTime.pos() => end[endPos];
                1 +=> endPos;                
            }
            
            // 6s ~ 7s , 7.8s ~ 9.0s , 10s ~ 10.7s  
            else if (msg.ascii == 90)
            {
                <<< "This is first sample ! " >>>;
                playRecord(start[0], end[0]);
            }
            else if (msg.ascii == 88)
            {
               <<< "This is second sample ! " >>>;
                playRecord(start[1], end[1]);
            }
            
            else if (msg.ascii == 67)
            {
                <<< "This is third sample ! " >>>;
                playRecord(start[2], end[2]);
            }
            else if(msg.ascii == 48)
            {
               spork ~ playSequence(start,end);
            }
            
            else if (msg.ascii == 76)
            {
                spork~playInstrument(hihat);
            }
            else if (msg.ascii == 77)
            {
                spork~playDrum(kick);
            }
            //else if (msg.ascii == 86)
            //{
            //    playLoop();
            //}
            
        }
        
    }               
    
}