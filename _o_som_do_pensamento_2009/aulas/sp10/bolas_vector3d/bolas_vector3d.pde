import processing.opengl.*;

ArrayList balls = new ArrayList();
float a;

PVector world_pos_min = new PVector ( 0.0f, 0.0f, -100.0f  );
PVector world_pos_max = new PVector ( 1000.0f, 600.0f, -1000.0f  );
PVector world_pos_c = new PVector ( (world_pos_min.x+world_pos_max.x)/2.0f, 
                                     (world_pos_min.y+world_pos_max.y)/2.0f,
                                     (world_pos_min.z+world_pos_max.z)/2.0f );
float spring=0.025;//0.05;//0.05;
float friccao=0.999;//0.99991;//1.0f;//0.9975;
float grav = 1;//0.25;//0.72;



void setup(){
  size(1000,600,OPENGL);
  frameRate(30);
  sphereDetail(5);
  
  for(int i = 0; i < 10; i++) {
    Bola b = new Bola(random(width),random(100),random(world_pos_min.z,world_pos_max.z),balls); 
    balls.add(b);
  }
}



void add_ball(){
   Bola b = new Bola (mouseX, random(100), world_pos_c.z , balls);
   balls.add(b);
   println("esferas: "+balls.size());
}

void draw(){

  if(keyPressed&&key=='a')
    add_ball();
  
  background(0);
  
  drawWorldBox();
  
 // fill(255,100);
  fill(255); stroke(0);
  for(int i=0; i < balls.size(); i++) {
    Bola b = (Bola) balls.get(i);
    if(mousePressed){
      //apply force towards mouse
      float dx = (mouseX-b.pos.x);//(b.pos.x - mouseX);
      float dy = (mouseY-b.pos.y);
      float len = sqrt(dx*dx+dy*dy);
      dx/=len; 
      dy/=len;
      float force = 0.5;//0.1;
      dx*=force; 
      dy*=force;
      b.apply_force(new PVector(dx,dy,0));
    }
    b.render(i);
  }
  



}



