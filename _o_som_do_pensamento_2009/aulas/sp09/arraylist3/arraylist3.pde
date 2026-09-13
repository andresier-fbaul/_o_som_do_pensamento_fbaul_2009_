/// arraylist como colecção dinâmica de elementos
ArrayList parts;
PFont f;
float friccao = 1.0f;//0.961;
float spring = 0.0025;//0.0015;//0.05;

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
 //  if(frameCount%10==0)
    if(random(1)<0.95) {
      Part p = new Part(mouseX,mouseY);
      parts.add(p);
    } 
    else if(random(1)<0.5){
      Part2 p = new Part2(mouseX,mouseY);
      parts.add(p);
    }
    else {
      Part3 p = new Part3(mouseX,mouseY);
      parts.add(p);
    }
  }

  for (int i=0; i<parts.size();i++){
    Part p = (Part) parts.get(i);
    if(!p.active) {
      parts.remove(i);
      continue; // next this loop
    }else {
      p.render();
      //collision-detection
       for(int j=i+1; j<parts.size();j++){
        Part o = (Part) parts.get(j);
        //distance
        float r1 = (p instanceof Part) ? 21: 51;
        float r2 = (o instanceof Part) ? 21: 51;
        float sumrad = r1+r2;
        float dx = p.x - o.x; 
        float dy = p.y - o.y; 
        float d = sqrt(dx*dx+dy*dy);
        if(d < sumrad){
          float angle = atan2(dy, dx);
          float tx = p.x + cos(angle)*sumrad;
          float ty = p.y + sin(angle)*sumrad;
          float ax = (tx -o.x) * spring;
          float ay = (ty -o.y) * spring;
          p.vx -= ax;
          p.vy -= ay;
          o.vx += ax;
          o.vy += ay;
             break; //leave this loop
        }
          
          
  /*        //hit, simply swap velocities
          float temppos[] = new float[2];
          temppos[0] = o.vx;temppos[1] = o.vy;
          o.vx = p.vx; o.vy = p.vy;
          p.vx = temppos[0]; p.vy = temppos[1];
          //advance one more step in current vel
//          o.x+=o.vx;
//          o.y+=o.vy;
//          p.x+=p.vx;
//          p.y+=p.vy;                        
*/
        
       }
    }



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



