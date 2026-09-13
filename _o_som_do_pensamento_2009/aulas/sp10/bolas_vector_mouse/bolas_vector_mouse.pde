

ArrayList balls = new ArrayList();

PVector world_dim_min = new PVector ( 0.0f, 0.0f, 500.0f  );
PVector world_dim_max = new PVector ( 1000.0f, 600.0f, 500.0f  );

float spring=0.05;
float friccao=0.9975;



void setup(){
  size(1000,600);
  frameRate(30);
  for(int i = 0; i < 20; i++) {
    Bola b = new Bola(random(width),random(100),balls); 
    balls.add(b);
  }
}

void draw(){

//  background(0);

  fill(0,16);
  noStroke();
  rect(0,0,width,height);
  stroke(0,25);


  for(int i=0; i < balls.size(); i++) {
    Bola b = (Bola) balls.get(i);
    //apply force towards mouse
    float dx = (mouseX-b.pos.x);//(b.pos.x - mouseX);
    float dy = (mouseY-b.pos.y);
    float len = sqrt(dx*dx+dy*dy);
    dx/=len; dy/=len;
    float force = 0.1;
    dx*=force; dy*=force;
    b.apply_force(new PVector(dx,dy,0));
    b.render(i);
  }
  
  
}

void keyPressed(){
  if(key=='s')
    saveFrame("bolasvectormouse-#####.jpg");
}

