class Cam{
  float ry, px, py, pz;  // camera rotation and position
  float cx, cy, cz, upV;  // camera direction and upVector
  float camDelay;  // camera rotation delay

    Cam(){
    camDelay = 0.05;
    perspective(PI/4, 1.6, 50, 2000000000);
    initiate();
  }

  void initiate(){
    ry = PI;
    px = width/2;
    py = height/2;
    pz = 1500;
    upV = 1;
    cx = px;
    cy = rover.py;
    cz = 0;
    camera(px, py,pz, cx, cy, cz, 0,upV, 0);
  }

  void update(){
    ry = ry * (1-camDelay) + rover.ry * camDelay;
    px = rover.px - 1500 * sin(ry);
    pz = rover.pz - 1500 * cos(ry);
    cx = rover.px;
    cz = rover.pz;
    camera(px, py, pz, cx, cy, cz, 0, upV, 0);
  }

  void zoomOut(){

    float midX, midZ; // center of the traced path
    float sizeX, sizeZ;  // size of the traced path
    float maxSide, elevation;  // major side of the traced area, camera elevation

    midX = (path.maxX + path.minX) / 2;
    midZ = (path.maxZ + path.minZ) / 2;
    sizeX = path.maxX - path.minX;
    sizeZ = path.maxZ - path.minZ;

    if (sizeX/sizeZ > width/height)
      maxSide = sizeX;
    else
      maxSide = sizeZ;

    elevation = - maxSide * 1.5;

    if(py > elevation*0.99 ){
      px = px * 0.95 + midX * 0.05;
      py = py * 0.95 + elevation * 0.05;
      pz = pz * 0.95 + midZ * 0.05;
      upV *= 0.95;
      cx = px;
      cz = pz;
    }
    camera(px, py, pz, cx, cy, cz, 0, upV, 1 - upV);
  }
}



