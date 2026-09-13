/*  
 
 circulos, som do pensamento
 
 usar a posição do rato para criar circulos
 que têm raio inicial e final e curvaturas distintas
 
 
 */


Circ  circulos[]; // uma array de circulos

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


  if(mousePressed)
    new_circ();

  draw_circulos(); 

}


void keyPressed(){
  if(key=='s')
    saveFrame("circulos-######.jpg"); 
}






