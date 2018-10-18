import controlP5.*;

ControlP5 cp5;

int hour = hour();
int minute = minute();
String hour_disp = "";
String minute_disp = "";
int on_off = 0;

void setup(){
  size(400, 340);
  rectMode(CENTER);
  cp5 = new ControlP5(this);
  
  cp5.addButton("hour_plus")
     .setLabel("+")
     .setPosition(125, 210)
     .setSize(20, 20);
     
  cp5.addButton("hour_minus")
     .setLabel("-")
     .setPosition(90, 210)
     .setSize(20, 20);
  
  cp5.addButton("minute_plus")
     .setLabel("+")
     .setPosition(285, 210)
     .setSize(20, 20);
     
  cp5.addButton("minute_minus")
     .setLabel("-")
     .setPosition(250, 210)
     .setSize(20, 20);
     
  cp5.addToggle("set_alarm")
     .setLabel("Set")
     .setValue(on_off)
     .setPosition(width/2-30, height/2+80)
     .setSize(60, 40);
}

void draw(){
  background(128);
  stroke(255);
  
  
  rect(120, 150, 100, 100);
  rect(280, 150, 100, 100);
  noFill();
  
  
  textSize(60);
  show_number(hour,85,170);
  show_number(minute,245,170);
  
  if(hour == hour() && minute == minute() && on_off==0){
    textSize(50);
    text("wakeup!", width/2-80,height/2-25);
  }
}
void show_number(int a,int x,int y){
  if(a<10)
    text("0" + str(a),x,y);
  else
    text(str(a),x,y);
}

void hour_plus(){
  hour++;
  if(hour>23){
    hour -= 24;
  }
}
void hour_minus(){
  hour--;
  if(hour<0){
    hour += 24;
  }
}
void minute_plus(){
  minute++;
  if(minute>59){
    minute -= 60;
  }
}
void minute_minus(){
  minute--;
  if(minute<0){
    minute += 60;
  }
}
void set_alarm(){
  on_off++;
  if(on_off>1)
    on_off -= 2;
  if(on_off==1)
    fill(255);
}
