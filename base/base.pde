import oscP5.*;
import netP5.*;

class Sleep{
  final int N_CHANNELS = 4;
  final int PORT = 5000;
  final float threshold = 0.4;
  float startTime = 0.0;
  float endTime = 0.0;
  float sleepTime_th = 10000.0;
  boolean sleeping_tmp = false;
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
    if(sleeping_tmp){
      for (int ch = 0;ch < N_CHANNELS; ch++){
        if(buffer[ch] > threshold){
          sleeping_tmp = true;
          break;
        }else{
          sleeping_tmp = false;
          endTime = millis();
        }
      }
    }else{
      for (int ch = 0;ch < N_CHANNELS; ch++){
        if(buffer[ch] > threshold){
          sleeping_tmp = true;
          startTime = millis();
          break;
        }else{
          sleeping_tmp = false;
        }
      }
    }
    
    if(endTime-startTime > sleepTime_th){
      sleeping = true;
    }else{
      sleeping = false;
    }
  }
}
