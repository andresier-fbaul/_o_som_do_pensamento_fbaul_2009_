

class Circulo {
  
  float posx, posy, rad;  
  float force; //uma variável para a força
  
  Circulo(){
    rad = random(10,30);
    posx = random(rad,width-rad);
    posy = random(rad,height-rad);
    force = random(0.25,1.5); // agora a força refere-se a x pixeis
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
      // mas movem apenas num eixo, onde a dist for maior
      
      // 1. calcular distâncias 
      float distx = mouseX - posx;
      float disty = mouseY - posy;
      boolean axis = ( abs(distx) > abs(disty) );
      
      if(axis==true) { // a distância do eixo x é maior, então anda ao longo do x
        float sign = ( distx > 0 ) ? 1. : -1. ; // ciclo if abreviado
        posx += sign * force;        
      } else {
        float sign = ( disty > 0 ) ? 1. : -1. ; // ciclo if abreviado
        posy = posy + sign * force;        
        
      }
      
  }

  void setPos(float x,float y){
    float f = 0.3;
    posx = posx*(1.0-f)+x*f;
    posy = posy*(1.0-f)+y*f; 
  }
  
  
}

