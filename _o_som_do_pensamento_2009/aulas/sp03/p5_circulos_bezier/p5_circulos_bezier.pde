/*  
 
 circulos, som do pensamento
 
 usar a posição do rato para criar circulos
 que têm raio inicial e final e curvaturas distintas
 
 
 */


Circ  circulos[]; // uma array de circulos

float x1,x2,x3,x4,y1,y2,y3,y4; //os pontos da linha bezier

void setup(){
  size(700,700);
  frameRate(30);
  background(200); 

  init_circulos();
}


void draw(){

  //  noStroke();
  //  fill(200,20);
  //  rect(0,0,width,height);


  noFill();

  if(mousePressed && mouseX!=pmouseX && mouseY!=pmouseY) {
    new_circ();
    draw_bezier();
  }

  draw_circulos(); 

}



void draw_bezier(){
 //1. incrementar os pontos
  x4 = x3;
  y4 = y3;
  x3 = x2;
  y3 = y2;
  x2 = x1;
  y2 = y1;
  x1 = mouseX;
  y1 = mouseY;
  
  //2. desenhar a curva nos pontos
  bezier(x1,y1,x2,y2,x3,y3,x4,y4);
  
}



void keyPressed(){
  if(key=='s')
    saveFrame("circulosbezier-######.jpg"); 
}


