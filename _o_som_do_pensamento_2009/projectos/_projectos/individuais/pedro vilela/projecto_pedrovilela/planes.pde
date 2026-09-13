

class plane{
  float x,y,z,s;
  float dimx=100;
  float dimy=50;
  float dir = (random(1)<0.5? -1f : 1f);

  plane(){
    field();
  }  
  void field(){
    float w = width*10; 
    float h = height*10; 
    x = random(w)-w/2;
    y = random(h)-h/2;
    z = -10000;
    //z = noise(minute() +random(100))*-10000;
    s = noise(year()+random(22009))*10.;   
 //   println("z "+z);
// println(dir);
  }  

  void zz(){
    z = random(0,-20000);
  }

  void render(){

    if(z>5000)
      z = -20000;
      
    if(z<-20000)
       z = 500;
      //zz();
      
     {

      pushMatrix();
      translate(x,y,z);
      beginShape();
      vertex(-dimx,-dimy);
      vertex( dimx,-dimy);
      vertex( dimx, dimy);
      vertex(-dimx, dimy);
      endShape(CLOSE);
      popMatrix();     
      // line(x,y,z,x,y, z - speed*s);
    }

//    z += ((s+speed) * dir);
    z  = z + ((s+speed) * dir);

  }
}

