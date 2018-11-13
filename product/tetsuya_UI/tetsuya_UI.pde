import ddf.minim.*; //minim library needed 

Sleep sleep = new Sleep();

Minim minim;       
AudioPlayer gameover; 
AudioPlayer alarm;

int t_start = millis()/1000; // time elapsed since app started 
int t; // time elapsed since start sleeping
int sleepCounter; // how many times have slept
 
 
void setup(){
  size(1440, 900);
  background(240);
  frameRate(30); 
  fill(0); 
  textSize(70);
  text("ALL NIGHTER BOOSTER", 330, 100);
  minim = new Minim(this); 
  gameover = minim.loadFile("gameover.mp3"); // load mp3 file in data folder  
  alarm = minim.loadFile("alarm.mp3");
}

 void draw(){
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
