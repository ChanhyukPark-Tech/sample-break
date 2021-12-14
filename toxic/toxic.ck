Hid hid;
HidMsg msg;
0 => int device;
if(!hid.openKeyboard(device)){
    <<< "Can't open this device!!", "Sorry.">>>;
    me.exit();
}

SndBuf drum => dac; 
SndBuf hihat => dac;
SndBuf kick => dac;
SndBuf toxic => dac;
SndBuf toxicVocal => dac;

me.dir() + "/kick.wav" => drum.read;
me.dir() + "/kick_01.wav" => kick.read;
me.dir() + "/hihat_02.wav" => hihat.read;
me.dir() + "/tere.wav" => toxic.read;
me.dir() + "/toxicVocal.wav" => toxicVocal.read;

0 => int start1;
0 => int finish1;
0 => int start2;
0 => int finish2;
0 => int start3;
0 => int finish3;

drum.samples() => drum.pos;
kick.samples() => kick.pos;
hihat.samples() => hihat.pos;
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

fun void playReverse(int start, int end) {
    end + 500 => toxic.pos;
    -1.0 => toxic.rate;
    (end - start) / (2) + 500 => int len;
    len::samp - 5000::samp => now;
    0 => toxic.pos;
}

fun void playReverse2(int start, int end){
    1.0 => toxic.rate;
    ((start + end) / 2 ) - 500  => toxic.pos;
    (end - start - 3000)::samp / 2  => now;
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
        0.07::second => now;
    }
}

fun void playKick(SndBuf kick){
    while(true){
        0 => kick.pos;
        0.4::second => now;
        kick.samples() => kick.pos;
        0.2::second => now;
        0 => kick.pos;
        0.6::second => now;
        kick.samples() => kick.pos;
        0.47::second => now;
    }
}

fun void playHihat(SndBuf hihat){
    0 => hihat.pos;
    0.2::second => now;
}
 
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
                <<< "get first sampling" >>>;
            }else if (msg.ascii == 50){
                toxic.pos() => finish1;
                <<< "finished first sampling" >>>;
            }else if (msg.ascii == 51){
                toxic.pos() => start2;
                <<< "get second sampling" >>>;
            }else if (msg.ascii == 52){
                toxic.pos() => finish2;
                <<< "finished second sampling" >>>;
            }else if (msg.ascii == 53){
                toxic.pos() => start3;
                <<< "get third sampling" >>>;
            }else if (msg.ascii == 54){
                toxic.pos() => finish3;
                <<< "finished third sampling" >>>;
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
            
            if(msg.ascii == 68){
                <<< "This is third sample first half ! " >>>;
                0.90 => toxic.rate;
                <<< start3 >>>;
                <<< "sample3", finish3,start3 >>>;
                playRecordHalf(start3,finish3);
                
            }
            if(msg.ascii == 70){
                <<< "This is third sample second half reverse ! " >>>;
                playReverse(start3,finish3);
                
              }if(msg.ascii == 71){
                <<< "This is third sdample second half  ! " >>>;
                playReverse2(start3, finish3);
            }
            if(msg.ascii == 48 ){
                0 => toxicVocal.pos;
                <<< "play the vocal" >>>;
            }
            //l
            if (msg.ascii == 76) {
                spork~playDrum(drum);
                <<< "play the drum beat" >>>;
            }
            //m
            if (msg.ascii == 77) {
                spork~playKick(kick);
                <<< "play the kick beat" >>>;
            }
        }
            

    }               
}