class PartSys {

  int index, px, py; float vx, vy;  //emitter index, position and velocity

  int nCircles, rad; color col; int btn; // emitterShape properties
  PulsingCircles emitterShape;

  int nParticles;  //num of particles in emitter
  Part particle[];
  
  PartSys(int in_index, int in_nParticles, int in_px, int in_py, float vn){
    index = in_index;
    nParticles = in_nParticles;
    px = in_px;
    py = in_py;
    vx = random (-vn,vn);
    vy = int(random(2))*2-1;
    vy*=sqrt(sq(vn)-sq(vx));

    // create the emitterShape
    nCircles = 4;
    rad = 30;  //radius
    col = color(255,50,50,80);  //color
    btn = CENTER;
    emitterShape = new PulsingCircles(nCircles, rad, col, btn);
    
    //create the particles
    vn = random(3);
    particle = new Part[nParticles];
    for (int a=0; a<nParticles; a++){
      particle[a] = new Part(index, px, py, vn);
    }
    
  }
  
  void update(){
    px+=vx;
    py+=vy;
    bounce();
    emitterShape.update(px, py);
    for(int a=0;a<nParticles; a++){
      particle[a].update();
    }
  }
  
  void bounce(){
    if(px<=rad)
      {px=rad+(rad-px); vx=-vx;}
      else if ((px+rad)>=width)
        {px=width-(width-px); vx=-vx;}
    if(py<=rad)
      {py=rad+(rad-py); vy=-vy;}
      else if ((py+rad)>=height)
        {py=height-(height-py); vy=-vy;}
  }
}
   
