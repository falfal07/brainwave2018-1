import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import oscP5.*; 
import netP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class tetsuya_UI extends PApplet {

 //minim library needed 

Sleep sleep = new Sleep();

Minim minim;       
AudioPlayer gameover; 
AudioPlayer alarm;

int t_start = millis()/1000; // time elapsed since app started 
int t; // time elapsed since start sleeping
int sleepCounter; // how many times have slept
 
 
public void setup(){
  
  background(240);
  frameRate(30); 
  fill(0); 
  textSize(70);
  text("ALL NIGHTER BOOSTER", 330, 100);
  minim = new Minim(this); 
  gameover = minim.loadFile("gameover.mp3"); // load mp3 file in data folder  
  alarm = minim.loadFile("alarm.mp3");
}

 public void draw(){
   sleep.IsSleeping();
   if(sleep.sleeping){
      text("sleeping",150,400);
    } else {
      text("awake",150,400);
    }
    for (int ch = 0;ch < sleep.N_CHANNELS; ch++){
      textSize(50);
      text(ch,50+ch*200,200);
      text(sleep.buffer[ch],100+ch*200,250);
      println(ch+"----"+sleep.buffer[ch]);
   }
    if (sleep.sleeping && sleepCounter == 0){ 
      t = millis()/1000 - t_start;
      text("sleeping time:"+t ,400,400);
      if (t == 10){
        sound();
        sleepCounter += 1;
        if (key == ' '){ //alarm stops when space bar is pushed 
          alarm.close();
       }
     }
  } else if (sleep.sleeping && sleepCounter == 1){
     t = millis()/1000 - t_start;
     text("sleeping time:" + t ,400,400);
     if (t == 10){
       background(0);
       delay(2500);
       link("https://www.youtube.com/watch?v=-o-eyRMVOaw");
       sleepCounter += 1;
       t = 0;
     }
   } else if (sleep.sleeping && sleepCounter == 2){
     t = millis()/1000 - t_start;
     text("sleeping time:" + t ,400,400);
     if (t == 10){
       scarymessage();
       alarm.play();
       int countdown = 15 + t_start - millis()/1000;
       text("COMPLETES IN: " + countdown, 150, 550);
       if (countdown < 0){
         alarm.close();
         background(0);
         gameover.play();
         if (countdown < -6){
           fill(255);
           textSize(150);
           text("GAME OVER", 300, 350);
         }
       } 
     }
   } 
 }



class Sleep{
  final int N_CHANNELS = 4;
  final int PORT = 5000;
  final float threshold = 0.4f;
  float startTime = 0.0f;
  float endTime = 0.0f;
  float sleepTime_th = 10000.0f;
  boolean sleeping_tmp = false;
  boolean sleeping = false;
  OscP5 oscP5 = new OscP5(this, PORT);
  float[] buffer = new float[N_CHANNELS];
  
  public void oscEvent(OscMessage msg){
    float data;
    if(msg.checkAddrPattern("/muse/elements/alpha_relative")){
      for(int ch = 0; ch < N_CHANNELS; ch++){
        data = msg.get(ch).floatValue();
        buffer[ch] = data;
      }
    }
  }
  
  public void IsSleeping(){
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
 
public void sound(){
  alarm.play();
  background(255);
  frameRate(109);
  int x = PApplet.parseInt(random(0,width/24));
  int y = PApplet.parseInt(random(0,height/24));
  noStroke();
  fill(random(100,255),random(100,255),random(0,255),random(255));
  rect(24*x,24*y,24,24);
}


public void scarymessage(){
  background(255, 00, 00);
  fill(0);
  textSize(100);
  text("WARNING", 100, 200);
  textSize(70);
  text("DELETING ALL YOUR\nEXISTING FILES.", 150, 350);
}
  public void settings() {  size(1440, 900); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "tetsuya_UI" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
