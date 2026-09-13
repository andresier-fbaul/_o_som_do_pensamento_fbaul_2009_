

class Circulo {
  
  float posx, posy, rad;  
  float force; //uma variável para a força
  
  Circulo(){
    rad = random(10,30);
    posx = random(rad,width-rad);
    posy = random(rad,height-rad);
    force = random(0.0001,0.04);
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
  
  
  void go_mouse(){
      // agora os circulos vão sempre ter com o do rato
       
       float filter = force; // agora o filtro é controlado com uma var única       
       posx =  posx * (1.0-filter) + mouseX * filter;
       posy =  posy * (1.0-filter) + mouseY * filter;

  }

  void setPos(float x,float y){
    float f = 0.3;
    posx = posx*(1.0-f)+x*f;
    posy = posy*(1.0-f)+y*f; 
  }
  
  
}

