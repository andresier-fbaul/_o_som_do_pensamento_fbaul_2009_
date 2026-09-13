

class Monoflob{
  //Botao b[];
  //BotaoAudio b[];
  BotaoTxt b[];
  int gx,gy,num;
  float dimx,dimy;
  float sizex,sizey;//1.0 max
  
  Monoflob(int _gx, int _gy){
    gx = _gx;
    gy = _gy;
    sizex = 0.8;//0.75;
    sizey = 0.5;
    float stridex = (float)width*0.7 / (float)gx;//(float)width*0.5 / (float)gx;
    float stridey = (float)height*0.8 / (float)gy;//(float)height*0.5 / (float)gy;
    dimx = stridex * sizex ;
    dimy = stridey * sizey ;
    
    num = gx * gy;    
//    b = new BotaoAudio[num];
    b = new BotaoTxt[num];

    for(int i=0; i<num;i++){
       float x =  ((float)(i % gx) +1.5) * stridex +50 ;
       float y = ((float)(i / gx) +1.7) *stridey ;
       b[i] = new BotaoTxt(i, x,y,dimx,dimy);      
    }        
        
  }
  
  void touch(float x, float y,float w, float h){    
    for(int i=0; i<num; i++)
      b[i].test(x,y,w,h);    
  }

  void render(){

    
    for(int i=0; i<num; i++)
      b[i].render();   
  }


}

