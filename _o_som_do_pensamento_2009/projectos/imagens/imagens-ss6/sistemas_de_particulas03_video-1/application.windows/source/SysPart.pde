class SysPart{

  Part  p[]; // a array de partículas
  float cx,cy; // o centro
  float vx,vy;
  float cdev = 20; //desvio do centro
  float fx,fy; // uma força
  float rad, b; //raio do emissor
  int points; //pontuação
  PFont ariale;
  

  
  SysPart(int num, float x, float y){
    p = new Part[num];
    ariale = loadFont("ArialMT-20.vlw");
    vx=0;
    vy=0;
    cx = x; 
    cy = y;
    points = 0;
    for(int i=0; i<p.length;i++){
      p[i] = new Part(x+ random(-cdev,cdev),y+ random(-cdev,cdev)); 
    }
  } 


  void setPos(){
    vx+=random(1)-0.5;
    vy+=random(1)-0.5;
    cx+=vx;
    cy+=vy;
    if(cx<rad/2||cx>width-rad/2){
      vx*=-1;
    }
    if(cy<rad/2||cy>height-rad/2){
      vy*=-1;
    }
  }


  void update(){
    //modificar o raio do emissor
    float av = in.mix.level();
    b = 300-map(av,0,.5,5,300);
    rad=(5*rad+b)/6;
    
    setPos();
    count(cx,cy,rad/2,-100);
    
    for(int i = 0; i < p.length; i++) {
      p[i].update();
      if(p[i].energy < 0){
        p[i].setPosForce(cx+ random(-cdev,cdev),cy+ random(-cdev,cdev),fx,fy); //novo centro, nova força
        p[i].energy = 1000;  //energia a 255 de novo
        float force = 20;
        p[i].make_rnd_normalized_velocity(random(force));//random(2,5));
      } 
    }
  }

  boolean count(float x, float y, float minDist, int value){
      boolean a = false;
      float distance= sqrt((x-mouseX)*(x-mouseX)+(y-mouseY)*(y-mouseY));
      if(distance<(minDist+15)){
        points += value;
        a = true;
      }
      textFont(ariale, 20);
      fill(255);
      text(points, 10, 30);
      noFill();
      return a;
    }
      
  
  void draw(){
    stroke(23,175,190);
    ellipse(cx,cy,rad,rad);
    for(int i = 0; i < p.length; i++) 
      p[i].draw();
  }
  

}


