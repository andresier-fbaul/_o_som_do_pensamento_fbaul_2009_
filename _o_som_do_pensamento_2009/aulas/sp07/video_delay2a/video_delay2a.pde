// video delay, andré sier, 2008
// mouseX controls the delay amount

import processing.video.*;
PImage frames[];
Capture cam;
int time = 10*30;//1seg@30pfs frames
int timehead, timeoffset, timeread;
int lefttime, righttime;
int lefttime1, righttime1;

void setup(){
  size(640,720);
  frameRate(30);
  frames = new PImage[time];
  for(int i=0;i<frames.length;i++){
    frames[i] = new PImage(320,240); 
  }
  cam = new Capture(this,320,240,30);
}

void draw(){

  if(cam.available()){
    cam.read(); 
    timehead = (timehead + 1) % frames.length;
    frames[timehead].copy(cam,0,0,320,240,0,0,320,240);
    timeoffset = (int)map(mouseX,0,width,time,0);
    timeread = (timehead + timeoffset) % frames.length;

    if(frameCount%100==0){
      lefttime = (int) random(time);
      righttime = (int) random(time);
      lefttime1 = (int) random(time);
      righttime1 = (int) random(time);
    }
    
    lefttime = (lefttime + 1) % frames.length;
    righttime = (righttime + 1) % frames.length;
    lefttime1 = (lefttime + timeoffset) % frames.length;
    righttime1 = (righttime + timeoffset) % frames.length;

    image(frames[timehead],0,0,320,240);
    image(frames[timeread],320,0,320,240);

    image(frames[lefttime],0,240,320,240);
    image(frames[righttime],320,240,320,240);

    image(frames[lefttime1],0,480,320,240);
    image(frames[righttime1],320,480,320,240);


  }

}

void keyPressed(){
  if (key=='s'){
    saveFrame("delay2a-#####.jpg");
  }  
}

