



class SysPart{

  Part  p[]; // a array de partículas
  float cx,cy; // o centro
  float cdev = noise(0.,1.); //desvio do centro
  float fx,fy; // uma força
  String texto[] = {
    ""  };
  int id;


  ////
  float velmax;
  //  int tipoletra;
  int tamanholetra;
  float forcaattrrepul = 0.f;



  SysPart(int _id, int num, float x, float y, String[] txtraw){
    p = new Part[num];
    cx = x; 
    cy = y;
    id = _id;

    String lines[] = txtraw;  //loadStrings("3.txt");
    for(int i=0; i<lines.length;i++) {
      String  words[] = splitTokens(lines[i]," ,") ;
      for(int j=0; j<words.length;j++) {
        texto = append ( texto, words[j] );
      }
    }

    println("syspart "+id+": texto com "+texto.length+" palavras" );

    for(int i=0; i<p.length;i++){
      String txt = texto[(int)random(texto.length)];
      p[i] = new Part(x,y,txt); 
    }
  } 

  void setTexto(String data[]){

    // texto = data;

    //refresh txt data
    texto = new String[0];//{""};
    String lines[] = data;
    for(int i=0; i<lines.length;i++) {
      String  words[] = splitTokens(lines[i]," ,") ;
      for(int j=0; j<words.length;j++) {
        texto = append ( texto, words[j] );
      }
    }

    for(int i=0; i<p.length;i++){
      String txt = texto[(int)random(texto.length)];
      p[i] = new Part(cx,cy,txt); 
    }


  }

  void setPos(float x, float y){
    cx = x;
    cy = y; 
  }

  void setPosForce(float x, float y, float px, float py, float amt){
    cx = x;
    cy = y; 
    this.fx = (x - px)*amt;//0.1;
    this.fy = (y - py)*amt;//0.1;
  }


  void update(){

    for(int i = 0; i < p.length; i++) {
      p[i].update();

      if(p[i].energy < 0){
        p[i].setPosForce(cx+ random(-cdev,cdev),cy+ random(-cdev,cdev),fx,fy);//, //0.1); 
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

        float d = dist(p[i].px,p[i].py,p[i+1].px,p[i+1].py);

        if (d>25||d<600)
          line( p[i].px,height,p[i+1].px,height);   
        strokeWeight(1.0);


      }



  }






}



