
class Foe{
 
 float px,py;//pos
 float vx,vy,angle;//vel
 boolean lock = false;
 int lockplayer = -1;
 float force,intelligence;
 int life = 255;
  
  float diameter = 20;
  color foecolor;

 
 Foe(){
  
//  px = (random(1)<0.5) ? (0-random(100)) : (width-random(100));
//  py = (random(1)<0.5) ? (0-random(100)) : (height-random(100));

    px = width / 2 + (int) random(-20,20);
    py = height / 2 + (int) random(-20,20);

  lock = false; 
  vx = vy = angle = 0.0f;  
  force = 0.0f;  
  intelligence = random(0.001f, 0.05f);
  float cval = (int) random(100,200);
  foecolor = color ( cval, cval*0.4, 0);
 }
  
  void go(){
   
   if(!lock)
     seek();
   else
     advance();  
  }
  

  void seek(){
    
    life--;
    
    // dist to player < thresh
    for(int i =0; i < PLAYER.length; i++) {
     float dx = px - PLAYER[i].px;
     float dy = py - PLAYER[i].py;
     float d  = abs(dx) + abs(dy);
      if(d < 100) {
       lock = true;
       lockplayer = i;
      } 
    }
    
    if (lock == false)
      lockplayer = -1;
      
    angle += random(-PI/10,PI/10);
//    vx = intelligence * cos(angle);
//    vy = intelligence * sin(angle);
    vx =  cos(angle);
    vy = sin(angle);
    
    px += vx;
    py += vy;
    
    
  }
  
  void advance(){
   
 //   life-=5;
   if(random(1)<0.2)
     life-=2;
    
   // find vector
   float dx = PLAYER[lockplayer].px - px;
   float dy = PLAYER[lockplayer].py - py;
   float d = abs(dx)+abs(dy);
   
   float sumrad = diameter/2 + PLAYER[lockplayer].diameter/2;
   if(d < sumrad){
     float v = (int) random(100);
    life -=  v;
    PLAYER[lockplayer].life-=v;
   }
   
   
//   float vecx = dx / d;
 //  float vecy = dy / d;
    vx = 1.9 * dx / d;
    vy = 1.9 * dy / d;
    
    px += vx;
    py += vy;
    
    
    
  }
  
  
  void render(){
    int v = lock?0:1;
    color c = foecolor | color (0,0,v*255);
    fill(c, life);
    
    ellipse(px,py,diameter,diameter);
    
  }
  
  
}
