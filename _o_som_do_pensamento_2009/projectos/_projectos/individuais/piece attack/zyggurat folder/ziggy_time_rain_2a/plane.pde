float gravidade = 2.05;
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

  plane(){
    reset();
  }

  void reset(){
    initCoords();
    setImg();    
  }

  void initCoords(){
     w = width*10;//3
     h = 2000*10;
    x = random(-w,w);
    y = random(-h,-h/2);
    z = -5 + ((int)random(0,10)) * -2000;///random(-1000,-10);
    s = random(1,2.5)*10;//random(1,2.5)*25;///random(2,10)*10;//random(10,50);
    rx = random(-0.1,0.1);//random(TWO_PI);
    ry = random(-0.55,0.55);//random(TWO_PI);

    dimy = random(500,1000);//random(100,200);
    dimx = dimy *16./9.;    
    
    stalltime = (int)random(1000,5000);
    vx = 0;
    vy = s;
    vz = 0;
  }

  void setImg(){
    img = frames[(int)random(frames.length)];     
  }


  void render(){
    
    
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
    
    if(vy<-5)
      vy=-5;
    
    //update
    x+=vx;
    //vy+=s;
    y+=vy;

    if(x>w)
      x-=w*2;
    if(x<-w)
      x+=w*2;



//    y += s;


    if(y<-2500)
      y=-2500;

    if(y>2700){
      y=2700;
      stalltime--;
      if(stalltime<0)
        reset();
        
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


  void setAcc(float x, float y, float d){
    ax =x + random(-d,d);
    ay =y + random(-d,d);
    
  }


}


