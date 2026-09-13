class SysPart{

  Part  p[]; // a array de partículas
  float cx,cy; // o centro
  float cdev = noise(0.,1.); //desvio do centro
  float fx,fy; // uma força
  String texto[] = {""};



  SysPart(int num, float x, float y){
    p = new Part[num];
    cx = x; 
    cy = y;
    
    String lines[] = loadStrings("3.txt");
    for(int i=0; i<lines.length;i++) {
      String  words[] = splitTokens(lines[i]," ,") ;
      for(int j=0; j<words.length;j++) {
        texto = append ( texto, words[j] );
      }
    }
    
    println("texto com "+texto.length+" palavras" );
    
    for(int i=0; i<p.length;i++){
      String txt = texto[(int)random(texto.length)];
      p[i] = new Part(x,y,txt); 
    }
  } 


  void setPos(float x, float y){
   cx = x;
   cy = y; 
  }
  
  void setPosForce(float x, float y, float px, float py){
   cx = x;
   cy = y; 
   this.fx = (x - px)*0.1;
   this.fy = (y - py)*0.1;
  }


  void update(){

    for(int i = 0; i < p.length; i++) {
      p[i].update();
      
      if(p[i].energy < 0){
        p[i].setPosForce(cx+ random(-cdev,cdev),cy+ random(-cdev,cdev),fx,fy); //novo centro, nova força
        p[i].energy = 255;  //energia a 255 de novo
        float force = ( (frameCount*0.1) % 800);
        p[i].make_rnd_normalized_velocity(random(force));//random(2,5));
      } 

    }

  }
  
  
  void draw(){

    for(int i = 0; i < p.length-1; i++) 
     if(p[i].energy>0) {
        p[i].draw();
        
//        float d = dist(p[i].px,p[i].py,p[i+1].px,p[i+1].py);
     
//       if (d>25||d<600)
//         line( p[i].px,p[i].py,p[i+1].px,p[i+1].py);   
//        strokeWeight(1.0);
//         stroke(random(0,255),100);
//         line( (p[i].px)*0.128359,p[i].py,p[i+1].px,-p[i+1].py); 
//          strokeWeight(1.0);
//         stroke(175,100);
//         line( p[i].px,p[i].py,p[i+1].px,p[i+1].py);
//          strokeWeight(1.0);
//         stroke(150,100);
//         line( (p[i].px)*0.12359,p[i].py,p[i+1].px,-p[i+1].py);
//         line( ((p[i].px)*0.12359)+1,p[i].py,p[i+1].px,p[i+1].py);
//         line( ((p[i].px)*0.12359)+2,p[i].py,p[i+1].px,p[i+1].py);
//          strokeWeight(1.0);
//         stroke(125,0);
   
     }
    
        
   
  }
  
  
  
  
  

}


