

class Monoflob{
  //Botao b[];
  BotaoAudio b[];
  int cores[];
  int gx,gy,num;
  float dimx,dimy;
  float sizex,sizey;//1.0 max
  
  Monoflob(int _gx, int _gy){
    gx = _gx;
    gy = _gy;
    sizex = 0.75;
    sizey = 1.0f;//0.55;
    float stridex = (float)width / (float)gx;
    float stridey = (float)height / (float)gy;
    dimx = stridex * sizex ;
    dimy = stridey * sizey ;
    
    num = gx * gy;    
    //b = new Botao[num];   
    b = new BotaoAudio[num];
    
    cores = new int[num];
    cores[0] = color (255);
    cores[1] = color (250,86,176);
    cores[2] = color (234,7,7);
    cores[3] = color (49,19,0);
    cores[4] = color (0,5,227);
    cores[5] = color (196,0,227);
    cores[6] = color (81,2,108);
    cores[7] = color (170,170,170);
    

    for(int i=0; i<num;i++){
      //RAIO DEPENDE DA ORDEM DOS BOTOES - 0 para 7 (varia entre 20 a width-40)
       float size = map(i,0,num-1, 125, 768);//i*(width-40)/(num-1) +200;
       
       //TODOS os botoes sao desenhados a partir do centro
       
       
       //float x =  ((float)(i % gx) +0.5) * stridex  ;
       //float y = ((float)(i / gx) +0.5) *stridey ;
       //b[i] = new Botao(i, x,y,dimx,dimy,cores[i] );  
       b[i] = new BotaoAudio(i, width/2, height/2, size, size, cores[i]);    
    }        
        
  }
  
  int touch(float x, float y,float w, float h){    
    int who = -1;
    
    for(int i=0; i<num; i++){
      
      if(b[i].test(x,y,w,h)){
        who = i;
        break;
      }    
    }
    
    return who;
  }

  void render(){
    println("render");
    for(int i=num-1; i>=0; i--)
        b[i].render();
    //for(int i=0; i<num; i++)
      //b[i].render();   
  }


}

