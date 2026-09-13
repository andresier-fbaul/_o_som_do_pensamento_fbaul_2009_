// o botao audio tem tudo o q o botao normal tem, 
// mas vai ter mais a parte de gerir audio

class BotaoAudio extends Botao{

  float vol;
  AudioPlayer  sndplayer;


  BotaoAudio(int i,  float _x, float _y, float _w , float _h, int _c){
    super(i,_x,_y,_w,_h, _c); //construtor botao normal
    //carregar audio, converter o id para nome do ficheiro
    sndplayer= minim.loadFile(audiofiles[i], 2048);
    sndplayer.pause();
    sndplayer.setGain(0);
  }



  boolean test(float _x, float _y, float dimx, float dimy) {
    float dx = x - _x;
    float dy = y - _y;
    
    float d = sqrt(dx*dx+dy*dy);
    
    if( d < ( w2 )) {     //abs(dx) <= (w2+dimx*0.25) && abs(dy) <= (h2+dimy*0.25)){
      gain++;  
      touch = true;
    }
    return touch;
  }


  // overloading state to handle sound here
  void state(){
  //   float newvol = map(gain, 0, 100, -100, 0);//map(gain, 0, 100, -50, 10); // os vols minim estão em dbs de -100 a 0
    float f = 0.12;//0.12; //lowpass para suavizar..
    //println("newvol="+newvol);
    if(touch && !sndplayer.isPlaying() && gain > 1) {
//      vol = 0;//newvol;//f*newvol+(1f-f)*vol;
//      sndplayer.setGain(vol);   //é só isto!
  //    println(vol);
    sndplayer.rewind();
      sndplayer.play();
      
    }
    
    if (!touch && !sndplayer.isPlaying() ) {
      sndplayer.rewind();
      sndplayer.pause();
      
      //estes if's definem o modo como o sons tocam: duração, play quando .. 
    }
    
       super.state();// first calc state from botao, then use vars to scale audio amp


  }

}

