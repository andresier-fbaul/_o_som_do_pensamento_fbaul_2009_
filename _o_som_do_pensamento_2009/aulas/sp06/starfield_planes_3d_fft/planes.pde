

class plane{
  float x,y,z,s;
  float dimx=100;
  float dimy=50;
  int fftband;
  float local_speed;
  

  plane(){
    field();
  }  
  void field(){
    float w = width*10; 
    float h = height*10; 
    x = random(w)-w/2;
    y = random(h)-h/2;
    z = -10000;
    s = noise(year()+random(22009))*10.;   
    fftband = (int) random(fft.specSize()); // uma banda aleatória
  }  

  void zz(){
    z = -10000;
  }

  void render(){

    if(z>500)
      zz();
    else {

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


    local_speed = fft.getBand(fftband) * 100.;
    z+=(s+local_speed);


  }
}

