class plane {
  float x,y,z;
  float dim[] = new float[2];

  plane(){
    x = y = z = -1;
  } 

  void set(float x, float y, float z, float s0,float s1){
    this.x = x;
    this.y = y;
    this.z = z;
    dim[0] = s0;
    dim[1] = s1;
  }


  void render(){
    if(x==-1&&z==-1)
      return;

    pushMatrix();
    translate(x,y,z);
    beginShape();
    vertex(-dim[0],-dim[1]);
    vertex( dim[0],-dim[1]);
    vertex( dim[0], dim[1]);
    vertex(-dim[0], dim[1]);
    endShape(CLOSE);
    popMatrix();     

  }

}
