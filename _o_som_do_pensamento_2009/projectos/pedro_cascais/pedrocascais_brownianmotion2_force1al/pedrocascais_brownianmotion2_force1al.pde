

ArrayList p = new ArrayList();
//part p[];



void setup(){
  size(1000,500);
  frameRate(30);

 
  for(int i=0; i < 100; i++){
     part p0 = new part();
     p.add(p0);
    
  }

  background(0);

}

void draw(){

  background(0);
  
  for(int i=0; i < p.size(); i++){
    part p0 = (part)p.get(i);
    for(int j=0; j <i; j++){
          part p1 = (part)p.get(j);

       p0.interact(p1); 
    }
    
    p0.update();
    
    p0.draw();// = new part();
    
  }

  
}

void mousePressed(){
 part p0 = new part();
p0.x = mouseX;
p0.y = mouseY;
p.add(p0);
}


void keyPressed(){
 background(0); 
}
