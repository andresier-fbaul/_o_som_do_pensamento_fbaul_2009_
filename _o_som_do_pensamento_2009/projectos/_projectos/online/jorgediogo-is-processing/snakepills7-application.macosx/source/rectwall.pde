



class RectWall{

  float left,top,right,bottom;

  RectWall(float aleft, float atop, float aright, float abottom){
    left=aleft;
    top=atop;
    right=aright;
    bottom=abottom;
  } 

  void draw(){
    stroke(#808080);
    fill(#817452);      
    rect(left,top, right-left, bottom-top);
  }


  boolean inCollisionWithCircle(float cx, float cy, float rad){
    if((cx >= left-rad) && (cx < right+rad) &&
       (cy >= top-rad) && (cy < bottom+rad))
      return true;
    else
      return false;
  }
}




