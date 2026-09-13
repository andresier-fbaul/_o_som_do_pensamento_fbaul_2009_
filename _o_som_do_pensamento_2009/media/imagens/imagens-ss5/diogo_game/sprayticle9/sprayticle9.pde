import processing.opengl.*;

// import a library
import ddf.minim.*;

// um objecto da biblioteca
Minim minim;
// o objecto do input sonoro
AudioInput in;

int fps = 60;

SysPart sp[];
float audioEnergy=0.0;
float lastAlpha = 128;
float spSpeed = 15;


ObsShape[] obsShape;
int obsCount = (int)sq(6);
PFont font;


void setup(){

  size(700,700,OPENGL); // 
  smooth();
  frameRate(fps);

  minim = new Minim(this);
  minim.debugOn();

  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, 512);
  
  // nova fonte
  font = createFont(PFont.list()[1],16);
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






void draw(){
  
  float lastFrameHits = 0;
  for(int i=0; i<sp.length; i++)
    lastFrameHits += sp[i].lastFrameHits;
    
  float al = map(lastFrameHits, 0,30, 32,0);
  
  
  float factor = 0.6;
  al = al*factor + lastAlpha*(1.0-factor);
  lastAlpha = al;
//  println("alpha: " + al); 
  fill(0, al);
  noStroke();
  rect(0,0,width,height);  
  
  float rms = in.mix.level();
  
  if(mousePressed){
    rms = map(mouseY + random(-mouseY*0.1, mouseY*0.1), 
              height*0.9,0, sp[0].lowerThreshold,sp[0].higherThreshold);
    rms=max( rms, sp[0].lowerThreshold ); 
  }
  
  float f = 0.5;
  audioEnergy = audioEnergy * (1.-f) + rms * f;  
  
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
    text( "Hallelujah!\nIt works.\nWe blew the shit out of them.\n...\n\nHarold Pinter", width*0.4, height*0.3);
  }
}



void keyPressed(){

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



void weHaveANewAlienCollaborator(float px, float py){
//  println("weHaveANewAlienCollaborator: " + px + " " + py);

  SysPart newSp = new SysPart(100,
                               px,py, 
                               spSpeed, 
                               0*PI/180, -180*PI/180,
                               0,0,
                               obsShape);
  sp=(SysPart[])append(sp, newSp);
}




void placeAliensGrid(){
  
  int side = (int)sqrt(obsCount);
  float delta = width*0.8 / side;
  
  for(int y=0; y<side; y++){
    float top = width*0.1 + y*delta;    
    for(int x=0; x<side; x++){
      
      float left = width*0.15 + x*delta;    
      float w=random(width*0.01, width*0.1);
      float h=random(height*0.01, height*0.1);

      color col = getColdPastel(); // color(random(100,255), random(100,255), random(100,255));
      obsShape[y*side + x] = new ObsShape(left, top,   
                                          left+w, top+h,
                                          col);    
    }
  }  
}

void placeAliensRandom(){
  for(int i=0; i<obsCount; i++){
    float x=random(width*0.3, width*0.9);
    float y=random(height*0.2, height*0.8);
    
    float w=random(width*0.05, width*0.1);
    float h=random(height*0.05, height*0.1);

    color col = getColdPastel(); // color(random(100,255), random(100,255), random(100,255));
    obsShape[i] = new ObsShape(x, y,   
                               x+w, y+h,
                               col);    
  }  
}







color getHotPastel(){

color[] palette = {
#FFDAB9, #EECBAD, #CDAF95, #FFE7BA, #EED8AE, #CDBA96, #FFE4B5, #FFDEAD, #EECFA1, #FFE4C4, #EED5B7, #CDB79E, #FFD39B, #EEC591, #CDAA7D, #FFA07A, #EE9572, #CD8162, #FF8C69, #EE8262, #CD7054, #FFA54F, #EE9A49, #CD853F   
// http://www.hitmill.com/html/pastels2.html #D1D17A, #C0A545, #C27E3A, #C47557, #B05F3C, #C17753, #B96F6F//, #D7D78A, #CEB86C, #C98A4B, #CB876D, #C06A45, #C98767, #C48484, #DBDB97, #D6C485, #D19C67, #D29680, #C87C5B, #D0977B, #C88E8E, #E1E1A8, #DECF9C, #DAAF85, #DAA794, #CF8D72, #DAAC96, #D1A0A0, #E9E9BE, #E3D6AA, #DDB791, #DFB4A4, #D69E87, #E0BBA9, #D7ACAC, #EEEECE, #EADFBF, #E4C6A7, #E6C5B9, #DEB19E, #E8CCBF, #DDB9B9, #E9E9C0, #EDE4C9, #E9D0B6, #EBD0C7, #E4C0B1, #ECD5CA, #E6CCCC, #EEEECE, #EFE7CF, #EEDCC8, #F0DCD5, #EACDC1, #F0DDD5, #ECD9D9, #F1F1D6, #F5EFE0, #F2E4D5, #F5E7E2, #F0DDD5, #F5E8E2, #F3E7E7, #F5F5E2, #F9F5EC, #F9F3EC, #F9EFEC, #F5E8E2, #FAF2EF, #F8F1F1, #FDFDF9, #FDFCF9, #FCF9F5, #FDFAF9, #FDFAF9, #FCF7F5, #FDFBFB
};  
  return palette[ (int)random(0,palette.length) ];
}


color getColdPastel(){

color[] palette = {
#62A9FF, #62D0FF, #06DCFB, #75B4FF, #75D6FF, #24E0FB, #86BCFF, #8ADCFF, #3DE4FC, #99C7FF, #99E0FF, #63E9FC, #99C7FF, #A8E4FF, #75ECFD, #A8CFFF, #BBEBFF, #8CEFFD, #BBDAFF, #CEF0FF, #ACF3FD, #D0E6FF, #D9F3FF, #C0F7FE
// http://www.hitmill.com/html/pastels.html  #5757FF, #62A9FF, #62D0FF, #06DCFB, #01FCEF, #03EBA6, #01F33E//, #6A6AFF, #75B4FF, #75D6FF, #24E0FB, #1FFEF3, #03F3AB, #0AFE47, #7979FF, #86BCFF, #8ADCFF, #3DE4FC, #5FFEF7, #33FDC0, #4BFE78, #8C8CFF, #99C7FF, #99E0FF, #63E9FC, #74FEF8, #62FDCE, #72FE95, #9999FF, #99C7FF, #A8E4FF, #75ECFD, #92FEF9, #7DFDD7, #8BFEA8, #AAAAFF, #A8CFFF, #BBEBFF, #8CEFFD, #A5FEFA, #8FFEDD, #A3FEBA, #BBBBFF, #BBDAFF, #CEF0FF, #ACF3FD, #B5FFFC, #A5FEE3, #B5FFC8, #CACAFF, #D0E6FF, #D9F3FF, #C0F7FE, #CEFFFD, #BEFEEB, #CAFFD8, #E1E1FF, #DBEBFF, #ECFAFF, #C0F7FE, #E1FFFE, #BDFFEA, #EAFFEF, #EEEEFF, #ECF4FF, #F9FDFF, #E6FCFF, #F2FFFE, #CFFEF0, #EAFFEF, #F9F9FF, #F9FCFF, #FDFEFF, #F9FEFF, #FDFFFF, #F7FFFD, #F9FFFB
};  
  
  return palette[ (int)random(0,palette.length) ];
}


