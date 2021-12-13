
Hid hid;
HidMsg msg;
0 => int device;
if(!hid.openKeyboard(device)){
    <<< "Can't open this device!!", "Sorry.">>>;
    me.exit();
}
181400 => int start1;
201600 => int finish1;
263000 => int start2;
319000 => int finish2;
1134000 => int start3;
1177500 => int finish3;

SndBuf toxic => dac;

int samples[][];



me.dir() + "/tere.wav" => toxic.read;


0 => toxic.pos;
fun void playRecord(int start, int end){
    start => toxic.pos;
    end - start => int len;
    len::samp - 5000::samp => now;
    toxic.samples() => toxic.pos;
}

fun void playRecordHalf(int start,int end){
    start => toxic.pos;
    (end - start) / 2  => int len;
    len::samp - 2500::samp => now;
    toxic.samples() => toxic.pos;
}

fun void playRecordHalfReverse(int start,int end){
    -0.90 => toxic.rate;
    end => toxic.pos;
    (end - start) / 2  => int len;
    len::samp - 2500::samp => now;
    toxic.samples() => toxic.pos;
}
        
// dfg as dfg as 
0.98 => toxic.rate;
while (true) {
    hid => now;
    while (hid.recv(msg)) {
        if (msg.isButtonDown()) {
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

                playRecordHalfReverse(start3,finish3);
                
            }if(msg.ascii == 71){
                                <<< "This is third sample second half  ! " >>>;
            0.90 => toxic.rate;
                ((start3 + finish3) / 2 ) - 500  => toxic.pos;
                (finish3 - start3)::samp / 2  => now;
                toxic.samples() => toxic.pos;
            }
        }
            

    }               
}