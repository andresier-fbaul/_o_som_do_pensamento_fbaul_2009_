class part {
  float x,y;
  float vx,vy;
  float ax,ay;

  part(){
    x = random(0,width);
    y = height;
  }


  void interact(part p){
   float dx = p.x -x;
   float dy = p.y -y;
   float d = sqrt(dx*dx+dy*dy);
   float spring = 0.005;
   
   if(d> 0 && d < 30) {
     
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * 2;
        float targetY = y + sin(angle) * 2;
         ax += (targetX - p.x) * spring;
         ay += (targetY - p.y) * spring;
        vx -= ax;
        vy -= ay;
  //obstaculo não se move
        p.vx += ax;
        p.vy += ay;
    
     
   }
    
   
    
  }

  void update(){
    
    ax+=random(-0.3,0.3);
    ay+=random(-0.5,0.2);
    
    vx += ax;
    vy += ay;
    
    x += vx;
    y += vy;
    
    ax = 0;
    ay = 0;
    
    if(y < 0 || y > height)
      vy = -vy; //y = 0;
      
    if(x < 0 || x > width)
      vx = -vx;
    
  }

  void draw(){
      
    ellipse(x,y,20,20);
  }

}


