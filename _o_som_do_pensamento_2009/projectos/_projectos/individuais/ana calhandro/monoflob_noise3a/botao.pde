class Botao {
  int id;
  float x, y, w, h,w2,h2;
  int coroff,coron;
  int gain; 
  boolean on = false;
  boolean touch = false;
  

  Botao(int i,  float _x, float _y, float _w , float _h , int c) {
    id = i;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    w2 = w*0.5f;
    h2 = h*0.5f;    
    coroff = color(255);
    coron = c;//color(255);2
    //println("--new botao "+i+" "+_x+" "+_y+" "+_w+" "+coron);
  } 


  boolean test(float _x, float _y, float dimx, float dimy) {
    float dx = x - _x;
    float dy = y - _y;
    if(abs(dx) <= (w2+dimx*0.25) && abs(dy) <= (h2+dimy*0.25)){
      gain++;  
      touch = true;
    }
    return touch;
  }

  void state(){
    if(touch)
      touch=false;
    else
      gain--;
      
     if(gain == 99) {
      on = false;
      gain = 49;
     }
      
    if(gain>50){
      gain = 100;
      on = true; 
    }
    /*
    if(gain<50)
      on = false;*/
    if(gain<0)
      gain=0;
  }
  
  void render(){
    state();
    noFill();
    int c0 = on ? coron : coroff;
  //  int c1 = on ? coroff : coron;
    //stroke(c0,map(gain,0,100,10,255));
    fill(c0,0);  
    stroke(41,41,41);  
    ellipse(x,y,w,h);
    fill(255);
    text(""+gain,x,y);
    text(""+id,x,y+h2-2);

//  void render(){
//    state();
//    //int c0 = on ? coron : coroff;
//  //  int c1 = on ? coroff : coron;
//  int c0 = coron;
//    stroke(41,41,41);
//    //tirar a cor dos botoes:
//    fill(c0,0/*map(gain,0,100,10,255)*/);    
//    ellipse(x,y,w,h);
//    fill(255);
//    text(""+gain,x,y);
//    text(""+id,x,y+50);
  }

}


