import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
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

public class alarm_UI extends PApplet {




ControlP5 cp5;
Minim minim;
AudioPlayer player;
Sleep sleep = new Sleep();

boolean Alarm;
int gain0 = -30;
boolean already_set = false;

int hour = hour();
int minute = minute();

int pass = 0;

public void setup(){
  
  rectMode(CENTER);
  textAlign(CENTER,CENTER);

  cp5 = new ControlP5(this);
  minim = new Minim(this);
  player = minim.loadFile("Alarm1.mp3");
  player.setGain(gain0);
  
  int s2 = 15;
  int x0 = width/2-s2/2;
  int y3 = 250-s2/2; int r2 = 14; int r3 = r2+17;

  cp5.addButton("hour_plus")
     .setLabel("+")
     .setPosition(x0-r2, y3)
     .setSize(s2, s2);
     
  cp5.addButton("hour_minus")
     .setLabel("-")
     .setPosition(x0-r3, y3)
     .setSize(s2, s2);
  
  cp5.addButton("minute_plus")
     .setLabel("+")
     .setPosition(x0+r3, y3)
     .setSize(s2, s2);
     
  cp5.addButton("minute_minus")
     .setLabel("-")
     .setPosition(x0+r2, y3)
     .setSize(s2, s2);
  
  int y4 = y3+30-s2/2;
  cp5.addToggle("Alarm")
    .setValue(false)
    .setLabel("Alarm")
    .setPosition(x0,y4)
    .setSize(15,15);
}

public void draw(){
  frameRate(60);
  background(128);
  stroke(255);
  

  int y1 = 150; int r1 = 100; int s1 = 90;
  int y2 = y1+70;
  
  int x0 = width/2;
  rect(x0-r1,y1,s1,s1);
  rect(x0,y1,s1,s1);
  rect(x0+r1,y1,s1,s1);
  textSize(50);
  text(disp_num(hour()),x0-r1,y1);
  text(disp_num(minute()),x0,y1);
  text(disp_num(second()),x0+r1,y1);
  
  textSize(30);
  text(disp_num(hour)+":"+disp_num(minute),x0,y2);
  


  sleep.IsSleeping();
  
  if((Alarm&&hour==hour()&&minute==minute()) || (sleep.sleeping&&already_set)){
    if(already_set==false){
      already_set=true;
    }

    player.play();
    text("overslept:"+str((player.position()+pass*player.length())/1000),100,70);
    if(player.position()==player.length()){
      pass++;
      player.setGain(player.getGain()+12);
      player.rewind();
      player.play();
    }
  }
  else{
    player.setGain(gain0);
    noFill();
    player.pause();
    player.rewind();
    pass = 0;
  }
} 

public String disp_num(int num){
  if(num<10){
    return "0"+str(num);
  }
  else
    return str(num);
}

public void hour_plus(){
  hour++;
  if(hour>23)
    hour -= 24;
  already_set=false;
}
public void hour_minus(){
  hour--;
  if(hour<0)
    hour += 24;
  already_set=false;
}
public void minute_plus(){
  minute++;
  if(minute>59)
    minute -= 60;
  already_set=false;    
}
public void minute_minus(){
  minute--;
  if(minute<0)
    minute += 60;
  already_set=false;
}

public void stop(){
  player.close();
  minim.stop();
  super.stop();
}



class Sleep{
  final int N_CHANNELS = 4;
  final int PORT = 5000;
  final float threshold = 0.1f;
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
  public void settings() {  size(400,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "alarm_UI" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
