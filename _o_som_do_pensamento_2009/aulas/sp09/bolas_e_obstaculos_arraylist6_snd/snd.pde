
import ddf.minim.*;

Minim minim;
AudioPlayer player[]; // array de vozes de sons
String files[] = {"snd1.aif","snd2.aif","snd3.aif" };
int playnum = 0;

void init_snd(){
//  Minim.start(this);
  minim = new Minim(this);
  player = new AudioPlayer[10];
  for(int i=0; i<player.length;i++){
  player[i] = minim.loadFile(  files[i%files.length]  ); 
    
  }
  
}

void play_snd(){

    player[playnum].rewind();  
    player[playnum].play();  
    
    playnum = (playnum+1) % player.length;
  
}

void stop(){
  for(int i=0; i<player.length;i++)
    player[i].close();
    
   super.stop();
  
}
