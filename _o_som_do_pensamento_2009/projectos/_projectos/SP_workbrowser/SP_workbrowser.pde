/*

SOM DO PENSAMENTO

work browser

andré sier, 20090622


*/



WorkBrowser wb;
PFont font,bigfont;

void setup(){
  
  size(screen.width,screen.height);
  frameRate(10);
  
  int works[] = new int[5];
  works[0] = 0;
  works[1] = 1;
  works[2] = 2;
  works[3] = 3;
  works[4] = 4;
  
  wb = new WorkBrowser(works);
  font = createFont("monaco",10);
  bigfont = createFont("monaco",52);
  
}




void draw(){
  background(0);  
  header();
  wb.render();      
}


void keyPressed(){
 if(key==ESC){//intercept esc
   key=0;
   println("esc"+frameCount); 
 }
}



void header(){
  
  
}
