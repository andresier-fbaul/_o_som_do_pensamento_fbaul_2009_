// "ForceOfLove" by Tiago Craft. O Som do Pensamento, July 2009
/* this will be a second approach on a gravitatting particle system 
Porps go out to: Mother, for it's her BDay; Kiwik, for the enlightenment and feedback;
Anabela; AndéSier and JoaoHenrique, for the help*/

//import processing.opengl.*;

int nEmitters, nParticles;  // number of emitters and particles per emitter
Emitter emitters[];  // array to store the emitters;

void setup(){
  size(1024, 576);
//  size(1024, 576,OPENGL);
  nEmitters = 10;
  nParticles = 5;
  emitters = new Emitter[nEmitters];
  for(int a=0; a<nEmitters;a++)  // cast emitters into the array
    emitters[a] = new Emitter(a, nParticles, random(width), random(height));  // index, nParticles, px, py
}

void draw(){
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

float[] physics(float[][] input){
  // determine colision normal vector: d(dx,dy); determine distance between emitters: d
  float dx = input[0][0]-input[1][0];
  float dy = input[0][1]-input[1][1];
  float d2 = sq(dx) + sq(dy);
  float d = sqrt(d2);

  // apply gravity
    // fg(fgx,fgy) = Grav.Contant * (mass1*mass2)/sq(distance); mass = rad, so, 
    // density = 1/(PI*rad). smaller circles are denser. this is dupliciously effective
  float fg = 0.5*input[0][4]*input[1][4]/d2;
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
