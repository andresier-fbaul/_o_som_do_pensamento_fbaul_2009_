class Part{

  float px,py, ppx,ppy;
  float energy,energy_dec;
  float rad;

  float vx,vy; //vel
  float f; //friction

  float gravity; //gravidade, força no eixo dos y
  float fx,fy; //força nos eixos
  color col;
  int alphamax;
  int mode;

  float vertexx[];
  float vertexy[];
  //  int 


  Part(float x,float y){
    px = ppx = x;
    py = ppy = y;
    energy = 255.f; 
    energy_dec = random(10,25);// random(5,10);//random(10.9,20.);
    rad = random(10,50);
    make_rnd_normalized_velocity(50.);
    f = 0.9;
    gravity = 0.9;
    col = color( 232, random(100,152), 40); //reddishes
    alphamax = (int) random(10,150);
    mode = (int) random(2);

    if(mode==1){
      int n = (int)random(3,10);
      vertexx = new float[n];
      vertexy = new float[n];
      for(int i=0;i<vertexx.length;n++){
        vertexx[i] = random(-i*0.5,i*0.5);
        vertexy[i] = random(-i*0.7,i*0.7);
      }
    }

  }

  Part(float x,float y,color c){
    this(x,y);
    col = c;
  }


  void make_rnd_normalized_velocity(float force){
    vx = random(-1,1);
    vy = random(-1,1);
    //normalizar, dividir cada componente pelo comprimento do vector
    float len = sqrt(vx*vx+vy*vy);
    if(len>0.f){
      vx = vx / len;
      vy = vy / len; 
      vx *= force;
      vy *= force;
    }

  }

  void setPos(float x, float y){
    px = ppx = x;
    py = ppy = y; 
  }

  void setPosForce(float x, float y, float fx, float fy){
    px = ppx = x;
    py = ppy = y; 
    this.fx = fx;
    this.fy = fy;
  }

  void update(){
    //store pos
    ppx = px;
    ppy = py;

    float dx = mouseX - px;
    float dy = mouseY - py;
    float len = abs(dx)+abs(dy);
    if (len>0) {
      dx/=len;
      dy/=len;
      float ff = 0.5;//random(0.2,0.5);
      dx*=ff;
      dy*=ff;

      fx+=dx;
      fy+=dy;
    }



    //update velocity
    vy = vy + gravity ;
    vx = vx + fx;
    vy = vy + fy;
    //friction = vel * friction
    vx = vx * f;
    vy = vy * f;
    // position = pos + vel
    px = px + vx;
    py = py + vy;
    // energy
    energy = energy - energy_dec;
  }

  void draw(){
    //    stroke(col, (int)energy);

    if(mode==0) {
      int a = (int) constrain(energy,0,alphamax);//100);
      float s = map (a,0,alphamax,0.01,1.);
      strokeWeight(s);
      stroke(col, a);
      line(ppx,ppy,px,py);
    }
    else if(mode==1){

      rad+=0.01;
      pushMatrix();
      translate(px,py);
      rotate(rad);
      beginShape(POINTS);
      for(int i=0; i < vertexx.length;i++){
        vertex(vertexx[i],vertexy[i]); 
      }
      endShape();
      popMatrix();


    }



  }

}




