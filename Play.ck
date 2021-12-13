public class Play{
    fun void playRecord(SndBuf instrument, int start, int end){ 
        start => instrument.pos;
        // 0.97 => instrument.rate;       
        end - start => int len;        
        len::samp - 5000::samp => now;        
        instrument.samples() => instrument.pos;        
    }
    
    fun void playHihat(SndBuf instrument)   
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
     
    fun void playSequence(SndBuf instrument, int start[] , int end[]){       
        playRecord(instrument,start[0] ,end[0]);
        
        while(true){           
            playRecord(instrument,start[1],end[1]);          
            playRecord(instrument,start[1],end[1]);             
            playRecord(instrument,start[1],end[1]);
            playRecord(instrument,start[0],end[0]);
            
            if(Math.random2(1,4) == 2){ 
                playRecord(instrument,start[2],end[2]);                
                playRecord(instrument,start[2],end[2]);                
                playRecord(instrument,start[2],end[2]);               
                playRecord(instrument,start[2],end[2]);                 
            }             
        }        
    }
    
    
    fun void playPiano(){
      Rhodey piano => dac;
      
      Std.mtof(66) => piano.freq;
       1 => piano.noteOn;
        
      0.4::second => now;
        1 => piano.noteOff;
        
        Std.mtof(64) => piano.freq;
       1 => piano.noteOn;
        
      0.4::second => now;
        1 => piano.noteOff;
        
        Std.mtof(62) => piano.freq;
       1 => piano.noteOn;
        
      0.2::second => now;
        1 => piano.noteOff;
        
        Std.mtof(59) => piano.freq;
       1 => piano.noteOn;
        
      0.4::second => now;
        1 => piano.noteOff;
        
    }
}