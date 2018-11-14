import oscP5.*;
import netP5.*;

class Sleep{
  final int N_CHANNELS = 4;
  final int PORT = 5000;
  final float threshold = 0.14;
  boolean sleeping = false;
  OscP5 oscP5 = new OscP5(this, PORT);
  float[] buffer = new float[N_CHANNELS];
  
  void oscEvent(OscMessage msg){
    float data;
    if(msg.checkAddrPattern("/muse/elements/alpha_relative")){
      for(int ch = 0; ch < N_CHANNELS; ch++){
        data = msg.get(ch).floatValue();
        buffer[ch] = data;
      }
    }
  }
  
  void IsSleeping(){
    for (int ch = 0;ch < N_CHANNELS; ch++){
      if(buffer[ch] > threshold){
        sleeping = true;
        break;
      }else{
        sleeping = false;
      }
    }
  }
}
