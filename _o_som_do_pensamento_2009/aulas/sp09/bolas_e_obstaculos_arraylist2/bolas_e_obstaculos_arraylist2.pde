
ArrayList bolas = new ArrayList();
ArrayList obstaculos = new ArrayList();
float spring=0.03;
float friccao = 0.9991;

void setup(){
  size (700,500); 
  init_scene();
}

void draw(){
 background(0);

 for(int i=0; i<obstaculos.size(); i++){
  Obstaculo o = (Obstaculo) obstaculos.get(i);
  o.render();
 } 

 for(int i=0; i<bolas.size(); i++){
  Bola b = (Bola) bolas.get(i);
  b.render();
 } 
  
}

void mouseReleased(){
   Bola b = new Bola(mouseX,mouseY);
   bolas.add(b);
}


void init_scene(){
 int num_ob = (int) random(10,20);
 int num_bolas = (int) random(10,20);
 
 for(int i = 0; i < num_ob; i++) {
   Obstaculo o = new Obstaculo();
   obstaculos.add(o);   
 }
 for(int i = 0; i < num_bolas; i++) {
   Bola b = new Bola();
   bolas.add(b);   
 }
  
}


void keyPressed(){
  if(key=='s')
    saveFrame("bolasobstaculos2-#####.jpg");
}
