
/// setas, O Som do Pensamento, 2009

Seta setas[];
int numcols = 15;//10;
int numrows = 15;//10;

void setup(){
  size(500,500); 
  background(0);

  setas = new Seta[numcols*numrows];
  for(int i=0; i< setas.length; i++)
    setas[i] = new Seta();

  rePosMatriz();  
}

void draw(){

  background(0);

  for(int i=0; i< setas.length; i++)
    setas[i].render();

}


void rePosMatriz() {
  //reposiciona as setas numa matriz equidistante
  
  float wr = (float)width / (float)numcols;
  float hr = (float) height / (float)numrows;

  int num=0;
  for ( int j = 0; j < numrows; j++) {
    for (int i=0; i < numcols; i++) {
      setas[num].px = i * wr + wr/2;
      setas[num].py = j * hr + hr/2;
      num++;
    }
  } 


}



void keyPressed(){
  if (key == 's')
    saveFrame("setas-#####.jpg");

  if (key == ' ')
    background(0);    
}


