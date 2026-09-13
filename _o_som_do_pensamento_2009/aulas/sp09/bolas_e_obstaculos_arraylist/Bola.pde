class Bola{
  float x,y,r,d, vx,vy;

  Bola(){
    x = random(width);
    y = random(height);
    r = random(10,20);
    d = r*2.f;
    vx = random(-5,5);
    vy = random(-5,5);
  }

  void render(){
    colide();
   update();
   draw(); 
  }

  void colide(){
    
  }

  void update(){
    x+=vx;
    y+=vy;
    //bounds
    if(x<0)  {x=0; vx = -vx;}
    if(x>width)  {x=width; vx = -vx;}
    if(y<0)  {y=0; vy = -vy;}
    if(y>height)  {y=height; vy = -vy;}
  }
  
  void draw(){
    fill(100,200);
    ellipse (x,y,d,d);
  }

}
