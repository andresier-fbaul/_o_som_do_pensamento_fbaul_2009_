class Obstaculo{
  float x,y,r,d;

  Obstaculo(){
    x = random(width);
    y = random(height);
    r = random(20,50);
    d = r*2.f;
  }

  void render(){
   //draw(); 
   draw_mesh( x, 0,  y,  d);
  }
  
  void draw(){
    fill(100,50,0,250);
    ellipse (x,y,d,d);
  }

}
