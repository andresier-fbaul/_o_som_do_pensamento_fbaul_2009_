class SysPart1{

  Part1  p1[]; // a array de partículas
  float cx,cy; // o centro
  float cdev = random(250, 300); //desvio do centro
  float fx,fy; // uma força
  String texto[] = {""};



  SysPart1(int num, float x, float y){
    p1 = new Part1[num];
    cx = x; 
    cy = y;
    
    String lines[] = loadStrings("1.txt");
    for(int i=0; i<lines.length;i++) {
      String  words[] = splitTokens(lines[i]," ,") ;
      for(int j=0; j<words.length;j++) {
        texto = append ( texto, words[j] );
      }
    }
    
    println("texto com "+texto.length+" palavras" );
    
    for(int i=0; i<p1.length;i++){
      String txt = texto[(int)random(texto.length)];
      p1[i] = new Part1(x,y,txt); 
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

    for(int i = 0; i < p1.length; i++) {
      p1[i].update();
      
      if(p1[i].energy < 0){
        p1[i].setPosForce(cx+ random(-cdev,cdev),cy+ random(-cdev,cdev),fx,fy); //novo centro, nova força
        p1[i].energy = 255;  //energia a 255 de novo
        float force = ( (frameCount*0.1) % 800);
        p1[i].make_rnd_normalized_velocity(random(force));//random(2,5));
      } 

    }

  }
  
  
  void draw(){

    for(int i = 0; i < p1.length-1; i++) 
     if(p1[i].energy>0) {
        p1[i].draw();
        
//        float d = dist(p1[i].px,p1[i].py,p1[i+1].px,p1[i+1].py);
     
      // if (d>25||d<150)
        // line( p1[i].px,p1[i].py,p1[i+1].px,p1[i+1].py);

       
 //       strokeWeight(1.0);
 //        stroke(random(150,255),  255);
   
     }
    
        
   
  }
  

}


