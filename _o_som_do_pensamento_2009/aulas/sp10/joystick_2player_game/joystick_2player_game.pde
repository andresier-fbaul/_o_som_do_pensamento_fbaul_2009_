

import processing.opengl.*;

import procontroll.*;
import java.io.*;

ControllIO controll;
ControllDevice device;

/// a-sier added
//ControllSlider sliderx, slidery, sliderz;
float mytol = 0.05f;
float totalz = 10;

////// game controls

ArrayList firelist = new ArrayList();     // fire list
Player PLAYER[] ;//= new Player[2];          // player array
ArrayList foelist = new ArrayList();     // foe list

ControllSlider p0sliderx, p0slidery, p1sliderx, p1slidery; // sticks
ControllButton p0fire , p1fire;

PFont font;

////// game controls


void setup(){
  size(600,400,OPENGL);//800,400,OPENGL);
  frameRate(30);

  controll = ControllIO.getInstance(this);
  controll.printDevices();

  device = controll.getDevice("Logitech Dual Action");//"Logitech RumblePad 2 USB");///"USB Game Controllers");////Logitech RumblePad 2 USB");
  device.printSticks();

  p0sliderx = device.getSlider(0); 
  p0sliderx.setTolerance(mytol);
  p0slidery = device.getSlider(1); 
  p0slidery.setTolerance(mytol);

  p1sliderx = device.getSlider(2); 
  p1sliderx.setTolerance(mytol);
  p1slidery = device.getSlider(3); 
  p1slidery.setTolerance(mytol);

  println("tolerance: " + p0sliderx.getTolerance());

  p0fire =  device.getButton(8);
  p1fire =  device.getButton(9);

  println("buttons");
  device.printButtons();

  fill(0);
  rectMode(CENTER);

  font  = createFont(PFont.list()[2],80); //loadFont("AndaleMono-27.vlw");//createFont(PFont.list()[2],27);

  /// init players & world


  float h2 = (float)height/2f;

  PLAYER = new Player[2];          // player array
  PLAYER[0] = new Player (50, h2, 0);
  PLAYER[1] = new Player (width-50, h2, 1);
  println(PLAYER.length);

}


void draw(){
  fill(255,25);
  rect(0,0,width*2,height*2);

  handle_joystick();

  for(int i=0; i<PLAYER.length; i++) {
    PLAYER[i].go();   
    PLAYER[i].render();    
    if(PLAYER[i].life <= 0) {

      int tempscore = PLAYER[i].score;
      PLAYER[i] = new Player((float)(i*(width-50)),(float)height/2f, i);
      PLAYER[i].score = tempscore;

      if(i==0) PLAYER[1].score+=10; //score++
      else  PLAYER[0].score+=10;
    }
  }


  for(int i=0; i<firelist.size(); i++) {
    Fire f = (Fire) firelist.get(i);
    f.go();
    f.render();
    if(f.life<=0)
      firelist.remove(i);
  }


  if(frameCount% 60 == 0) {
    Foe f = new Foe(); 
    foelist.add(f); 
  }


  for(int i=0; i<foelist.size(); i++) {
    Foe f = (Foe) foelist.get(i);
    f.go();
    f.render();
    if(f.life <= 0) {
      foelist.remove(i);
    }
  }





  // show score
  fill(0);
  String s1 = "player1 " + PLAYER[0].score + "\n"+PLAYER[0].life;
  String s2 = "player2 " + PLAYER[1].score + "\n"+PLAYER[1].life;

  textFont(font,20);
  text(s1,10,height-30);
  text(s2,width-150,height-30);
}




void handle_joystick(){

  PLAYER[0].vx =  p0sliderx.getValue();
  PLAYER[0].vy =  p0slidery.getValue();
  if(!PLAYER[0].fire && frameCount > PLAYER[0].firenow && p0fire.pressed())
    PLAYER[0].fire=true;

  PLAYER[1].vx =  p1sliderx.getValue();
  PLAYER[1].vy =  p1slidery.getValue();
  if(!PLAYER[1].fire && frameCount > PLAYER[1].firenow && p1fire.pressed())
    PLAYER[1].fire=true;




}



void keyPressed(){
  if(key=='s')
    saveFrame("joystickgame-#####.jpg");

}

