


part p[];



void setup(){
  size(1000,500);
  frameRate(30);

  p = new part[50];
  for(int i=0; i < p.length; i++)
    p[i] = new part();

  background(0);

}

void draw(){

  background(0);
  
  for(int i=0; i < p.length; i++){
    
    for(int j=0; j <i; j++){
       p[i].interact(p[j]); 
    }
    
    p[i].update();
    
    p[i].draw();// = new part();
    
  }

  
}


void keyPressed(){
 background(0); 
}
