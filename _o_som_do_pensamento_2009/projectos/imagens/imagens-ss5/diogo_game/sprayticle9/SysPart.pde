class SysPart{

  Part  p[]; // a array de partículas
  
  ObsShape obsShape[];
  
  float cx,cy; // o centro

  float speed;
  float minAngle, maxAngle;
  float fx,fy; // uma força

  int lastFrameHits;
  
  float rad = 8;  
  float lowerThreshold = 0.09;
  float higherThreshold = 0.9;

  boolean noOneToShootNow;

  SysPart(int num, 
          float x, float y, 
          float speed, 
          float minAngle, float maxAngle, 
          float fx, float fy, 
          ObsShape[] obsShape){
    p = new Part[num];
    cx = x; 
    cy = y;
    
    this.speed=speed;
    this.minAngle=minAngle;
    this.maxAngle=maxAngle;
    
    this.fx=fx;
    this.fy=fy;
    
    for(int i=0; i<p.length;i++){
      p[i] = new Part(x,y, 0,0, 0,0, #ffffff); 
    }
    
    this.obsShape = obsShape;
    noOneToShootNow=false;
 }

  void setPos(float x, float y){
   cx = x;
   cy = y; 
  }

  void setPosForce(float x, float y, float afx, float afy){
   cx = x;
   cy = y; 
   fx = afx;
   fy = afy;
  }


  void update(float energy){
    
    lastFrameHits=0;

    int freeSlotIndex=-1;
    
// update and find a free slot:
    for(int i = 0; i < p.length; i++) {
      
      if(p[i].energy <= 0){
        freeSlotIndex=i;
        continue;
      }
        
      p[i].update();
      
      for(int o=0; o<obsShape.length; o++){
       
       if(obsShape[o].isCircleColliding(p[i].px, p[i].py, 1)){
         
         float dx,dy;
         if(p[i].vx != 0) 
           dx = p[i].vx/abs(p[i].vx);
         else dx = 0;
         
         if(p[i].vy != 0) 
           dy = p[i].vy/abs(p[i].vy);
         else
           dy = 0;
         obsShape[o].hit(dx,dy);
         
         if(!obsShape[o].isHorizontal()){
           p[i].vx=0;
           p[i].vy=random(-1,1);
         }
         else {
           p[i].vx=random(-1,1);
           p[i].vy=0;
         }
         
 // mix colors between rect and 'ticle
         color obsColor = obsShape[o].col;
         color ticleColor = p[i].col;
         
         obsShape[o].col = ticleColor;
/*         obsShape[o].col = color( (red(obsColor) + red(ticleColor)) / 2,
                                  (green(obsColor) + green(ticleColor)) / 2,
                                  (blue(obsColor) + blue(ticleColor)) / 2); */
                                  
         p[i].col=obsColor;
         
         if(obsShape[o].getState() <= 0)
           p[i].energy=-1;
         else
           p[i].energy-=1;
      
        lastFrameHits++;
        
       } // for obs
       
     }

    }

    if(noOneToShootNow)
      energy = lowerThreshold * random(1.05, 1.2); 
    

    if((energy > lowerThreshold) && 
       (freeSlotIndex >= 0)){ 
    
        float newSpeed = map(energy, lowerThreshold,higherThreshold, 0,speed);
        float newAngle = map(energy, lowerThreshold,higherThreshold, minAngle,maxAngle);
//        newAngle = max(newAngle,maxAngle*0.99);
        if(newAngle < min(minAngle,maxAngle))
          newAngle=min(minAngle,maxAngle);
        else
        if(newAngle > max(minAngle,maxAngle))
          newAngle=max(minAngle,maxAngle);
        
        p[freeSlotIndex].setPosVelForce(cx,cy, 
                            newSpeed*cos(newAngle), newSpeed*sin(newAngle), 
                            fx,fy); //novo centro, nova força
        p[freeSlotIndex].energy = 1000;
        
        color c = getHotPastel();
        p[freeSlotIndex].col = c;
        
//println("shot! angle:" + newAngle*180/PI + " speed: "+ newSpeed);        
//        float force = ( (frameCount*0.1) % 100);
//        p[i].make_rnd_normalized_velocity(random(force));//random(2,5));
    }

  }
  
  
  void draw(){

    for(int i = 0; i < p.length; i++) 
      p[i].draw();
      
      
      
    noStroke();
    fill(164);
    ellipse(cx, cy, rad, rad);
   
  }
  

}


