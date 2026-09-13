import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 

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

public class p8_ForceOfLove_a extends PApplet {

// "ForceOfLove" by Tiago Craft. O Som do Pensamento, July 2009
/* this will be a second approach on a gravitatting particle system 
Porps go out to: Mother, for it's her BDay; Kiwik, for the enlightenment and feedback;
Anabela; Andr\u00e9Sier and JoaoHenrique, for the help*/

float startFilter;
int nEmitters, nParticles;  // number of emitters and particles per emitter
PFont font;
Emitter emitters[];  // array to store the emitters;

public void setup(){
  
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

public void draw(){
  background(255);
  for (int a=0; a<nEmitters; a++){  //cycle every emitter
    // emitter-emiter physics()
    for(int b=a+1; b<nEmitters;b++){  // cycle following emitters
      float[][] physInVals = {{emitters[a].px, emitters[a].py, emitters[a].vx, emitters[a].vy, emitters[a].rad, emitters[a].mass},
                              {emitters[b].px, emitters[b].py, emitters[b].vx, emitters[b].vy, emitters[b].rad, emitters[b].mass}};
      float[] physOutVals = physics(physInVals, 0);
      emitters[a].vx = physOutVals[0]*0.01f  +       emitters[a].vx * 0.99f;
      emitters[a].vy = physOutVals[1]*0.01f +       emitters[a].vy * 0.99f;
      emitters[b].vx = physOutVals[2]*0.01f +       emitters[b].vx * 0.99f;
      emitters[b].vy = physOutVals[3]*0.01f +       emitters[b].vy * 0.99f;
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
class Emitter{


//identity
  int index;
//physical and visual properties
  float mass;
  float px, py, vx, vy, friction;
  int rad, nCircles; int col;  // radius, nr. of pulsing circles, color
// children properties
  int timer, nParticles, energy;  //time between particle castings, nr. of child particles, particles maximum energy
  ArrayList particles;  // array of child particles
  
  Emitter(int in_index, int in_nParticles, float  in_px, float in_py){
    timer = 0;
    index = in_index;
    rad = 30;
    mass = 0.3f* PI*sq(rad);  // mass = density*volume
    px = in_px;
    py = in_py;
    vx = vy = 0;
    friction = .94f;
    nCircles = 4;
    col = color(240, 10, 10,220);
//    emitterShape = new PulsingCircle(rad, col, nCircles);
    energy = 250;
    nParticles = in_nParticles;
    particles = new ArrayList();
    }
  
  public void update(){
    //apply friction, update position, loop screen edges, render
    float terminalVelocity = height*.1f;
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
      particles.add(new Particle(index, px, py, random(energy*0.5f, energy)));
      timer = 20;
    }
  }
  
  public void render(){
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
class Particle{
//identity
  int parent;
//physical and visual properties
  float energy, energy1, mass;
  float px, py, vx, vy, friction;
  int rad, rad1, nCircles;
  int col;

  Particle(int in_parent, float in_px, float in_py, float in_energy){
    parent = in_parent;
    energy = energy1 = in_energy;
    rad = rad1 = 10;
    mass = 0.3f* PI*sq(rad);  // mass = density*volume
    float ang = random(0, TWO_PI);
    float sinAng = sin(ang);
    float cosAng = cos(ang);
    px = in_px+(emitters[parent].rad+rad)*sinAng;
    py = in_py+(emitters[parent].rad+rad)*cosAng;
    vx = random(3)*sinAng;
    vy = random(3)*cosAng;
    friction = 0.92f;
    col = color(7,47,230,160);
    nCircles = 2;
  }
  
  public void update(){
    float terminalVelocity = height*.05f;
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
  
  public void render(){
    stroke(col);
    strokeWeight(2);
    fill(255,50);
    ellipse(px, py, rad*2, rad*2);
}}
public float[] physics(float[][] input, int type){
  // determine colision normal vector: d(dx,dy); determine distance between emitters: d
  float dx = input[0][0]-input[1][0];
  float dy = input[0][1]-input[1][1];
  float d2 = sq(dx) + sq(dy);
  float d = sqrt(d2);

  // apply gravity
  if ((type == 0 || type == 2)&& d>0){ 
    float fg = 0.052f*input[0][5]*input[1][5]/d2;  // fg(fgx,fgy)=GravConst*(mass1*mass2)/sq(distance);
    float fgx = fg*dx/d;// * 0.25;
    float fgy = fg*dy/d;// *0.25;
    input[0][2] -= fgx/input[0][5]; input[0][3] -= fgy/input[0][5];
    input[1][2] += fgx/input[1][5]; input[1][3] += fgy/input[1][5];
  }

  //check for elastic colision
  if (type>0 && d <= input[0][4]+input[1][4] && d>0){
    // get bodies' velocity in the colision normal and tangent; 
    // apply spring to normal velocity and parse them back to the v(x,y)
    float d_rot = acos(dx/d);  // d(dx,dy) rotation
    float dn_rot = PI / 2 - d_rot;  // dn(dnx,dny) rotation
    for(int a=0;a<2; a++){
      float v = sqrt(sq(input[a][2])+sq(input[a][3]));  // linear velocity
      if (v>0){
        float dv_rot = acos(input[a][2]/v) - d_rot;  // v(vx,vy) rotation in (d,dn)
        float fd = -(0.00001f/input[a][4])*pow(input[0][4]*input[1][4]-d,1);  // spring normal repulsion.
        float vd = v * cos(dv_rot) + fd / input[a][5];  // velocity along the colision normal
        float vdn = v * sin(dv_rot);  // velocity along the colision tangent
        input[a][2] = vd * cos(d_rot) + vdn * cos(dn_rot);
        input[a][3] = vd * sin(d_rot) + vdn * sin(dn_rot);
  }}}

  float[] physVals = {input[0][2], input[0][3], input[1][2], input[1][3]};
  return physVals;
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#c0c0c0", "p8_ForceOfLove_a" });
  }
}
