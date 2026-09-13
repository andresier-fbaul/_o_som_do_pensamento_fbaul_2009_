class FloatingCircle {
  int rad = 10;
  float px, py;
  float vx,vy;
   
  void setup(){
    px = random(width-2*rad)+rad;
    py = random(height-2*rad)+rad;
    vx = random (2)-1;
    vy = random (2)-1;
    float normVel = sqrt(vx*vx+vy*vy);
    float force = random(5);
    vx = vx * force / normVel ;
    vy = vy * force / normVel ;
  }
  

  
  void update(){
    float ax = px-mouseX;
    float ay = py-mouseY;
    float aNormAL = sqrt(sq(ax)+sq(ay));
    float gravity = sq(aNormAL)*0.1;       // lol...
    ax /= gravity;
    ay /= gravity;
    vx-=ax;
    vy-=ay;
    px+=vx;
    py+=vy;
    bounce();

    draw();
  }
  
  void bounce(){
    if(px<0){px=-px; vx=-vx;}
      else if (px>width){px=width-(px-width);vx=-vx;}
    if(py<0){py=-py; vy=-vy;}
      else if (py>height){py=height-(py-height);vy=-vy;}
  }
  
  void draw(){
    fill(255,150);
    noStroke();
    ellipse(px , py, rad, rad);
  }
}
