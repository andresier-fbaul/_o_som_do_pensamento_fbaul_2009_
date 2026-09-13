

class Circulo {
  
  float posx, posy, rad;  
  
  Circulo(){
    rad = random(10,30);
    posx = random(rad,width-rad);
    posy = random(rad,height-rad);
  }
  
  void draw(){

    stroke(0);
    fill(82,247,195);
    
    ellipse(posx,posy,rad,rad);
    
  }
  
  void reset(){
     posx = random(rad,width-rad);
     posy = random(rad,height-rad);
  
  }
  
}
