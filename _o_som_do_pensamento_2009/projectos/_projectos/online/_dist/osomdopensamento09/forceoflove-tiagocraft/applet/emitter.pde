class Emitter{
  
//identity
  int index;
//physical and visual properties
  float px, py, vx, vy, friction;
  int rad, nCircles; color col;  // radius, nr. of pulsing circles, color
// children properties
  int timer, nParticles, energy;  //time between particle castings, nr. of child particles, particles maximum energy
  ArrayList particles;  // array of child particles
  
  Emitter(int in_index, int in_nParticles, float  in_px, float in_py){
    timer = 0;
    index = in_index;
    px = in_px;
    py = in_py;
    vx = vy = 0;
    friction = .9;
    rad = 30;
    col = color(255, 50, 50, 80);
    nCircles = 4;
//    emitterShape = new PulsingCircle(rad, col, nCircles);
    energy = 400;
    nParticles = in_nParticles;
    particles = new ArrayList();
    }
  
  void update(){
    //apply friction, update position, loop screen edges, render
    vx = constrain(vx, -width, width)*friction;
    vy = constrain(vy, -height, height)*friction;
    px += vx;
    py += vy;
    if(px>width) px = px-width;
    else if (px<0) px = width + px;
    if(py>height) py = py-height;
    else if(py<0) py = height+py;
    render();
       
    for(int a=particles.size()-1; a>=0; a--){
      Particle particle = (Particle) particles.get(a);
      if(particle.energy>0) particle.update();
      else particles.remove(a);
      timer--;
    }

    if(particles.size()<nParticles && timer<1){
      particles.add(new Particle(index, px, py, random(energy*0.5, energy)));
      timer = 25;
    }
  }
  
  void render(){
    stroke(col);
    strokeWeight(2);
    fill(255,50);
    ellipse(px, py, rad*2, rad*2);
  }
}
