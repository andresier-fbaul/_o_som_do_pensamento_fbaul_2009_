

PVector verts[];

void init_mesh(float dim){

  int numverts = 30;
  verts= new PVector[numverts];
  for(int i=0;i<verts.length;i++){
    verts[i]  = new PVector( random(-dim,dim), random(-dim,dim), random(-dim,dim));
  }

}


void draw_mesh(float x,float y, float z, float siz){
  pushMatrix(); 
  fill(255,100);
  translate(x,y,z);
  beginShape(TRIANGLES);
  for(int i=0;i<verts.length-2;i+=3){
    vertex(verts[i].x*siz,verts[i].y*siz,verts[i].z*siz);
    vertex(verts[i+1].x*siz,verts[i+1].y*siz,verts[i+1].z*siz);
    vertex(verts[i+2].x*siz,verts[i+2].y*siz,verts[i+2].z*siz);
//    vertex(verts[i].x,verts[i].y,verts[i].z);
//    vertex(verts[i+1].x,verts[i+1].y,verts[i+1].z);
//    vertex(verts[i+2].x,verts[i+2].y,verts[i+2].z);
  }
  endShape();
  popMatrix();
}


