class sysPart{

  boolean active = false;
  
  float x,y;
  int c = (int)random(255);
  float life = 1;
  boolean exist = true; //esta boolean não está a funcionar
  int nblob = (int) random(0,10);
  // float life = 1;
  /// as part p   p ditas
  Part  p[];
  int nparts = 30;

  sysPart(){
    p = new Part[nparts];
    for(int i=0; i < nparts; i++) {
      p[i] = new Part(random(width),random(height)); //(width/2,height/2); 
    }

  }

  void update(float _x, float _y){

    exist = true;
  //  active = true;

    float f = 0.040;
    x = f * _x + (1f-f) * x;
    y = f * _y + (1f-f) * y;    
    life+=0.12;
    if(life>1)
      life=1.0f;


  }


  void drawtoSys(sysPart s, int numblobs){

    if(!s.active)//||!active)
      return;
    
    float dx = s.x -x;
    float dy = s.y - y;
    float d = sqrt(dx*dx+dy*dy);
    
    colorMode(HSB);
    
    strokeWeight(map(d/5,0,10,1,3));
    float h = constrain(  map(d,0,500,245,359) , 245, 359)    ; 

    println("distancia é "+d+" "+h);


    float ss = h;//map(d,0,100,245,359);
//    ss *=numblobs;
//    ss %= 255;
    fill(h,255.,255.);
    stroke(h, 255, 255);
    line (x,y, s.x, s.y);

    /*nao sei onde devo colocar isto:
     
     boolean exi st(){
     sysPart = true; 
     
     }
     */

  }


  void draw(){
    life-=0.12;
    if(life>1)
      life=1;
    
    exist = true;

    if(life<0){ 
      x=width/2;
      y=height/2;  
      life=0;
      exist = false;
    }



    fill ( /*c*/150, 150, 255 , life *15);
    noStroke();
    ellipse(x,y,150,150);
    
    
    active = false;

  }

}
