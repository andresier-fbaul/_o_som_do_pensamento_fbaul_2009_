class SysPart{

  Part  p[]; // a array de partículas
  float cx,cy; // o centro
  String texto[] = { "Converts", "laser", "scanning", "video", "to", "mathematical", 
  "surface","This", "program", "takes", "as", "input", "a", ".avi", 
  "rotation", "o2f", "an", "object" };

loadStrings

  SysPart(int num, float x, float y){
    p = new Part[num];
    cx = x; 
    cy = y;
    
    String lines[] = loadStrings("obama.txt");
    texto = split(lines,'  ,');
    
    for(int i=0; i<p.length;i++){
      String txt = texto[(int)random(texto.length)];
      p[i] = new Part(x,y,txt); 
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


