class Nuvem {
  
  float x,y;
  float vx,vy;
  float px,py;
  MYPART2D part;
  
  Nuvem(){
   
    part = null;//(MYPART2D)particulas.get((int)random(particulas.size()));
    x = width/2 + random(-100,100);
    y = height/2 + random(-100,100);
    vx = random(-5,5);
    vy = random(-5,5);
  }
  
  void renew(){
     part =(MYPART2D) particulas.get((int)random(particulas.size()));
  }
  
  void go(){
    
    if(part==null){
      renew();
      return;
    }
  
    x += (part.x - x) * 0.05;
    y += (part.y - y)*0.05;

    ellipse(x,y,25,25);
    
  }
  
}
