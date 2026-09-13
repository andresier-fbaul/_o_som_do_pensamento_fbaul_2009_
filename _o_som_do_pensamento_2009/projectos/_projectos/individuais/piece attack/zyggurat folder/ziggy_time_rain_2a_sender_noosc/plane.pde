float gravidade = 20.05;//2.05;
float friccao = 0.972;


class plane{
  float x,y,z,s; //pos e vel
  float w,h;
  float vx,vy,vz;
  float ax,ay,az;
  float rx,ry;
  float dimx,dimy; 
  PImage img;

  int stalltime; 
  int om = random(1)<0.25?1:0;
  
  boolean respawn = false;//true;
  boolean active = false;//true;

  plane(){
  //  println(om);
    reset();
  }

  void reset(){
    initCoords();
    setImg();    
  }

  void initCoords(){
     w = width*5;//width*10;//3
     h = 12000;//2000*10;
    x = random(-w,w);
    y = random(-h,-h/2);
    z = -5 + ((int)random(0,10)) * -2000;///random(-1000,-10);
    s = random(1,2.5)*10;//random(1,2.5)*25;///random(2,10)*10;//random(10,50);
    rx = random(-0.1,0.1);//random(TWO_PI);
    ry = random(-0.55,0.55);//random(TWO_PI);

    dimy = random(500,1000);//random(100,200);
    dimx = dimy *16./9.;    
    
    stalltime = (int)random(250,5000);//(int)random(1000,5000);
    vx = 0;
    vy = s;
    vz = 0;
  }

  void setImg(){
    img = frames[(int)random(frames.length)];     
  }


  void render(){
    
    if(!active)
      return;
    
    vx +=ax;
    vy +=ay;
    vy +=gravidade;
    vx*=friccao;
    vy*=friccao;
    ax = ay = az = 0;
    
    if(abs(vx)>100)
      if(vx>0)
        vx=100;
      else
        vx=-100;
    
//    if(vy<-5)
//      vy=-5;
    
    //update
    x+=vx;
    //vy+=s;
    y+=vy;

    if(x>w)
      x-=w*2;
    if(x<-w)
      x+=w*2;



//    y += s;


    if(y<-3500)
      y=-3500;

    if(y>2700){
      y=2700;
      if(om>=0){
        vy = -vy;
        vy*=friccao;//0.9;
      }
      stalltime--;
      if(stalltime<0){
        sendnetwork();
        if(respawn)
          reset();
        else
          active=false;
      }
        
    }

    //draw
    noStroke();
    tint(255,25);
    pushMatrix();
    translate(x,y,z);
    rotateX(rx);
    rotateY(ry);
    beginShape();
    texture(img);
    vertex(-dimx,-dimy,0,0);
    vertex( dimx,-dimy,img.width,0);
    vertex( dimx, dimy,img.width,img.height);
    vertex(-dimx, dimy,0,img.height);
//   vertex(-dimx,-dimy);
//    vertex( dimx,-dimy);
//    vertex( dimx, dimy);
//    vertex(-dimx, dimy);
    endShape(CLOSE);
    
    stroke(255,5);
    translate(0,2700-y,0);
    beginShape(LINES);
 //   texture(img);
vertex(-dimx,dimy);
vertex( dimx,dimy);

    endShape();

    popMatrix();     



  }

 void setAcc( float d){
   
   float velox = om > 0 ? globalvx : globalvelx;
   float veloy = om > 0 ? globalvy : globalvely;
 //  veloy =  -1*abs(y);
   
    ax =velox + random(-d,d);
    ay =veloy + random(-d,d*0.1);
    
  }

  void setAcc(float x, float y, float d){
    
    if(om<1) {
    ax =x + random(-d,d);
    ay =y + random(-d,d);
    } else{
     ax = x + random(-d,d);
    ay = -1*abs(y) + random(-d,d); 
    }
    
    
  }
  void setAccUp(float x, float y, float d){
    ax =x + random(-d,d);
    ay =-1*abs(y) + random(-d,0);//d*0.1);
    if(om==0)
      ay*=5;
    
  }



  void generate(float data[]){
    x = data[0];
    y = random(-h,-h/2);
    z = data[2];//-5 + ((int)random(0,10)) * -2000;///random(-1000,-10);
    s = random(1,2.5)*10;//random(1,2.5)*25;///random(2,10)*10;//random(10,50);
    rx = data[5];//random(-0.1,0.1);//random(TWO_PI);
    ry = data[6];//random(-0.55,0.55);//random(TWO_PI);

    dimx = data[3];//random(500,1000);//random(100,200);
    dimy = data[4];//dimy *16./9.;    
    
    stalltime = (int)random(250,5000);//(int)random(1000,5000);
    vx = 0;
    vy = s;
    vz = 0;
    
    active = true;
    respawn = false;
    
  }

  void sendnetwork(){
    float data[] = new float[7];
    data[0] = x;
    data[1] = y;
    data[2] = z;
    data[3] = dimx;
    data[4] = dimy;
    data[5] = rx;
    data[6] = ry;
    
//    OscMessage sms = new OscMessage("/");
//    sms.add(data);
 //   println("--sending to nwt "+data);
//    oscP5.send(sms, netziggy7);
//    oscP5.send(sms, netziggy3);
//    oscP5.send(sms, netself);
//    oscP5.send(sms, netziggy7);
  }


}


