/// circulo , processing, som do pensamento


Circulo circulos[];
int NUM_CIRCULOS = 10;

void setup(){
  size(500,281);  // criar uma janela

  circulos = new Circulo[NUM_CIRCULOS];
  for(int i=0; i<NUM_CIRCULOS; i++) { 
    circulos[i] = new Circulo(); // criar um novo circulo
  }

  //overwrite dos valores das vari‡veis mouse e mousePressed
  mouseX = width/2;
  mouseY = width/2;
  mousePressed = true;
}


void draw(){

  background (58,95,83);
  go_mouse();
  for(int i=0; i<NUM_CIRCULOS; i++) { 
    circulos[i].draw(); 
  }

}

void go_mouse(){

  for(int i = 0; i < NUM_CIRCULOS; i++) {

    if(mousePressed){
      // um filtro low pass ao movimento com destino ao rato
      float filter = 0.01;			
      circulos[i].posx =  circulos[i].posx * (1.0-filter) + mouseX * filter;
       circulos[i].posy =  circulos[i].posy * (1.0-filter) + mouseY * filter;
    } 
    else {
      //se o rato n‹o premido, afastamo-nos
      float filter = 0.01;	
      // calcular um vector com origem no rato atŽ ao circulo
      float dx =  circulos[i].posx - mouseX;
      float dy =  circulos[i].posy - mouseY;
      // as coordenadas de destino s‹o a posi‹o do c’rculo + o vector
       circulos[i].posx =  circulos[i].posx * (1.0-filter) + ( circulos[i].posx +dx) * filter;
       circulos[i].posy =  circulos[i].posy * (1.0-filter) + ( circulos[i].posy +dy) * filter;	
    }

  }

}
