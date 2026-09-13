class part {
  float x,y;
  float vx,vy;
  float ax,ay;

  part(){
    x = random(0,width);
    y = height;
  }



  void goMouse(float x0, float y0){
   float dx = x0 -x;
   float dy = y0 -y;
   float d = sqrt(dx*dx+dy*dy);
   float spring = 0.05;
   
   if(d> 0 && d < 230) {
     
//        float angle = atan2(dy, dx);
//        float targetX = x + cos(angle) * 10.2;
//        float targetY = y + sin(angle) * 10.2;
      d = 1f/d;
      dx *=d*spring;
      dy*=d*spring;

         ax += dx;
         ay += dy;//(targetY - y0) * spring;
//        vx += ax;
//        vy += ay;
    
     
   }
    
   
    
  }


  void interact(part p){
   float dx = p.x -x;
   float dy = p.y -y;
   float d = sqrt(dx*dx+dy*dy);
   float spring = 0.16;
   
   if(d> 0 && d < 130) {
     
     
          d = 1f/d;
      dx *=d*spring;
      dy*=d*spring;

         ax += dx;
         ay += dy;//(targetY - y0) * spring;

     
     
// 
//
//     float angle = atan2(dy, dx);
//        float targetX = x + cos(angle) * 0.2;
//        float targetY = y + sin(angle) * 0.2;
//         ax += (targetX - p.x) * spring;
//         ay += (targetY - p.y) * spring;
////        vx -= ax;
////        vy -= ay;
//  //obstaculo não se move
//        p.ax += ax;
//        p.ay += ay;
    
     
   }
    
   
    
  }

  void update(){
    
    ax+=random(-0.03,0.03);
    ay+=random(-0.05,0.02);
    
    ax = constrain(ax, -1., 1. );
    ay = constrain(ay, -1., 1. );
    
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


