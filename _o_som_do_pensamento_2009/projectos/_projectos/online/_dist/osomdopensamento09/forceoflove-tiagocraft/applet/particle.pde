class Particle{
//identity
  int parent;
//physical and visual properties
  float energy, energy1;
  float px, py, vx, vy, friction;
  int rad, rad1, nCircles;
  color col;

  Particle(int in_parent, float in_px, float in_py, float in_energy){
    parent = in_parent;
    energy = energy1 = in_energy;
    float ang = random(0, TWO_PI);
    float sinAng = sin(ang);
    float cosAng = cos(ang);
    px = in_px+(emitters[parent].rad+rad)*sinAng;
    py = in_py+(emitters[parent].rad+rad)*cosAng;
    vx = random(3)*sinAng;
    vy = random(3)*cosAng;
    friction = 0.985;
    rad = rad1 = 10;
    col = color(100,150,255,70);
    nCircles = 2;
  }
  
  void update(){
    vx = constrain(vx, -width, width)*friction;
    vy = constrain(vy, -height, height)*friction;
    px += vx;
    py += vy;
    energy--;
    rad = round(norm(energy, 0, energy1)*rad1);
    render();
  }
  
  void render(){
    stroke(col);
    strokeWeight(2);
    fill(255,50);
    ellipse(px, py, rad*2, rad*2);
  }
}
