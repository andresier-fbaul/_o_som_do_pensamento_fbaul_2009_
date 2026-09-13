class Radar{
  float px, py, pz; // radar position
  PFont font;  // text font
  color idle, active;  // radar signal colors

  Radar(){
    font = loadFont("ArialMT-9.vlw");
    idle = checkPoints.idle;
    active = checkPoints.active;
  }

  void update(){
    px = cam.px;
    py = cam.py;
    pz = cam.pz;
    render();
  }

  void render(){
    pushMatrix();
      translate (px, py, pz);  // match to camera
      rotateY(cam.ry+PI);
      translate (-280,-100, -500);  // place on top left corner
      rotateZ(cam.ry+PI);  // orient to North
      
      stroke(200);  // radar layout
      strokeWeight(2);
      ellipse(0,0,50,50);
      fill(0);  // North indicator
      textFont(font, 5);
      text ("N", -2,-27);
  
      for (int a=0; a < checkPoints.nPts; a++){
        CheckPt checkPt = (CheckPt)checkPoints.checkPtsList.get(a);
        float dx = checkPt.x - rover.px;
        float dz = checkPt.z - rover.pz;
        float dn = sqrt(sq(dx)+sq(dz));
        dx /= dn;
        dz /= dn;
        dn = min(dn, 2500) / 100;
        dx *= dn;
        dz *= dn;
        noStroke();
        if(a != checkPoints.currentPt)        
          fill(idle);
        else
          fill(active);
        ellipse( dx, dz, 3, 3);
      }
    popMatrix();
  }
}

