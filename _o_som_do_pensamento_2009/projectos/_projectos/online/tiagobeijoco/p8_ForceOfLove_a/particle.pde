class Particle{
//identity
  int parent;
//physical and visual properties
  float energy, energy1, mass;
  float px, py, vx, vy, friction;
  int rad, rad1, nCircles;
  color col;

  Particle(int in_parent, float in_px, float in_py, float in_energy){
    parent = in_parent;
    energy = energy1 = in_energy;
    rad = rad1 = 10;
    mass = 0.3* PI*sq(rad);  // mass = density*volume
    float ang = random(0, TWO_PI);
    float sinAng = sin(ang);
    float cosAng = cos(ang);
    px = in_px+(emitters[parent].rad+rad)*sinAng;
    py = in_py+(emitters[parent].rad+rad)*cosAng;
    vx = random(3)*sinAng;
    vy = random(3)*cosAng;
    friction = 0.92;
    col = color(7,47,230,160);
    nCircles = 2;
  }
  
  void update(){
    float terminalVelocity = height*.05;
    vx = constrain(vx, -terminalVelocity, terminalVelocity)*friction;
    vy = constrain(vy, -terminalVelocity, terminalVelocity)*friction;
    px += vx;
    py += vy;
    if(px>width) px = px-width;
    else if (px<0) px = width + px;
    if(py>height) py = py-height;
    else if(py<0) py = height+py;
    energy--;
    rad = round(norm(energy, 0, energy1)*rad1);
    render();
  }
  
  void render(){
    stroke(col);
    strokeWeight(2);
    fill(255,50);
    ellipse(px, py, rad*2, rad*2);
}}
