/// circulo , processing, som do pensamento


Circulo circulo;


void setup(){
  size(500,281);  // criar uma janela
  circulo = new Circulo(); // criar um novo circulo

  //overwrite dos valores das vari�veis mouse e mousePressed
  mouseX = width/2;
  mouseY = width/2;
  mousePressed = true;
}


void draw(){

  background (58,95,83);
  go_mouse();
  circulo.draw();

}

void go_mouse(){

  if(mousePressed){
    // um filtro low pass ao movimento com destino ao rato
    float filter = 0.01;			
    circulo.posx = circulo.posx * (1.0-filter) + mouseX * filter;
    circulo.posy = circulo.posy * (1.0-filter) + mouseY * filter;
  } else {
    //se o rato n�o premido, afastamo-nos
    float filter = 0.01;	
    // calcular um vector com origem no rato at� ao circulo
    float dx = circulo.posx - mouseX;
    float dy = circulo.posy - mouseY;
    // as coordenadas de destino s�o a posi��o do c�rculo + o vector
    circulo.posx = circulo.posx * (1.0-filter) + (circulo.posx +dx) * filter;
    circulo.posy = circulo.posy * (1.0-filter) + (circulo.posy +dy) * filter;	


  }

}
