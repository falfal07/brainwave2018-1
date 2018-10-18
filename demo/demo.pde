import oscP5.*;
import netP5.*;

final int N_CHANNELS = 4;
final float DISPLAY_SCALE = 200.0;

final color BG_COLOR = color(255, 255, 255);

final int PORT = 5000;
OscP5 oscP5 = new OscP5(this, PORT);

float[] buffer = new float[N_CHANNELS];


void setup(){
  size(1000, 600);
  frameRate(30);
  PFont font = createFont("MS Gothic",48,true);
  textFont(font); 
  textSize(100);
  fill(0,0,0);
  textAlign(CENTER);
}

void draw(){
  background(BG_COLOR);
  if(sleeping){
    text("sleeping",500,300);
  }else{
    text("awaking",500,300);
  }
  for (int ch = 0;ch < N_CHANNELS; ch++){
    textSize(50);
    text(ch,50+ch*200,50);
    text(buffer[ch],100+ch*200,100);
  }
}

void oscEvent(OscMessage msg){
  float data;
  if(msg.checkAddrPattern("/muse/elements/alpha_relative")){
    for(int ch = 0; ch < N_CHANNELS; ch++){
      data = msg.get(ch).floatValue();
      buffer[ch] = data;
    }
  }
}

//added below

boolean sleeping = false;
final float threshold = 0.1;


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
