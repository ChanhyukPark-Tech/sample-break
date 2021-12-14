OscIn oin;
2580 => oin.port;
oin.addAddress("/chuckie/osctest");
OscMsg msg;
0 => int count;
time timer[100];
float inputs[100];

Rhodey piano => dac;



       


while (true) {
    oin => now;
    while (oin.recv(msg) != 0) {
        msg.getFloat(0) => float note;
        msg.getFloat(1) => float length;
        <<< note >>>;
        
            note => piano.freq;
           
            1 => piano.noteOn;
            length::second => now;
           
            1 => piano.noteOff;
        
        
    }
}