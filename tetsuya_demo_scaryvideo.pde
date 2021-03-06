import oscP5.*;
import netP5.*;
 
final int N_CHANNELS = 4;
final float DISPLAY_SCALE = 200.0;
 
final color BG_COLOR = color(255, 255, 255);
 
final int PORT = 5000;
OscP5 oscP5 = new OscP5(this, PORT);
 
float[] buffer = new float[N_CHANNELS];

long t_start; // time elapsed since app started 
float t; // time elapsed since start sleeping
 
 
void setup(){
  size(1000, 600);
  frameRate(30);
  PFont font = createFont("MS Gothic",48,true);
  textFont(font); 
  textSize(50);
  fill(0,0,0);
  textAlign(CENTER);
  t_start = millis();
}

void draw(){
  IsSleeping();
  background(BG_COLOR);
  if(sleeping){
    text("sleeping",150,300);
   }else{
     text("awaking",150,300);
   }
   for (int ch = 0;ch < N_CHANNELS; ch++){
    textSize(50);
    text(ch,50+ch*200,50);
    text(buffer[ch],100+ch*200,100);
    println(ch+"----"+buffer[ch]);
  }
  if (sleeping){
    t = (millis() - t_start)/1000;
    text("sleeping time:"+t ,400,300);
    if ( t = 10 ){
      background(0);
      delay(2500);
      link("https://www.youtube.com/watch?v=-o-eyRMVOaw");
      t = 0;
    }
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
final float threshold = 0.2;
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
