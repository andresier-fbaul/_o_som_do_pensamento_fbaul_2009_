class Part{
  
  int par, energy_0, energy_1, px, py; float vx, vy, vn;  //parent, energy, position and velocity
  
  int nCircles, rad; color col; int btn;  //partShape properties
  PulsingCircles partShape;
  
  Part(int in_par, int in_px, int in_py, float in_vn){
    par = in_par;
    px = in_px;
    py = in_py;
    vn = in_vn;
    vx = random (-vn,vn);
    vy = int(random(2))*2-1;
    vy*=sqrt(sq(vn)-sq(vx));
    energy_0 = energy_1 = int(random(500));
    
    nCircles = 2;
    rad = 20;  //radius
    col = color(100,150,255,70);  //color
    btn = RIGHT;
    partShape = new PulsingCircles(nCircles, rad, col, btn);  //particle shape
  }

  void update(){
    
    if (energy_1>0){
      float fx = mouseX-px;
      float fy = mouseY-py;
      float fn = (sq(fx)+sq(fy))*0.1;
      fx /= fn;
      fy /= fn;
      float frict = 0.99;
      vx = vx * frict + fx;
      vy = vy * frict + fy;
      
      px +=vx;
      py +=vy;
      energy_1--;    
      bounce();
      partShape.rad_0 = rad* energy_1/energy_0;
    }
    else{respawn();}
    partShape.update(px,py);  //update shape

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
  
  void respawn(){
    px = emitter[par].px;
    py = emitter[par].py;
    vx = random (-vn,vn);
    vy = int(random(2))*2-1;
    vy *= sqrt(sq(vn)-sq(vx));
    energy_0 = energy_1 = int(random(500));
    partShape.rad_0 = rad;
    partShape.rad_1 = 0;
  }
}
