
ArrayList bolas = new ArrayList();
ArrayList obstaculos = new ArrayList();
ArrayList tiros = new ArrayList();
float spring=0.03;
float friccao = 0.9991;
Destino dst;
Bola ze;

int count=0;
PFont font;

void setup(){
  size (700,500); 
  ze = new Bola(width/2,height/2);
  dst = new Destino();
  init_scene();
  font = createFont("sans-serif",10);
  textFont(font,10);
}

void draw(){
  background(0);
  noStroke();
  fill(255);
  text(count,2,height-20);

  dst.draw();

  ze_go();  

  for(int i=0; i<obstaculos.size(); i++){
    Obstaculo o = (Obstaculo) obstaculos.get(i);
    o.render();
  } 

  for(int i=0; i<bolas.size(); i++){
    Bola b = (Bola) bolas.get(i);
    if(!b.live){
      bolas.remove(i); 
      count++;
    }
    else{
      b.render(i);
      ze.colide(i-1); //-1 para aceder a todas as bolas...
    }
  } 

  ze.draw();

  stroke(1);
  stroke(255);

  for(int i=0; i<tiros.size(); i++){
    Tiro t = (Tiro) tiros.get(i);
    if(t.energy<0){
      tiros.remove(i); 
      //count++;
    }
    else{
      t.render();
//      ze.colide(i-1); //-1 para aceder a todas as bolas...
    }
  } 



}


void ze_go(){
  //update da posição
  ze.x+=ze.vx;
  ze.y+=ze.vy;
  //update da velocidade em direcção ao rato
  ze.vx = (mouseX-ze.x)*0.1;
  ze.vy = (mouseY-ze.y)*0.1; 
  
  if(mousePressed&&frameCount%10==0){
   Tiro t = new Tiro(ze.x,ze.y,atan2(ze.vy,ze.vx)); 
   tiros.add(t);
  }
  

// outro método
//  ze.x = 0.9*ze.x + 0.1*mouseX;
//  ze.y = 0.9*ze.y + 0.1*mouseY;
//  ze.vx = mouseX-pmouseX;
//  ze.vy = mouseY-pmouseY; 
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
    saveFrame("bolasobstaculos6-#####.jpg");
}
