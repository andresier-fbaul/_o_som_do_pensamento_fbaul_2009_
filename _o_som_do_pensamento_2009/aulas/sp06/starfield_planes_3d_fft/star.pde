

class star{
  float x,y,z,s; 
  int fftband;
  float local_speed;
  
  star(){
    field();
  }  
  
  void field(){
    float w = width*10; 
    float h = height*10; 
    x = noise(millis())*w-w/2;
    y = noise(second()+random(1000))*h-h/2;
    z = noise(minute() +random(100))*-10000;
    s = noise(year()+random(22009))*10.;       
    fftband = (int) random(fft.specSize()); // uma banda aleatória
  }  

  void zz(){
    z = noise(minute() +random(100)) * -10000;      
  }

  void render(){

    if(z>500)
      zz();
    else
      line(x,y,z,x,y, z - local_speed*s);

    local_speed = fft.getBand(fftband) * 100.;
    z+=(s+local_speed);


  }
}
