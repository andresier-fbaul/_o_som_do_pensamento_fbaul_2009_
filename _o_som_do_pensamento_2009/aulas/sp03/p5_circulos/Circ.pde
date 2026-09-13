

///// init circulos

void init_circulos() {

  circulos = new Circ[10];

  for(int i = 0; i < circulos.length; i++) {
    circulos[i] = new Circ();
  } 

}

///// new circulo



void new_circ(){

  if(pmouseX!=mouseX && pmouseY!=mouseY) // só se o rato antigo não é igual ao actual...
  for(int i = 0; i < circulos.length; i++) {
      if(!circulos[i].active){
          circulos[i] = new Circ();
          circulos[i].centro(mouseX,mouseY);
          circulos[i].active = true; //aqui é q se inicia  
          break; // importantíssimo, senão 10 circs      
      }
  }

}

///// draw circulos

void draw_circulos() {
  for(int i = 0; i < circulos.length; i++) {
//    strokeWeight(i+0.1);
    circulos[i].draw();
  } 
}


///// class circulos

class Circ {

  float raio;
  float angulo;

  float ppx, ppy; //previous pos px, py
  float px,py;

  float cx, cy; //centro x y

  float curv;
  float raio_ini, raio_fim, raio_inc;
  boolean active;

  Circ(){
    raio_ini = 0;//random (0,230);  //(50,500);
    raio_fim = random(10,100);//random (10,370);
    raio_inc = random (0.1,1.2);    
    raio = raio_ini;
    // se o raio final é menor, o raio_inc tem de ser negativo
    if(raio_fim < raio_ini)
      raio_inc = -raio_inc;
    active = false;//true;

    curv = (random(1)<0.5) ? random (0.1,0.3) :  random (0.3,1.73)  ;
    // definir a direcção aleatória do circulo
    if (random(1)<0.5)  
        curv *= -1 ;

    //centros
    cx = width/2 + random(-width/3,width/3);
    cy = height/2 + random(-height/3,height/3);
    
    angulo = random(TWO_PI); //iniciar o circulo noutras pos

  }

  void centro(float cx, float cy){
    this.cx = cx;
    this.cy = cy; 
    px = cos(angulo)*raio+cx;
    py = sin(angulo)*raio+cy;
  }


  void draw(){
    if( active ) {
      // armazenar ps valores anteriores
      ppx = px;
      ppy = py;

      angulo += curv;
      raio += raio_inc;

      //já chegou ao fim?
      if(raio_inc > 0){
        if(raio>raio_fim)
          active=false;  
      } 
      else {
        if(raio<raio_fim)
          active=false;      
      }     



      px = cos(angulo)*raio + cx;
      py = sin(angulo)*raio + cy;
      
      stroke(0,50);
      line(px,py,ppx,ppy);


    }

  }



}




