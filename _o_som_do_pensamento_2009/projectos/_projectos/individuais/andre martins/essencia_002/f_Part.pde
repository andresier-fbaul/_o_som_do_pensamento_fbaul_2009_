class Part{
  
  float x,y;
  float vx,vy;
  float rad;
  color c = color(0,255,0);
  
  int who;
  
  Part (float posx,float posy) {
   x=posx;
   y=posy;
   rad = random (50,100);
  }
    
  
  void render(){
    
    update();
    draw();
  }
  
    void update(){
    
    float dx = x - width/2;
    float dy = y - height/2;
    float d = sqrt ( dx*dx + dy*dy   );
    
    //    // calc dist
//   /*m√≥dulode*/distx=_x-x;
//   /*m√≥dulode*/disty=_y-y;
//   //calcular a istancia ao centro
//   distc=/*raiz quadrada de*/distx*distx+disty*disty;
   
    // se a dist < 100 e > 0
    //    mov browniano

    //  se a dist for > 100 e < 1000
    //     vai ter com o centro
   if(d<100){
     
     }
     
    else if(d>100){
    x = width/2 + random(-d,d);
    y = height/2 +  random(-d,d);
    }
    
    }


  void draw(){
    fill(c);
    ellipse(x,y,rad,rad); 
  }
}



