class CheckPt{
  float x, z;  // checkpoint position
  float rad;  // checkpoint radius
  int nCircles;  // number of pulsing circles
  float phase[], inc[];  // weight[];  // circles' pulse phase and increment factor, line weight
  color col;  // checkpoint color

  CheckPt(){
    x = random(-5000, 5000);
    z = random(-5000, 5000);
    rad = 100;
    nCircles = 4;
    phase = new float[nCircles];
    inc = new float[nCircles];
    //    weight = new float[nCircles];
    for(int a=0;a<nCircles;a++){
      phase[a] = random (TWO_PI);
      inc[a] = random (0.02, 0.075);
      //      weight[a] = random(1, ceil(rad/25));
    }
  }

  void update(color in_col){
    for(int a=0; a<nCircles;a++)
      phase[a]+=inc[a]%TWO_PI;
    col = in_col;
    render();
  }

  void render(){
    pushMatrix();
      rotateX(PI/2);
      translate(0, 0, -rover.py-2);
      stroke(0,50);
      noFill();
      for(int a=0; a<nCircles; a++){
        strokeWeight(1);
        float rad1 = rad * 2.1 + rad * 0.35 *sin(phase[a]);
        ellipse(x, z, rad1, rad1);
      }
      stroke(col);
      translate(0,0,2);
      strokeWeight(4);
      ellipse(x, z, rad*2, rad*2);
    popMatrix(); 
  }
}



class CheckPoints{
  int nPts;  // number of checkpoints
  int currentPt;  // current checkpoint
  ArrayList checkPtsList;  // store the ckeckpoints
  color idle, active, trace;  // checkpoint colors

  CheckPoints(){
    nPts = 10;
    checkPtsList = new ArrayList();
    idle = color(0, 0, 255, 150);
    active = color(255, 0, 0, 150);
    trace = color(255, 0, 0, 50);
    initiate();
  }

  void initiate(){
    currentPt = 0;
    checkPtsList.clear();
    for(int a = 0; a<nPts; a++)
      checkPtsList.add(new CheckPt());
  }

  void update(){
    CheckPt checkPt = (CheckPt) checkPtsList.get(currentPt);
    float dn = dist(rover.px,rover.pz, checkPt.x,checkPt.z);
    if (dn < checkPt.rad){
      if (currentPt < nPts-1)
        currentPt ++;
      else
        terminate = true;
    }
    for(int a=0; a<nPts; a++){
      checkPt = (CheckPt) checkPtsList.get(a);
      if(a != currentPt)
        checkPt.update(idle);
    }
    checkPt = (CheckPt) checkPtsList.get(currentPt);
    checkPt.update(active);
  }
}

