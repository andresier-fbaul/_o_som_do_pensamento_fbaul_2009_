class Obstaculo{
  float x,y,r,d;

  Obstaculo(){
    x = random(width);
    y = random(height);
    r = random(20,50);
    d = r*2.f;
  }

  void render(){
   draw(); 
  }
  
  void draw(){
    fill(255,250);
    ellipse (x,y,d,d);
  }

}
