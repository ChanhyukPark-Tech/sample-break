
Hid hid;
HidMsg msg;
0 => int device;
if(!hid.openKeyboard(device)){
    <<< "Can't open this device!!", "Sorry.">>>;
    me.exit();
}
0 => int start1;
0 => int finish1;
0 => int start2;
0 => int finish2;
0 => int start3;
0 => int finish3;

SndBuf toxic => dac;

int samples[][];



me.dir() + "/tere.wav" => toxic.read;


0 => toxic.pos;


while (true) {
    hid => now;
    while (hid.recv(msg)) {
        if (msg.isButtonDown()) {
            <<< msg.ascii >>> ;
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
            1.0 => toxic.rate;
            if(msg.ascii == 65){
                <<< "sample1", finish1,start1 >>>;
                start1 => toxic.pos;
                (finish1 - start1)::samp => now;
                toxic.samples() => toxic.pos;
            }
            
            if(msg.ascii == 83){
                <<< "sample2", finish2,start2 >>>;
                start2 => toxic.pos;
                (finish2 - start2)::samp => now;
                toxic.samples() => toxic.pos;
            }
            
            //1147994 1185000
            if(msg.ascii == 68){
                <<< "sample3", finish3,start3 >>>;
                start3 => toxic.pos;
                (finish3 - start3)::samp / 2 => now;
                toxic.samples() => toxic.pos;
            }
            if(msg.ascii == 70){
                -1.0 => toxic.rate;
                finish3 => toxic.pos;
                (finish3 - start3)::samp / 2 => now;
                toxic.samples() => toxic.pos;
            }if(msg.ascii == 71){
                (start3 + finish3) / 2 - 10000  => toxic.pos;
                (finish3 - start3)::samp / 2 + 10000::samp => now;
                toxic.samples() => toxic.pos;
            }
        }
            

    }               
}