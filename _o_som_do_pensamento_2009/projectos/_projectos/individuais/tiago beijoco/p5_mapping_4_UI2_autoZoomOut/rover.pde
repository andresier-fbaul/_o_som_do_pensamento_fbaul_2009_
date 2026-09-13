class Rover{

  float ry, px, py, pz;  // rover orientation and position
  float vn, ty;  // rover velocity and torque
  
  Rover(){
    initiate();
    render();
  }
  
  void initiate(){
    ty = 0;
    ry = PI;
    px = width / 2;
    py = height * 3/4;
    pz = 0;
  }
  
  void update(){
    ty = map(mouseX, width, 0, -PI/24, PI/24);
    vn = map(mouseY, height, 0, -20, 55);
    if(vn >5)
      vn -=5;
    else if(vn<-5){
      vn +=5;
      ty = -ty;
    }
    else{
      ty= ty * vn / 5;
      vn = 0;
    }
    ry += ty;
    px += vn * sin(ry);
    pz += vn * cos(ry);  
    render();
  }
  
  void render(){

    noStroke();
    pushMatrix();
      translate (px, py, pz);
      rotateY(ry);
      scale(200);
      ambientLight(100, 100, 100);
      directionalLight(170,170,170, 0.0, 0, 1);
      directionalLight(170,170,170, 0.0, 1, 0);
      directionalLight(0,0,50, 1.0, 0.5, -0.5);
      directionalLight(0,0,50, -1.0, 0.5, -0.5);
      hull.drawMode(QUADS);
      hull.draw();
    popMatrix();
  }
}
