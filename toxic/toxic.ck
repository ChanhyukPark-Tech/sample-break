
Hid hid;
HidMsg msg;
1 => int device;
if(!hid.openKeyboard(device)){
    <<< "Can't open this device!!", "Sorry.">>>;
    me.exit();
}

SndBuf kick => dac; 
SndBuf hihat => dac;
SndBuf kick2 => dac;
me.dir() + "../kick.wav" => kick.read;
me.dir() + "../kick_01.wav" => kick2.read;
me.dir() + "../hihat_02.wav" => hihat.read;



181400 => int start1;
201600 => int finish1;
263000 => int start2;
319000 => int finish2;
1134000 => int start3;
1177500 => int finish3;

SndBuf toxic => dac;
SndBuf toxicVocal => dac;

int samples[][];

kick.samples() => kick.pos;
hihat.samples() => hihat.pos;
1.0 => kick.gain;

me.dir() + "/tere.wav" => toxic.read;
me.dir() + "/toxicVocal.wav" => toxicVocal.read;


toxicVocal.samples() => toxicVocal.pos;


0 => toxic.pos;
fun void playRecord(int start, int end){
    start => toxic.pos;
    1.1 => toxic.rate;
    end - start => int len;
    len::samp - 5000::samp => now;
    toxic.samples() => toxic.pos;
}

fun void playRecordHalf(int start,int end){
    start => toxic.pos;
    1.1 => toxic.rate;
    (end - start) / (2) + 500  => int len;
    len::samp - 5000::samp => now;
    toxic.samples() => toxic.pos;
}

fun void playReverse2(int start, int end) {
    end + 500 => toxic.pos;
    -1.0 => toxic.rate;
    (end - start) / (2) + 500 => int len;
    len::samp - 5000::samp => now;
    0 => toxic.pos;
}

fun void playRecordHalfReverse(int start,int end){
    
    //-0.90 => toxic.rate;
    1.1=> toxic.rate;
    end => toxic.pos;
    (end - start) / 2  => int len;
    len::samp - 5000::samp => now;
    toxic.samples() => toxic.pos;
}

fun void playDrum(SndBuf drum){
    while(true){
        0 => drum.pos;
        0.4::second => now;
        0 => drum.pos;
        0.2::second => now;
        0 => drum.pos;
        0.6::second => now;
        0 => drum.pos;
        0.4::second => now;
        drum.samples() => drum.pos;
        0.065::second => now;
    }
}

fun void playDrum2(SndBuf kick){
    while(true){
        0 => kick.pos;
        0.4::second => now;
        kick.samples() => kick.pos;
        0.2::second => now;
        0 => kick.pos;
        0.6::second => now;
        kick.samples() => kick.pos;
        0.465::second => now;
    }
}

fun void playHihat(SndBuf hihat){
    0 => hihat.pos;
    0.2::second => now;
}
 
// dfg as dfg as 
0.98 => toxic.rate;
while (true) {
    hid => now;
    while (hid.recv(msg)) {
        if (msg.isButtonDown()) {
            <<< msg.ascii >>>;
            if(msg.ascii == 87){
                <<<toxic.pos()>>>;
            }
            
            if(msg.ascii == 49){
                <<< toxic.pos() >>>;
                toxic.pos() => start1;
            }else if (msg.ascii == 50){
                toxic.pos() => finish1;
            }else if (msg.ascii == 51){
                toxic.pos() => start2;
            }else if (msg.ascii == 52){
                toxic.pos() => finish2;
            }else if (msg.ascii == 53){
                toxic.pos() => start3;
            }else if (msg.ascii == 54){
                toxic.pos() => finish3;
            }
            0.98 => toxic.rate;
            if(msg.ascii == 65){
                <<< "This is first sample ! " >>>;
                playRecord(start1,finish1);
            }
            
            if(msg.ascii == 83){
                                <<< "This is second sample ! " >>>;
                playRecord(start2,finish2);
            }
            
            //1147994 1185000
            if(msg.ascii == 68){
                                <<< "This is third sample first half ! " >>>;
            0.90 => toxic.rate;
                <<< start3 >>>;
                <<< "sample3", finish3,start3 >>>;
                playRecordHalf(start3,finish3);
                
            }
            if(msg.ascii == 70){
                                <<< "This is third sample second half reverse ! " >>>;

                //playRecordHalfReverse(start3,finish3);
                playReverse2(start3,finish3);
                
            }if(msg.ascii == 71){
                                <<< "This is third sdample second half  ! " >>>;
            1.0 => toxic.rate;
                ((start3 + finish3) / 2 ) - 500  => toxic.pos;
                (finish3 - start3 - 3000)::samp / 2  => now;
                toxic.samples() => toxic.pos;
         
            }
            if(msg.ascii == 48 ){
                0 => toxicVocal.pos;
            }
            if (msg.ascii == 76) {
                spork~playDrum(kick);
            }
            if (msg.ascii == 77) {
                spork~playDrum2(kick2);
            }
        }
            

    }               
}