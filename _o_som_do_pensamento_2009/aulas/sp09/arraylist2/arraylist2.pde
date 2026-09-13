/// arraylist como colecção dinâmica de elementos
ArrayList parts;
PFont f;
float friccao = 0.961;

void setup(){
  size(500,500);
  f = createFont("sans-serif",12); 
  textFont(f,12);
  parts = new ArrayList(); //criar uma arraylist vazia
  Part novaPart = new Part(width/2,height/2);
  Part2 novaPart2 = new Part2(width/2,height/2);
  parts.add(novaPart); // adicionar um elemento
  parts.add(novaPart2); // adicionar um elemento
}

void draw(){
  background(127);
  noStroke();
  fill(255);
  text("partículas: "+parts.size()+"\nfriccao: "+friccao+" (f/F ajustar)",
  5,height-25);

  if(mousePressed){
    if(random(1)<0.95) {
      Part p = new Part(mouseX,mouseY);
      parts.add(p);
    } 
    else {
      Part2 p = new Part2(mouseX,mouseY);
      parts.add(p);
    }
  }

  for (int i=0; i<parts.size();i++){
    Part p = (Part) parts.get(i);
    if(!p.active)
      parts.remove(i);
    else
      p.render();
  }

}


void keyPressed(){
  if(key=='f')
    friccao-=0.01;
  if(key=='F')
    friccao+=0.01;
  if(key=='s')
    saveFrame("arraylist-#####.jpg");

}



