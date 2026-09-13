/// circulos_attack , processing, som do pensamento

// agora ver a distância em relação ao circulo_eu, 
// se menor que a soma dos raios, sabemos que as formas se tocam


int NUM_CIRCULOS = 10;
Circulo circulos_maus[];
Circulo circulo_eu;

void setup(){

  size(500,281);  // criar uma janela

  circulos_maus = new Circulo[NUM_CIRCULOS];
  for(int i=0; i<NUM_CIRCULOS; i++) { 
    circulos_maus[i] = new Circulo(); // criar um novo circulo
  }

  circulo_eu = new Circulo();
  circulo_eu.rad = 50;
}


void draw(){

//  background (58,95,83);

  fill (58,95,83  ,  25);
  noStroke();
  rect(0,0,width,height);
  
  

  circulo_eu.setPos(mouseX,mouseY);
  circulo_eu.draw();

  for(int i=0; i<NUM_CIRCULOS; i++) { 
    circulos_maus[i].go_mouse();
    circulos_maus[i].draw(); 
  }

  if(frameCount%200==0){
    for(int i=0; i<NUM_CIRCULOS; i++) { 
      circulos_maus[i].reset();
     }

  }

}



