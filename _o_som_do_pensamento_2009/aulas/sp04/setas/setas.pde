
/// setas, O Som do Pensamento, 2009

Seta setas[];


void setup(){
  size(500,500); 
  background(0);
  
  setas = new Seta[10];
  for(int i=0; i< setas.length; i++)
    setas[i] = new Seta();
}

void draw(){

  for(int i=0; i< setas.length; i++)
    setas[i].render();

}


void keyPressed(){
 if (key == 's')
   saveFrame("setas-#####.jpg");

 if (key == ' ')
   background(0);    
}
