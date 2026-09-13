
PVector interp(PVector a, PVector b, float f){
    float f1 = 1.0f - f;
    PVector r = new PVector();
    r.x = a.x*f1 + b.x*f;
    r.y = a.y*f1 + b.y*f; 
    r.z = a.z*f1 + b.z*f;   
    return r;
}



class Aviao{

  PVector pos, vel, acc, rot;
  PVector ini, target;
  float t,dt=0.0151;
  int modo = (int)random(2); 

  Aviao(){
     constroi();
  }

  void constroi(){
     ini = pos = new PVector(  random(-50,1250), random(-250,250), random(-2550,-2000)     ); 
     target = new PVector(  random(0,550), height/2+100, random(550,1000)     ); 
     vel = new PVector();
     acc = new PVector();
     dt=random(0.001,0.00751);
  }
  
  void voa(){

    t+=dt;
    if(t>1.5){
      t=0;
      constroi();
    }
      
    PVector desired = interp(ini,target,t);
    vel.set(pos);
    pos = interp(pos,desired,0.05);           
    vel.sub(pos);
    vel.mult(-1);
    
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    //model.draw();
    fill(0,255,0);
    if(modo<1)
      modelboeing.draw();
    else
      modelf16.draw();
    popMatrix();
  }



}

