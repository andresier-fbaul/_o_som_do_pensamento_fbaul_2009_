

class star{
  float x,y,z,s; 
  
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
    println("z "+z);
  }  

  void zz(){
    z = noise(minute() +random(100)) * -10000;      
  }

  void render(){

    if(z>1000)
      zz();
    else
      line(x,y,z,x,y, z - speed*s);

    z+=(s+speed);


  }
}
