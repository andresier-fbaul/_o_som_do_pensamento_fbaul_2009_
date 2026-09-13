import processing.opengl.*;

int nEmitters = 5;
int nParticles = 10;
PartSys emitter[];

int nCircles = 4;
int rad = 25;
color col = color(15,210,200,80);
int btn = LEFT;
PulsingCircles mouseCursor;


void setup (){
  //size(int(0.75*screen.width),int(0.75*screen.height),OPENGL);
  size(800,800,OPENGL);
  frameRate(25);

  //create the mouse_cursor
  noCursor();
  mouseCursor = new PulsingCircles(nCircles, rad, col, btn);

  //create emitters
  emitter = new PartSys[nEmitters];
  for (int ladies = 0; ladies < nEmitters; ladies++){
    int px = int(random (width/2)+width/4);
    int py = int(random (height/2)+height/4);
    float vn = 1;
    emitter[ladies] = new PartSys(ladies, nParticles, px, py, vn);
  }
}

void draw(){
   background (50);
//  noStroke(); fill(100,125); rect(0,0,width,height); //clear background gradually
  mouseCursor.update(mouseX,mouseY);
  physics();
  for (int a=0;a<nEmitters;a++)
    emitter[a].update();
}

void physics(){
  
  float fx, fy, gM, gx, gy, frict;
  frict = 0.99;  
  
  for (int a=0; a<nEmitters; a++){                                  //for every emitter
    fx = fy = 0;
    for (int b=0; b<nEmitters; b++){                                // bring each emmiter except itself,
      if (b!=a){
        gM = 0.001*(emitter[a].rad * emitter[b].rad);
        gx = constrain(gM/sq(emitter[a].px - emitter[b].px),0,1);  //calculate grav: f(x,y) = G*(m1*m2)/dist(x,y)^2
        gy = constrain(gM/sq(emitter[a].py - emitter[b].py),0,1);
        if (emitter[a].px < emitter[b].px){fx += gx;}               //acumulate in overall forces acting over the emitter
          else{fx -= gx;}
        if (emitter[a].py < emitter[b].py){fy +=gy;}
          else{fy -= gy;}
      }
/*      
      for (int c=0; c<nParticles;c++){  // bring each particle in each emitter
        gM = 0.001*(emitter[a].rad * emitter[b].particle[c].rad);
        gx = constrain(gM/sq(emitter[a].px-emitter[b].particle[c].px),0,1); //do the same as above
        gy = constrain(gM/sq(emitter[a].py-emitter[b].particle[c].py),0,1);
        if (emitter[a].px < emitter[b].px){fx += gx;}
          else{fx -= gx;}
        if (emitter[a].py < emitter[b].py){fy +=gy;}
          else{fy -= gy;}
      }*/
    }
    
    gM = 0.01*rad*emitter[a].rad;
    gx = constrain(gM/sq(emitter[a].px-mouseX),0,1);
    gy = constrain(gM/sq(emitter[a].py-mouseY),0,1);
    if ( emitter[a].px < mouseX){fx+=gx;}
      else{fx-=gx;}
    if (emitter[a].py < mouseY){fy+=gy;}
      else{fy-=gy;}

    
    
    emitter[a].vx = emitter[a].vx*frict + fx;  // and update it's velocity
    emitter[a].vy = emitter[a].vy*frict + fy;  // in x and y accordingly
  }
}
