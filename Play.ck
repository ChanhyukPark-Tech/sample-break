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
    
    [66,64,62] @=> int melody1[];
    [62,61,59,59] @=> int melody2[];
    [59,57,55] @=> int melody3[];
    
    fun void playPiano(){
      Rhodey piano[3] => dac;
      
      for (0 => int i; i < 3; i++)
      {
          1 => piano[0].noteOn;
          1 => piano[1].noteOn;
          1 => piano[2].noteOn;
          Std.mtof(melody1[i]) => piano[0].freq;
          Std.mtof(melody2[i]) => piano[1].freq;
          Std.mtof(melody3[i]) => piano[2].freq;
          if (i == 2)
              0.2::second => now;
          else
              0.4::second => now;
          1 => piano[0].noteOff;
          1 => piano[1].noteOff;
          1 => piano[2].noteOff;
      }
      1 => piano[0].noteOn;
      Std.mtof(melody2[3]) => piano[0].freq;
      0.4::second => now;
      1 => piano[0].noteOff;  
    }
}