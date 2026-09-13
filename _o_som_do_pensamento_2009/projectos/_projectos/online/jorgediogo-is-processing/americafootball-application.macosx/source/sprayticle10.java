import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 
import ddf.minim.*; 

import java.applet.*; 
import java.awt.*; 
import java.awt.image.*; 
import java.awt.event.*; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class sprayticle10 extends PApplet {

/**
American Football<br/>
<br/>
Use mouse or blow to your microphone.<br/>
American Football poem by Harold Pinter: <a href="http://www.haroldpinter.org/poetry/poetry_football.shtml">http://www.haroldpinter.org/poetry/poetry_football.shtml</a><br/>

*/







// import a library


// um objecto da biblioteca
Minim minim;
// o objecto do input sonoro
AudioInput in;

int fps = 60;

SysPart sp[];
float audioEnergy=0.0f;
float lastAlpha = 128;
float spSpeed = 15;


ObsShape[] obsShape;
int obsCount = (int)sq(6);
PFont font;


public void setup(){

  size(700,700,OPENGL); // 
  smooth();
  frameRate(fps);

  minim = new Minim(this);
  minim.debugOn();

  // get line-in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, 512);
  
  font = loadFont("04b03-16.vlw");
  textFont(font,16);
  
  obsShape = new ObsShape[obsCount];
  placeAliensGrid();
 

  sp = new SysPart[1];
  sp[0] = new SysPart(400,
                   0,height-0, 
                   spSpeed, 
                   0*PI/180, -90*PI/180,
                   0,0,
                   obsShape);
/*  
  sp[1] = new SysPart(400,
                   width,height-0, 
                   speed, 
                   -180*PI/180, -90*PI/180,
                   0,0,
                   obsShape);
*/
}






public void draw(){
  
  float lastFrameHits = 0;
  for(int i=0; i<sp.length; i++)
    lastFrameHits += sp[i].lastFrameHits;
    
  float al = map(lastFrameHits, 0,30, 32,0);
  
  
  float factor = 0.6f;
  al = al*factor + lastAlpha*(1.0f-factor);
  lastAlpha = al;
//  println("alpha: " + al); 
  fill(0, al);
  noStroke();
  rect(0,0,width,height);  
  
  float rms = in.mix.level();
  
  if(mousePressed){
    float angle = atan2(mouseY-height, mouseX) * 180/PI;
    rms = map(angle + random(angle*0.04f, -angle*0.04f), 
              0, -90, 
              sp[0].lowerThreshold,sp[0].higherThreshold);
//println(angle + " " + rms);    
//    rms = map(mouseY + random(-mouseY*0.1, mouseY*0.1), 
//              height*0.9,0, sp[0].lowerThreshold,sp[0].higherThreshold);
    rms=min( rms, sp[0].higherThreshold ); 
    rms=max( rms, sp[0].lowerThreshold ); 
  }
  
  float f = 0.5f;
  audioEnergy = audioEnergy * (1.f-f) + rms * f;  
  
  boolean noOneToShootNow=true;
  for(int i=0; i<obsCount; i++){
    obsShape[i].draw();
    if(obsShape[i].enabled)
      noOneToShootNow=false;
  }
  
  for(int i=0; i<sp.length; i++){
    sp[i].draw(); 
    if(noOneToShootNow){    
      sp[i].noOneToShootNow=true;
    }
    sp[i].update(audioEnergy);
  }  

  if(noOneToShootNow){    
//    text("no one to shoot now...", width*0.4, height*0.3);
    text( "Hallelujah!\nIt works.\nWe blew the shit out of them.\n\nWe blew the shit right back up their own ass\nAnd out their fucking ears.\n\nIt works.\nWe blew the shit out of them.\nThey suffocated in their own shit!\n\nHallelullah.\nPraise the Lord for all good things.\n\nWe blew them into fucking shit.\nThey are eating it.\n\nPraise the Lord for all good things.\n\nWe blew their balls into shards of dust,\nInto shards of fucking dust.\n\nWe did it.\n\nNow I want you to come over here and kiss me on the mouth.\n\n\nAmerican Football, Harold Pinter"
          ,(int)(width*0.3f), (int)(height*0.2f));
  }
}



public void keyPressed(){

  if(key=='s')
    saveFrame("sprayticle-######.jpg");   
  else {
//  if(key == ' '){
    int spLen = sp.length;
    for(int i=1; i<spLen; i++)
      sp=(SysPart[])shorten(sp);
    sp[0].noOneToShootNow=false;
    placeAliensGrid();
  }
  
}



public void weHaveANewAlienCollaborator(float px, float py){
//  println("weHaveANewAlienCollaborator: " + px + " " + py);

  SysPart newSp = new SysPart(150, // 200 100
                               px,py, 
                               spSpeed, 
                               0*PI/180, -180*PI/180,
                               0,0,
                               obsShape);
  sp=(SysPart[])append(sp, newSp);
}




public void placeAliensGrid(){
  
  int side = (int)sqrt(obsCount);
  float delta = width*0.8f / side;
  
  for(int y=0; y<side; y++){
    float top = width*0.1f + y*delta;    
    for(int x=0; x<side; x++){
      
      float left = width*0.15f + x*delta;    
      float w=random(width*0.01f, width*0.1f);
      float h=random(height*0.01f, height*0.1f);

      int col = getColdPastel(); // color(random(100,255), random(100,255), random(100,255));
      obsShape[y*side + x] = new ObsShape(left, top,   
                                          left+w, top+h,
                                          col);    
    }
  }  
}

public void placeAliensRandom(){
  for(int i=0; i<obsCount; i++){
    float x=random(width*0.3f, width*0.9f);
    float y=random(height*0.2f, height*0.8f);
    
    float w=random(width*0.05f, width*0.1f);
    float h=random(height*0.05f, height*0.1f);

    int col = getColdPastel(); // color(random(100,255), random(100,255), random(100,255));
    obsShape[i] = new ObsShape(x, y,   
                               x+w, y+h,
                               col);    
  }  
}







public int getHotPastel(){

int[] palette = {
0xffFFDAB9, 0xffEECBAD, 0xffCDAF95, 0xffFFE7BA, 0xffEED8AE, 0xffCDBA96, 0xffFFE4B5, 0xffFFDEAD, 0xffEECFA1, 0xffFFE4C4, 0xffEED5B7, 0xffCDB79E, 0xffFFD39B, 0xffEEC591, 0xffCDAA7D, 0xffFFA07A, 0xffEE9572, 0xffCD8162, 0xffFF8C69, 0xffEE8262, 0xffCD7054, 0xffFFA54F, 0xffEE9A49, 0xffCD853F   
// http://www.hitmill.com/html/pastels2.html #D1D17A, #C0A545, #C27E3A, #C47557, #B05F3C, #C17753, #B96F6F//, #D7D78A, #CEB86C, #C98A4B, #CB876D, #C06A45, #C98767, #C48484, #DBDB97, #D6C485, #D19C67, #D29680, #C87C5B, #D0977B, #C88E8E, #E1E1A8, #DECF9C, #DAAF85, #DAA794, #CF8D72, #DAAC96, #D1A0A0, #E9E9BE, #E3D6AA, #DDB791, #DFB4A4, #D69E87, #E0BBA9, #D7ACAC, #EEEECE, #EADFBF, #E4C6A7, #E6C5B9, #DEB19E, #E8CCBF, #DDB9B9, #E9E9C0, #EDE4C9, #E9D0B6, #EBD0C7, #E4C0B1, #ECD5CA, #E6CCCC, #EEEECE, #EFE7CF, #EEDCC8, #F0DCD5, #EACDC1, #F0DDD5, #ECD9D9, #F1F1D6, #F5EFE0, #F2E4D5, #F5E7E2, #F0DDD5, #F5E8E2, #F3E7E7, #F5F5E2, #F9F5EC, #F9F3EC, #F9EFEC, #F5E8E2, #FAF2EF, #F8F1F1, #FDFDF9, #FDFCF9, #FCF9F5, #FDFAF9, #FDFAF9, #FCF7F5, #FDFBFB
};  
  return palette[ (int)random(0,palette.length) ];
}


public int getColdPastel(){

int[] palette = {
0xff62A9FF, 0xff62D0FF, 0xff06DCFB, 0xff75B4FF, 0xff75D6FF, 0xff24E0FB, 0xff86BCFF, 0xff8ADCFF, 0xff3DE4FC, 0xff99C7FF, 0xff99E0FF, 0xff63E9FC, 0xff99C7FF, 0xffA8E4FF, 0xff75ECFD, 0xffA8CFFF, 0xffBBEBFF, 0xff8CEFFD, 0xffBBDAFF, 0xffCEF0FF, 0xffACF3FD, 0xffD0E6FF, 0xffD9F3FF, 0xffC0F7FE
// http://www.hitmill.com/html/pastels.html  #5757FF, #62A9FF, #62D0FF, #06DCFB, #01FCEF, #03EBA6, #01F33E//, #6A6AFF, #75B4FF, #75D6FF, #24E0FB, #1FFEF3, #03F3AB, #0AFE47, #7979FF, #86BCFF, #8ADCFF, #3DE4FC, #5FFEF7, #33FDC0, #4BFE78, #8C8CFF, #99C7FF, #99E0FF, #63E9FC, #74FEF8, #62FDCE, #72FE95, #9999FF, #99C7FF, #A8E4FF, #75ECFD, #92FEF9, #7DFDD7, #8BFEA8, #AAAAFF, #A8CFFF, #BBEBFF, #8CEFFD, #A5FEFA, #8FFEDD, #A3FEBA, #BBBBFF, #BBDAFF, #CEF0FF, #ACF3FD, #B5FFFC, #A5FEE3, #B5FFC8, #CACAFF, #D0E6FF, #D9F3FF, #C0F7FE, #CEFFFD, #BEFEEB, #CAFFD8, #E1E1FF, #DBEBFF, #ECFAFF, #C0F7FE, #E1FFFE, #BDFFEA, #EAFFEF, #EEEEFF, #ECF4FF, #F9FDFF, #E6FCFF, #F2FFFE, #CFFEF0, #EAFFEF, #F9F9FF, #F9FCFF, #FDFEFF, #F9FEFF, #FDFFFF, #F7FFFD, #F9FFFB
};  
  
  return palette[ (int)random(0,palette.length) ];
}


class ObsShape {
  float left, top, right, bottom;
  int col;
  int lastHitFrameCount;

  int hitCount;
  boolean enabled;

  int dieHitCount = 600;  
  int warCollaboratorHitCount = 700;  
  
  int framesTillUp = (int)(fps * 2.5f); // frames after a hit that it will move up
  
  
  ObsShape(float x1, float y1, float x2, float y2, int col){
    left=min(x1,x2);
    top=min(y1,y2);
    right=max(x1,x2);
    bottom=max(y1,y2);
    this.col=col;
    lastHitFrameCount = frameCount;    
    hitCount=0;
    enabled = true;
  }  

  public boolean isCircleColliding(float cx, float cy, float rad){
    if(!enabled)
      return false;
    if((cx >= left-rad) && (cx < right+rad) &&
       (cy >= top-rad) && (cy < bottom+rad))
      return true;
    else
      return false;    
  } 

  public boolean isHorizontal(){
    return abs(left-right) >= abs(top-bottom);
  }

  public void move(float dx, float dy){
    if(!enabled)
      return;
    
    left+=dx;
    right+=dx;
    top+=dy;
    bottom+=dy;
    
    float w=right-left;
    float h=bottom-top;
    if(left < 0){
      right=w;
      left=0;
    }
    if(right > width){
      right=width;
      left=right-w;
    }
    if(top < 0){
      bottom=h;
      top=0;      
    }
    if(bottom > height){
      bottom=height;
      top=bottom-h;
    }
    
  }

  public void hit(float dx, float dy){
    hitCount++;
    move(dx,dy);
    lastHitFrameCount = frameCount;
  }


  public int getState(){
    if(!enabled)
      return 0;
    if(hitCount >= dieHitCount){
      if(hitCount >= warCollaboratorHitCount){ // zombie? no - collaborator
        return -1;
      }
      else { // just dead
        return 0;
     }
     
    }
    else { // alive and well
      return 1;
    }
    
  }
  
  public void draw(){
    
    if(!enabled)
      return;

    int state = getState();
    
    if(state <= 0){
      if(state == -1){
        weHaveANewAlienCollaborator((right+left)/2, (bottom+top)/2);
        enabled=false;
        
/*        fill(32, 128);
        stroke(40, 128);    
        rect(left,top-(bottom-top)*7, right,bottom); */        
      }
      else {
        fill(64,200);
        stroke(80,200);    
        rect(left,top, right-left,bottom-top);
      }
      move(0,+1);
      
      if(frameCount - lastHitFrameCount >= framesTillUp){
        hitCount--;
        if(hitCount == dieHitCount)
          col = getColdPastel();
      }
      
     
    }
    else { // alive
      if(frameCount - lastHitFrameCount >= framesTillUp){
        move(0,-0.5f);
      }

      fill(col);
      stroke(200);    
      rect(left,top, right-left,bottom-top);
    }

  }
} 



class Part{

  float px,py, ppx,ppy;
  float energy,energy_dec;
  float rad;

  float vx,vy; //vel
  float f; //friction

  float gravity; //gravidade, for\u00e7a no eixo dos y
  float fx,fy; //for\u00e7a nos eixos
  int col;

  Part(float x,float y){
    px = ppx = x;
    py = ppy = y;
    
    
    energy = 0.0f; 
    energy_dec = 1.0f; //random(5,10);//random(10.9,20.);
    rad = random(10,50);
    //make_rnd_normalized_velocity(50.);
    
    f = 1.0f; // 0.9
    gravity = 0.08f;
    col = color( 232, random(100,152), 40); //reddishes
  }

  Part(float x,float y, 
       float vx, float vy, 
       float fx, float fy, 
       int c){
    this(x,y);
    this.vx=vx;
    this.vy=vy;
    this.fx=fx;
    this.fy=fy;
    col = c;
  }

  public void make_rnd_normalized_velocity(float force){
    vx = random(-1,1);
    vy = random(-1,1);
    //normalizar, dividir cada componente pelo comprimento do vector
    float len = sqrt(vx*vx+vy*vy);
    if(len>0.f){
     vx = vx / len;
     vy = vy / len; 
     vx *= force;
     vy *= force;
    }
    
  }


  public void setPos(float x, float y){
   px = ppx = x;
   py = ppy = y; 
  }

  public void setPosForce(float x, float y, float fx, float fy){
   px = ppx = x;
   py = ppy = y; 
   this.fx = fx;
   this.fy = fy;
  }
  
  public void setPosVelForce(float x, float y, 
                      float vx, float vy, 
                      float fx, float fy){
   px = ppx = x;
   py = ppy = y; 
   this.vx = vx;
   this.vy = vy;
   this.fx = fx;
   this.fy = fy;
  }  
  
  public void update(){
    //store pos
    ppx = px;
    ppy = py;
    
    //update velocity
    vy = vy + gravity ;
    vx = vx + fx;
    vy = vy + fy;
    
    //friction = vel * friction
    vx = vx * f;
    vy = vy * f;
    
    // position = pos + vel
    px = px + vx;
    py = py + vy;
    
    if((py >= height) ||
       (px < 0) ||
       (px >= width))
      energy=-1;  
    else
    // energy
      energy = energy - energy_dec;
  }

  public void draw(){
    if(energy <= 0)
      return;
    
    stroke(col, (int)energy);
    line(ppx,ppy,px,py);
//    line(px-1,py-1,px,py);
  }

}

class SysPart{

  Part  p[]; // array de part\u00edculas
  
  ObsShape obsShape[];
  
  float cx,cy; // o centro

  float speed;
  float minAngle, maxAngle;
  float fx,fy; // uma for\u00e7a

  int lastFrameHits;
  
  float rad = 8;  
  float lowerThreshold = 0.09f;
  float higherThreshold = 0.9f;

  boolean noOneToShootNow;

  SysPart(int num, 
          float x, float y, 
          float speed, 
          float minAngle, float maxAngle, 
          float fx, float fy, 
          ObsShape[] obsShape){
    p = new Part[num];
    cx = x; 
    cy = y;
    
    this.speed=speed;
    this.minAngle=minAngle;
    this.maxAngle=maxAngle;
    
    this.fx=fx;
    this.fy=fy;
    
    for(int i=0; i<p.length;i++){
      p[i] = new Part(x,y, 0,0, 0,0, 0xffffffff); 
    }
    
    this.obsShape = obsShape;
    noOneToShootNow=false;
 }

  public void setPos(float x, float y){
   cx = x;
   cy = y; 
  }

  public void setPosForce(float x, float y, float afx, float afy){
   cx = x;
   cy = y; 
   fx = afx;
   fy = afy;
  }


  public void update(float energy){
    
    lastFrameHits=0;

    int freeSlotIndex=-1;
    
// update and find a free slot:
    for(int i = 0; i < p.length; i++) {
      
      if(p[i].energy <= 0){
        freeSlotIndex=i;
        continue;
      }
        
      p[i].update();
      
      for(int o=0; o<obsShape.length; o++){
       
       if(obsShape[o].isCircleColliding(p[i].px, p[i].py, 1)){
         
         float dx,dy;
         if(p[i].vx != 0) 
           dx = p[i].vx/abs(p[i].vx);
         else dx = 0;
         
         if(p[i].vy != 0) 
           dy = p[i].vy/abs(p[i].vy);
         else
           dy = 0;
         obsShape[o].hit(dx,dy);
         
         if(!obsShape[o].isHorizontal()){
           p[i].vx=0;
           p[i].vy=random(-1,1);
         }
         else {
           p[i].vx=random(-1,1);
           p[i].vy=0;
         }
         
 // mix colors between rect and 'ticle
         int obsColor = obsShape[o].col;
         int ticleColor = p[i].col;
         
         obsShape[o].col = ticleColor;
/*         obsShape[o].col = color( (red(obsColor) + red(ticleColor)) / 2,
                                  (green(obsColor) + green(ticleColor)) / 2,
                                  (blue(obsColor) + blue(ticleColor)) / 2); */
                                  
         p[i].col=obsColor;
         
         if(obsShape[o].getState() <= 0)
           p[i].energy=-1;
         else
           p[i].energy-=1;
      
        lastFrameHits++;
        
       } // for obs
       
     }

    }

    if(noOneToShootNow)
      energy = lowerThreshold * random(1.05f, 1.2f); 
    

    if((energy > lowerThreshold) && 
       (freeSlotIndex >= 0)){ 
    
        float newSpeed = map(energy, lowerThreshold,higherThreshold, 0,speed);
        float newAngle = map(energy, lowerThreshold,higherThreshold, minAngle,maxAngle);
//        newAngle = max(newAngle,maxAngle*0.99);
        if(newAngle < min(minAngle,maxAngle))
          newAngle=min(minAngle,maxAngle);
        else
        if(newAngle > max(minAngle,maxAngle))
          newAngle=max(minAngle,maxAngle);
        
        p[freeSlotIndex].setPosVelForce(cx,cy, 
                            newSpeed*cos(newAngle), newSpeed*sin(newAngle), 
                            fx,fy); //novo centro, nova for\u00e7a
        p[freeSlotIndex].energy = 1000;
        
        int c = getHotPastel();
        p[freeSlotIndex].col = c;
        
//println("shot! angle:" + newAngle*180/PI + " speed: "+ newSpeed);        
//        float force = ( (frameCount*0.1) % 100);
//        p[i].make_rnd_normalized_velocity(random(force));//random(2,5));
    }

  }
  
  
  public void draw(){

    for(int i = 0; i < p.length; i++) 
      p[i].draw();
      
      
      
    noStroke();
    fill(164);
    ellipse(cx, cy, rad, rad);
   
  }
  

}



  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#000000", "--hide-stop", "sprayticle10" });
  }
}
