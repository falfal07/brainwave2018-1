import controlP5.*;

ControlP5 cp5;
int state;

void setup(){
  size(400,400);
  textSize(32);
  textAlign(CENTER);
  state = 0;
  cp5 = new ControlP5(this);
  cp5.addButton("button1")
     .setLabel("MODE1")
     .setPosition(150,100)
     .setSize(100,50);
  cp5.addButton("button2")
     .setLabel("MODE2")
     .setPosition(150,200)
     .setSize(100,50);
}
void draw(){
}

void button1(){
  //launch("/alarm_UI/alarm_UI.pde");
  println("clicked");
}
void button2(){
  launch("/Users/nakatomo/Desktop/lecture/3a/応用プロジェクト/brainwave2018-1/base/base.pde");
  println("clicked");
  
}
