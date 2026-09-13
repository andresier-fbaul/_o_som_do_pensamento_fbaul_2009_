import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.*; 
import java.awt.image.*; 
import java.awt.event.*; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class p8_2_ForceOfLove extends PApplet {

// "ForceOfLove" by Tiago Craft. O Som do Pensamento, July 2009
/* this will be a second approach on a gravitatting particle system 
Porps go out to: Mother, for it's her BDay; Kiwik, for the enlightenment and feedback;
Anabela; And\u00e9Sier and JoaoHenrique, for the help*/

//import processing.opengl.*;

int nEmitters, nParticles;  // number of emitters and particles per emitter
Emitter emitters[];  // array to store the emitters;

public void setup(){
  size(1024, 576);
//  size(1024, 576,OPENGL);
  nEmitters = 10;
  nParticles = 5;
  emitters = new Emitter[nEmitters];
  for(int a=0; a<nEmitters;a++)  // cast emitters into the array
    emitters[a] = new Emitter(a, nParticles, random(width), random(height));  // index, nParticles, px, py
}

public void draw(){
  background(255);

  for (int a=0; a<nEmitters; a++){  //cycle every emitter
    for(int b=a+1; b<nEmitters;b++){  // cycle following emitters and apply emitter-emiter physics()
      float[][] physInVals = {{emitters[a].px, emitters[a].py, emitters[a].vx, emitters[a].vy, emitters[a].rad},
                              {emitters[b].px, emitters[b].py, emitters[b].vx, emitters[b].vy, emitters[b].rad}};
      float[] physOutVals = physics(physInVals);
      emitters[a].vx = physOutVals[0];
      emitters[a].vy = physOutVals[1];
      emitters[b].vx = physOutVals[2];
      emitters[b].vy = physOutVals[3];
    }/*
    for(int b=0; b<nEmitters; b++){  // cycle every emitter
      for(int c=0; c<emitters[b].particles.size();c++){  // cycle every particle and apply emitter-particle physics()
        Particle particle = (Particle) emitters[b].particles.get(c);
        float[][] physInVals = {{emitters[a].px, emitters[a].py, emitters[a].vx, emitters[a].vy, emitters[a].rad},
                                {particle.px, particle.py, particle.vx, particle.vy, particle.rad}};
        float[] physOutVals = physics(physInVals);
        emitters[a].vx = physOutVals[0];
        emitters[a].vy = physOutVals[1];
        particle.vx = physOutVals[2];
        particle.vy = physOutVals[3];
      }
    }
    for(int b=emitters[a].particles.size()-1; b>=0;b--){  // particle - particle physics
      Particle particle1 = (Particle) emitters[b].particles.get(b);
      for(int c=b-1; c>=0; c--){
        Particle particle2 = (Particle) emitters[a].particles.get(c);
        float[][] physInVals = {{particle1.px, particle1.py, particle1.vx, particle1.vy, particle1.rad},
                                {particle2.px, particle2.py, particle2.vx, particle2.vy, particle2.rad}};
        float[] physOutVals = physics(physInVals);
        particle1.vx = physOutVals[0];
        particle1.vy = physOutVals[1];
        particle2.vx = physOutVals[2];
        particle2.vy = physOutVals[3];
      }
      for(int c=a+1; c<nEmitters;c++){
        for(int d=emitters[c].particles.size()-1; d>=0;d--){
          Particle particle2 = (Particle) emitters[c].particles.get(d);
          float[][] physInVals = {{particle1.px, particle1.py, particle1.vx, particle1.vy, particle1.rad},
                                  {particle2.px, particle2.py, particle2.vx, particle2.vy, particle2.rad}};
          float[] physOutVals = physics(physInVals);
          particle1.vx = physOutVals[0];
          particle1.vy = physOutVals[1];
          particle2.vx = physOutVals[2];
          particle2.vy = physOutVals[3];
        }
      }
    }*/
    emitters[a].update();
  }
}

public float[] physics(float[][] input){
  // determine colision normal vector: d(dx,dy); determine distance between emitters: d
  float dx = input[0][0]-input[1][0];
  float dy = input[0][1]-input[1][1];
  float d2 = sq(dx) + sq(dy);
  float d = sqrt(d2);

  // apply gravity
    // fg(fgx,fgy) = Grav.Contant * (mass1*mass2)/sq(distance); mass = rad, so, 
    // density = 1/(PI*rad). smaller circles are denser. this is dupliciously effective
  float fg = 0.5f*input[0][4]*input[1][4]/d2;
  float fgx = fg*dx/d;
  float fgy = fg*dy/d;
  input[0][2] -= fgx; input[0][3] -= fgy;
  input[1][2] += fgx; input[1][3] += fgy;
/*
  //check for elastic colision
  if (d <= input[0][4]+input[1][4]){
    // get bodies' velocity in the colision normal and tangent; flip normal velocity and parse them back to the v(x,y)
    float d_rot = acos(dx/d);  // d(dx,dy) rotation
    float dn_rot = PI / 2 - d_rot;  // dn(dnx,dny) rotation
    for(int a=0;a<2; a++){
      float v = sqrt(sq(input[a][2])+sq(input[a][3]));  // linear velocity
      float dv_rot = acos(input[a][2]/v) - d_rot;  // v(vx,vy) rotation in (d,dn)
      float vd = -v * cos(dv_rot)-(0.5/input[a][4]);  // velocity along the colision normal
      float vdn = v * sin(dv_rot);  // velocity along the colision tangent
      input[a][2] = vd * cos(d_rot) + vdn * cos(dn_rot);
      input[a][3] = vd * sin(d_rot) + vdn * sin(dn_rot);
    }
  }*/
  float[] physVals = {input[0][2], input[0][3], input[1][2], input[1][3]};
  return physVals;
}
class Emitter{
  
//identity
  int index;
//physical and visual properties
  float px, py, vx, vy, friction;
  int rad, nCircles; int col;  // radius, nr. of pulsing circles, color
// children properties
  int timer, nParticles, energy;  //time between particle castings, nr. of child particles, particles maximum energy
  ArrayList particles;  // array of child particles
  
  Emitter(int in_index, int in_nParticles, float  in_px, float in_py){
    timer = 0;
    index = in_index;
    px = in_px;
    py = in_py;
    vx = vy = 0;
    friction = .9f;
    rad = 30;
    col = color(255, 50, 50, 80);
    nCircles = 4;
//    emitterShape = new PulsingCircle(rad, col, nCircles);
    energy = 400;
    nParticles = in_nParticles;
    particles = new ArrayList();
    }
  
  public void update(){
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
      particles.add(new Particle(index, px, py, random(energy*0.5f, energy)));
      timer = 25;
    }
  }
  
  public void render(){
    stroke(col);
    strokeWeight(2);
    fill(255,50);
    ellipse(px, py, rad*2, rad*2);
  }
}
class Particle{
//identity
  int parent;
//physical and visual properties
  float energy, energy1;
  float px, py, vx, vy, friction;
  int rad, rad1, nCircles;
  int col;

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
    friction = 0.985f;
    rad = rad1 = 10;
    col = color(100,150,255,70);
    nCircles = 2;
  }
  
  public void update(){
    vx = constrain(vx, -width, width)*friction;
    vy = constrain(vy, -height, height)*friction;
    px += vx;
    py += vy;
    energy--;
    rad = round(norm(energy, 0, energy1)*rad1);
    render();
  }
  
  public void render(){
    stroke(col);
    strokeWeight(2);
    fill(255,50);
    ellipse(px, py, rad*2, rad*2);
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#DCD9DF", "p8_2_ForceOfLove" });
  }
}
