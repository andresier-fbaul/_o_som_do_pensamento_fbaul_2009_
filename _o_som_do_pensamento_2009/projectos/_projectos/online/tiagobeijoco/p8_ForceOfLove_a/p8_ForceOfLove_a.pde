// "ForceOfLove" by Tiago Craft. O Som do Pensamento, July 2009
/* this will be a second approach on a gravitatting particle system 
Porps go out to: Mother, for it's her BDay; Kiwik, for the enlightenment and feedback;
Anabela; AndréSier and JoaoHenrique, for the help*/

float startFilter;
int nEmitters, nParticles;  // number of emitters and particles per emitter
PFont font;
Emitter emitters[];  // array to store the emitters;

void setup(){
  import processing.opengl.*;
  size(1024, 576,OPENGL);
//  size(1024, 576);
  frameRate(60);
  startFilter= 300;
  nEmitters = 3;
  nParticles = 11;
  emitters = new Emitter[nEmitters];
  for(int a=0; a<nEmitters;a++)  // cast emitters into the array
    emitters[a] = new Emitter(a, nParticles, random(width), random(height));  // index, nParticles, px, py
  font = loadFont("AharoniBold-15.vlw");
}

void draw(){
  background(255);
  for (int a=0; a<nEmitters; a++){  //cycle every emitter
    // emitter-emiter physics()
    for(int b=a+1; b<nEmitters;b++){  // cycle following emitters
      float[][] physInVals = {{emitters[a].px, emitters[a].py, emitters[a].vx, emitters[a].vy, emitters[a].rad, emitters[a].mass},
                              {emitters[b].px, emitters[b].py, emitters[b].vx, emitters[b].vy, emitters[b].rad, emitters[b].mass}};
      float[] physOutVals = physics(physInVals, 0);
      emitters[a].vx = physOutVals[0]*0.01  +       emitters[a].vx * 0.99;
      emitters[a].vy = physOutVals[1]*0.01 +       emitters[a].vy * 0.99;
      emitters[b].vx = physOutVals[2]*0.01 +       emitters[b].vx * 0.99;
      emitters[b].vy = physOutVals[3]*0.01 +       emitters[b].vy * 0.99;
    }
    // emitter-particle physics()
    for(int b=0; b<nEmitters; b++){  // cycle every emitter
      for(int c=0; c<emitters[b].particles.size();c++){  // cycle every particle in every emitter
        Particle particle = (Particle) emitters[b].particles.get(c);
        float[][] physInVals = {{emitters[a].px, emitters[a].py, emitters[a].vx, emitters[a].vy, emitters[a].rad, emitters[a].mass},
                                {particle.px, particle.py, particle.vx, particle.vy, particle.rad, particle.mass}};
        float[] physOutVals = physics(physInVals, 0);
        emitters[a].vx = physOutVals[0];
        emitters[a].vy = physOutVals[1];
        particle.vx = physOutVals[2];
        particle.vy = physOutVals[3];
    }}
    for(int b=emitters[a].particles.size()-1; b>=0;b--){  // cycle every particle in emitter
      Particle particle1 = (Particle) emitters[a].particles.get(b);
stroke(0,8);
strokeWeight(1);
line(emitters[a].px,emitters[a].py, particle1.px, particle1.py);
      // particle - particle physics
      for(int c=b-1; c>=0; c--){  // cycle following particles in emitter
        Particle particle2 = (Particle) emitters[a].particles.get(c);
        float[][] physInVals = {{particle1.px, particle1.py, particle1.vx, particle1.vy, particle1.rad, particle1.mass},
                                {particle2.px, particle2.py, particle2.vx, particle2.vy, particle2.rad, particle2.mass}};
        float[] physOutVals = physics(physInVals, 2);
        particle1.vx = physOutVals[0];
        particle1.vy = physOutVals[1];
        particle2.vx = physOutVals[2];
        particle2.vy = physOutVals[3];
      }
      for(int c=a+1; c<nEmitters;c++){  // cycle following emitters
        for(int d=emitters[c].particles.size()-1; d>=0;d--){  // cycle every particle in following emitters
          Particle particle2 = (Particle) emitters[c].particles.get(d);
          float[][] physInVals = {{particle1.px, particle1.py, particle1.vx, particle1.vy, particle1.rad, particle1.mass},
                                  {particle2.px, particle2.py, particle2.vx, particle2.vy, particle2.rad, particle2.rad}};
          float[] physOutVals = physics(physInVals, 2);
          particle1.vx = physOutVals[0];
          particle1.vy = physOutVals[1];
          particle2.vx = physOutVals[2];
          particle2.vy = physOutVals[3];
    }}}
    emitters[a].update();
}}
