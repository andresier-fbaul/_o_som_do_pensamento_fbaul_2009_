class Obstaculo{
  float x,y,r,d;

  Obstaculo(){
    x = random(700);
    y = random(500);
    r = random(40,50);
    d = r*2.f;
  }

  void render(){
   draw(); 
  }
  
  void draw(){
   // fill(255,250);
    //ellipse (x,y,d,d);
    
    image(Obstaculo,x,y,d,d);
  }

}
