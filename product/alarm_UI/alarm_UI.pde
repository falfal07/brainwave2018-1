import controlP5.*;
import ddf.minim.*;

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

void setup(){
  size(400,400);
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

void draw(){
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
  

  //text(str(player.getGain()),50,70);
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

String disp_num(int num){
  if(num<10){
    return "0"+str(num);
  }
  else
    return str(num);
}

void hour_plus(){
  hour++;
  if(hour>23)
    hour -= 24;
  already_set=false;
}
void hour_minus(){
  hour--;
  if(hour<0)
    hour += 24;
  already_set=false;
}
void minute_plus(){
  minute++;
  if(minute>59)
    minute -= 60;
  already_set=false;    
}
void minute_minus(){
  minute--;
  if(minute<0)
    minute += 60;
  already_set=false;
}

void stop(){
  player.close();
  minim.stop();
  super.stop();
}
