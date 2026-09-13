/// circulo_attack , processing, som do pensamento


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

  background (58,95,83);

  circulo_eu.setPos(mouseX,mouseY);
  circulo_eu.draw();

  for(int i=0; i<NUM_CIRCULOS; i++) { 
    circulos_maus[i].go_mouse();
    circulos_maus[i].draw(); 
  }

}


