
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

  Aviao(){
     ini = pos = new PVector(  random(-250,1500), random(-500,500), random(-550,200)     ); 
     target = new PVector(  random(0,550), height/2+100, random(550,1000)     ); 
     vel = new PVector();
     acc = new PVector();
  }
  
  void voa(){

    t+=dt;
    if(t>1)
      t=0;
      
    PVector desired = interp(ini,target,t);
    vel.set(pos);
    pos = interp(pos,desired,0.05);           
    vel.sub(pos);
    vel.mult(-1);
    
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    model.draw();
    popMatrix();
  }



}

