class Pt{
  float x, z;
  boolean trace;  // line continuity

  Pt(float in_x, float in_z, boolean in_trace){
    x = in_x;
    z = in_z;
    trace = in_trace;
  }
}



class Path{

  float minX, minZ, maxX, maxZ;  // minimum and maximum points sampled
  ArrayList points;  // stores path points
  int maxSize;  // maximum points on path
  float spacing;  // minimum distance between adjacent points
  float ink;  // path line greyscale color
  boolean start, trace;  // drawing started indicator, drawing trigger

  Path(){
    points = new ArrayList();
    maxSize = 10000;
    spacing = 3;
    minX = minZ = maxX = maxZ = 0;
    initiate();
  }

  void initiate(){
    ink = 230;
    points.clear();
    points.add(new Pt(rover.px, rover.pz, false));
    start = trace = false;
  }

  void update(){
    Pt pt = new Pt(rover.px, rover.pz, trace);
    Pt ptN = (Pt) points.get(points.size()-1);
    float dn = dist(pt.x,pt.z,ptN.x,ptN.z);  // check distance to last point
    if (dn>spacing && trace){  // store point if distance > spacing and trace is active
      minX = min(pt.x, minX);
      minZ = min(pt.z, minZ);
      maxX = max(pt.x, maxX);
      maxZ = max(pt.z, maxZ);
      if(points.size()>=maxSize)
        points.remove(0);
      points.add(pt);
    }
    render();
  }

  void zoomOut(){
    ink = ink *.95 + 100 * 0.05;
    render();
  }

  void render(){
    for(int a = 0; a < points.size()-1; a++){
      Pt pt1 = (Pt) points.get(a);
      Pt pt2 = (Pt) points.get(a+1);
      stroke(ink);
      strokeWeight(2);
      if (pt1.trace)
        line(pt1.x, rover.py + 5, pt1.z, pt2.x, rover.py + 5, pt2.z);
    }
  }
}

