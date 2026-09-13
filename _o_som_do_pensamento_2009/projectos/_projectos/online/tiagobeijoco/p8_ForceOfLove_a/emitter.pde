class Emitter{


//identity
  int index;
//physical and visual properties
  float mass;
  float px, py, vx, vy, friction;
  int rad, nCircles; color col;  // radius, nr. of pulsing circles, color
// children properties
  int timer, nParticles, energy;  //time between particle castings, nr. of child particles, particles maximum energy
  ArrayList particles;  // array of child particles
  
  Emitter(int in_index, int in_nParticles, float  in_px, float in_py){
    timer = 0;
    index = in_index;
    rad = 30;
    mass = 0.3* PI*sq(rad);  // mass = density*volume
    px = in_px;
    py = in_py;
    vx = vy = 0;
    friction = .94;
    nCircles = 4;
    col = color(240, 10, 10,220);
//    emitterShape = new PulsingCircle(rad, col, nCircles);
    energy = 250;
    nParticles = in_nParticles;
    particles = new ArrayList();
    }
  
  void update(){
    //apply friction, update position, loop screen edges, render
    float terminalVelocity = height*.1;
    vx = constrain(vx, -terminalVelocity, terminalVelocity)*friction;
    vy = constrain(vy, -terminalVelocity, terminalVelocity)*friction;
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
      timer = 20;
    }
  }
  
  void render(){
    stroke(col);
    strokeWeight(2);
    fill(255,150);
    ellipse(px, py, rad*2, rad*2);
    fill(col);
    textFont(font,15);
    textAlign(CENTER);
    text(index, px,py);
  }
}
