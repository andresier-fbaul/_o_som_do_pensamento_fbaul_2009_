/// circulos_attack , processing, som do pensamento

// agora ver a distância em relação ao circulo_eu, 
// se menor que a soma dos raios, sabemos que as formas se tocam


int NUM_CIRCULOS = 10;
Circulo circulos_maus[];
Circulo circulo_eu;

///
int score=0;
PFont font;
float eficiencia=0.0f;
boolean pausa = false;
int timereset=180; //3*60


void setup(){

  size(500,281);  // criar uma janela
  //  size(1000,562);  // mais fácil...
  frameRate(60);

  circulos_maus = new Circulo[NUM_CIRCULOS];
  for(int i=0; i<NUM_CIRCULOS; i++) { 
    circulos_maus[i] = new Circulo(); // criar um novo circulo
  }

  circulo_eu = new Circulo();
  circulo_eu.rad = 50;

  font = loadFont("Monospaced-25.vlw");
  textFont(font,12);
}


void draw(){

  //  background (58,95,83);

  if(!pausa) {

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



    //tratar do score
    score++;

    for(int i=0; i<NUM_CIRCULOS; i++) { 
      if (circulos_maus[i].touch)
        score = score - 5;
    }

    textFont(font,12);
    fill(230);
    text("score "+score, 1, height-10);

    //entrar no modo de pausa
    if(score > 1000 || score < -100) {
      pausa = true;
      timereset = frameCount + 180;
      eficiencia = (float)score / (float) frameCount;
    }


  } 
  else { // if pausa (significa ou gameover ou parabéns

    boolean win = (score > 1000);
    textFont(font,25);
    fill(230);

     text("circulos attack!!",50,50); 

    if(win) {
      text("PARABÉNS! "+eficiencia,50,200); 
    } 
    else {
      text("oooh! "+eficiencia,50,200); 
    }

    //reset do jogo
    if(frameCount>timereset){
      pausa = false;
      score = 0;
      frameCount = 0;
      if(win)      
        NUM_CIRCULOS += 5; //HAHAHAHA
      else
        NUM_CIRCULOS --;
       
       if (NUM_CIRCULOS < 2)
         NUM_CIRCULOS = 10;
        
      circulos_maus = new Circulo[NUM_CIRCULOS];
      for(int i=0; i<NUM_CIRCULOS; i++) { 
        circulos_maus[i] = new Circulo();
      }

    }

  }


}



void keyPressed(){
 
 if (key=='s')
   saveFrame("circulos-attack4-####.jpg");
  
}
