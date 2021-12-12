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


int start[3];
int end[3];
<<< start[0] , start[1],start[2]>>>;

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
    //0.96 => oneMoreTime.rate;
    end - start => int len;
    len::samp => now;
    oneMoreTime.samples() => oneMoreTime.pos;
}
        
fun void playInstrument(SndBuf instrument)
{
    0 => instrument.pos;
    0.1::second => now;
}

//fun void playLoop(){
    

while (true) {
    
    hid => now;
    while (hid.recv(msg)) {
        if (msg.isButtonDown()) {  
            <<< msg.ascii >>>;  
            if(msg.ascii == 65){ 
                <<< oneMoreTime.pos() >>>;
                oneMoreTime.pos() => start[startPos];
                1 +=> startPos;         
            }
            else if (msg.ascii == 10){
                <<< oneMoreTime.pos() >>>;
                oneMoreTime.pos() => end[endPos];
                1 +=> endPos;                
            }
            else if (msg.ascii == 90)
            {
                spork~playRecord(start[0], end[0]);
            }
            else if (msg.ascii == 88)
            {
                spork~playRecord(start[1], end[1]);
            }
            
            else if (msg.ascii == 67)
            {
                spork~playRecord(start[2], end[2]);
            }
            else if (msg.ascii == 76)
            {
                playInstrument(hihat);
            }
            else if (msg.ascii == 77)
            {
                playInstrument(kick);
            }
            //else if (msg.ascii == 86)
            //{
            //    playLoop();
            //}
            
        }
        
    }               
    
}