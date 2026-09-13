
int retrigger = 20;

class Player{
 float px,py;//pos
 float vx,vy;//vel
 boolean fire = false;
 int firenow = 0;//frameCount;
 float angle;
 float diameter = 20;
 int life = 255;
 color maincolor = color((int)random(50,250));
  int  id;
 
 int score=0;
 
 Player( float p1, float p2, int id) {
  px = p1;
  py = p2;   
  this.id = id;
 }
 
 void setpos(float p1, float p2) {
  px = p1;
  py = p2;   
 }
 
 
 void go(){
    angle = atan2(vy,vx);
   
   if(fire){
    fire=false;
    firenow = frameCount+retrigger;
    //&&
    float lx = px + (diameter+2)*cos(angle);
    float ly = py + (diameter+2)*sin(angle);
    Fire f = new Fire(lx,ly,angle,id);//Fire(px,py,angle);
    firelist.add(f); 
   }
   
  px += vx;
  py += vy; 
  
  if(px>width)
    px -= width;
  if(px<0)
    px += width;
  if(py>height)
    py -= height;
  if(py<0)
    py += height;
   
 }
 
 
 void disfire(){
  // spwan fire from pos with angle
  
  firenow = frameCount+retrigger;
   
 }
 
 
 void render(){
  
   
  // angle = atan2(vy,vx);
   float l1 = px + 15*cos(angle);
   float l2 = py + 15*sin(angle);
   
   fill(maincolor,life);
   ellipse(px,py,diameter,diameter);
   line(px,py,l1,l2);
   
 }
 
 
  
}
