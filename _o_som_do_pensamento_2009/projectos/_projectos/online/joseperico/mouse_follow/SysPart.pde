class SysPart{

  Part  p[]; // a array de partículas
  float cx,cy; // o centro

  SysPart(int num, float x, float y){
    p = new Part[num];
    cx = x; 
    cy = y;
    for(int i=0; i<p.length;i++){
      p[i] = new Part(x,y); 
    }
  } 


  void setPos(float x, float y){
   cx = x;
   cy = y; 
  }


  void update(){

    for(int i = 0; i < p.length; i++) {
      p[i].update();
      
      if(p[i].energy < 0){
        p[i].setPos(cx,cy); //novo centro
        p[i].energy = 255;  //energia a 255 de novo
        float force = ( (frameCount*0.1) % 100);
        p[i].make_rnd_normalized_velocity(random(force));//random(2,5));
      } 

    }

  }
  
  
  void draw(){

    for(int i = 0; i < p.length; i++) 
      p[i].draw();
   
  }
  

}


