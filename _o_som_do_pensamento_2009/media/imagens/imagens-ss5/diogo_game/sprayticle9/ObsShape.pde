class ObsShape {
  float left, top, right, bottom;
  color col;
  int lastHitFrameCount;

  int hitCount;
  boolean enabled;

  int dieHitCount = 600;  
  int warCollaboratorHitCount = 700;  
  
  int framesTillUp = (int)(fps * 2.5); // frames after a hit that it will move up
  
  
  ObsShape(float x1, float y1, float x2, float y2, color col){
    left=min(x1,x2);
    top=min(y1,y2);
    right=max(x1,x2);
    bottom=max(y1,y2);
    this.col=col;
    lastHitFrameCount = frameCount;    
    hitCount=0;
    enabled = true;
  }  

  boolean isCircleColliding(float cx, float cy, float rad){
    if(!enabled)
      return false;
    if((cx >= left-rad) && (cx < right+rad) &&
       (cy >= top-rad) && (cy < bottom+rad))
      return true;
    else
      return false;    
  } 

  boolean isHorizontal(){
    return abs(left-right) >= abs(top-bottom);
  }

  void move(float dx, float dy){
    if(!enabled)
      return;
    
    left+=dx;
    right+=dx;
    top+=dy;
    bottom+=dy;
    
    float w=right-left;
    float h=bottom-top;
    if(left < 0){
      right=w;
      left=0;
    }
    if(right > width){
      right=width;
      left=right-w;
    }
    if(top < 0){
      bottom=h;
      top=0;      
    }
    if(bottom > height){
      bottom=height;
      top=bottom-h;
    }
    
  }

  void hit(float dx, float dy){
    hitCount++;
    move(dx,dy);
    lastHitFrameCount = frameCount;
  }


  int getState(){
    if(!enabled)
      return 0;
    if(hitCount >= dieHitCount){
      if(hitCount >= warCollaboratorHitCount){ // zombie? no - collaborator
        return -1;
      }
      else { // just dead
        return 0;
     }
     
    }
    else { // alive and well
      return 1;
    }
    
  }
  
  void draw(){
    
    if(!enabled)
      return;

    int state = getState();
    
    if(state <= 0){
      if(state == -1){
        weHaveANewAlienCollaborator((right+left)/2, (bottom+top)/2);
        enabled=false;
        
/*        fill(32, 128);
        stroke(40, 128);    
        rect(left,top-(bottom-top)*7, right,bottom); */        
      }
      else {
        fill(64,200);
        stroke(80,200);    
        rect(left,top, right-left,bottom-top);
      }
      move(0,+1);
      
      if(frameCount - lastHitFrameCount >= framesTillUp){
        hitCount--;
        if(hitCount == dieHitCount)
          col = getColdPastel();
      }
      
     
    }
    else { // alive
      if(frameCount - lastHitFrameCount >= framesTillUp){
        move(0,-0.5);
      }

      fill(col);
      stroke(200);    
      rect(left,top, right-left,bottom-top);
    }

  }
} 



