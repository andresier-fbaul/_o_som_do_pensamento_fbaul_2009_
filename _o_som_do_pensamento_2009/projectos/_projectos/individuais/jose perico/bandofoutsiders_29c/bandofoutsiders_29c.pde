import processing.opengl.*;
import processing.video.*;
import s373.flob.*;
import ddf.minim.*;


Capture video;
Flob flob;
ArrayList blobs;

int tresh = 10;
int fade = 50;//120
int om = 1;
int videores=128;
boolean drawimg=true;
String info="";
PFont font;
int videotex = 3;//0;
float fps = 30;//60

Monoflob mono;


Movie myMovie;
float movieDur;

// os filmes
String file[] = { "1.mov", "2.mov", "3.mov", "4.mov", "5.mov", "6.mov", "7.mov", "8.mov", "9.mov"};
Movie mb[] = new Movie[file.length];
// os sons
Minim minim;
String audiofile[] = { "1.aif", "2.aif", "3.aif", "4.aif", "5.aif", "6.aif", "7.aif", "8.aif", "9.aif"};
AudioPlayer ap[] = new AudioPlayer[audiofile.length];

PImage img;
int movieindex = 0;
int botaoactivo=0, botaoanterior=100000; //logica de botões


void setup() {
  
   try { quicktime.QTSession.open(); } 
  catch (quicktime.QTException qte) { qte.printStackTrace(); }
  
  
 // size(640, 480, P2D);
  size(1024, 768, OPENGL);//dimensoes de projecção
    minim = new Minim(this);//iniciar o audio
    
  font = createFont("monaco",9);
  textFont(font);
  
  frameRate(fps);
  background(0);
  rectMode(CENTER);
   
  String[] devices = Capture.list();
  println(devices);

    
  for(int i=0; i<file.length; i++){
    mb[i] = new Movie(this,file[i]);
    mb[i].loop();
    mb[i].pause();
  }
    
  
  delay(1000);
  for(int i=0; i<file.length; i++){
    mb[i].stop();
  }
  
  mb[movieindex].play();
  img = mb[movieindex];
 


  video = new Capture(this, videores, videores,devices[5], (int)fps);
//   new Capture(this, width, height, devices[5]);
  
  flob= new Flob(this, video, width, height);
  flob.setMirror(true,false);//mirrorX(true);
  flob.setTresh(tresh);
  
  flob.setBackground(video);
  flob.setOm(1);
  // Load and play the video in a loop
//  myMovie = new Movie(this, "bandofoutsiders.avi" );
//  myMovie.loop();
  //movieDur = myMovie.duration();
  
  mono = new Monoflob(3,3);


//  minim = new Minim(this);//iniciar o audio
  for(int i=0; i<audiofile.length; i++){
    ap[i] = minim.loadFile(audiofile[i]);///, 2048);
//    ap[i].rewind();
 //   ap[i].pause();
  }


}

void movieEvent(Movie movie) {
  if(mb[movieindex].available()){
    mb[movieindex].read();
    img = mb[movieindex];
  }
}

//void movieEvent(Movie myMovie) {
//  myMovie.read();
//   println("movie at: "+ myMovie.time());
//   
//}




void draw() {
  
  if(video.available()){
    video.read();
  
    flob.calc( flob.binarize(video) );
  }
    
  
  noCursor();
  
  if(frameCount<150){
       flob.setBackground(video);
}
   
  
 
// if(frameCount%30==0) {
//  float pos = constrain( map(mouseX,0,width,0.,1.), 0.,1.);
//  pos = pos * movieDur;
//  
//  myMovie.jump(pos);
//  
//  println("movie at: "+pos);
//   
// }
//  myMovie.read();
//if (myMovie!=null){
  tint(255, 120);
  image(img,0,0,width,height);
//}

 //write test image to frame
  if(drawimg)
    image(flob.videotex, 0, 0, width, height);
    
  

  //report presence graphically
//  fill(255,152,255);
//  rect(0,0,flob.getPresencef()*width,10);


  //get and use the data
  int numblobs = flob.getNumBlobs();
for(int i=0; i<numblobs; i++){
ABlob ab = (ABlob) flob.getABlob(i);
mono.touch(ab.cx,ab.cy,ab.dimx,ab.dimy);
  // or blobs.size() if using the local arraylist...

//  float center[] = new float[2];
//  float dim[] = new float[2];


//  for(int i = 0; i < numblobs; i++) {
//
//      ABlob ab = (ABlob) flob.getABlob(i);
//      mono.touch(ab.cx,ab.cy, ab.dimx, ab.dimy);  


    // desenhar as blobs
noStroke();
    //box
 //   fill(0,0,255,100);
    fill(255,10);
    rect(ab.cx,ab.cy,ab.dimx,ab.dimy);

    //centroid
    fill(255,25);
    rect(ab.cx,ab.cy, 5, 5);

  }
  
  
   mono.render();
   
   
   // depois de desenhar os botões, vamos ver qual é o q tem o valor mais elevado

  int botaomax = -1, valormax=3; // pelo menos 3 para activar um filme!!!

  for(int i=0; i<mono.num; i++) {

      if( mono.b[i].gain >= valormax) {

        valormax = mono.b[i].gain;
        botaomax = i;

        if(valormax >= 5)
          break; //sair no primeiro q tiver 100

      }

  }


  if( botaomax > -1) {
   //sabemos q há um botão q tem valor elevado

    if( botaoactivo !=  botaomax)  // se o botao activo nao for o max, torna-lo esse o activo
    {
      botaoanterior = botaoactivo;
      botaoactivo = botaomax;

      // dar as ordens de parar os filmes e começar outros

     mb[botaoanterior].stop();
     mb[botaoanterior].pause();
     mb[botaoactivo].loop();
     movieindex = botaoactivo;


     // dar as ordens de parar os audios e começar outros
     ap[botaoanterior].pause();
     ap[botaoactivo].loop();
     ap[botaoactivo].setGain(0); // 0 dbs = vol max, podes puxar mais se puseres 1, 2, 5, 10...

    }


  }

  
  
  
 /* b1.render();
  b2.render();
  b3.render();
  b4.render();
  b5.render();
  b6.render();
  b7.render();
  b8.render();
  b9.render();
  b10.render();
  b11.render();
  b12.render();
  b13.render();
  b14.render();
  b15.render();
  b16.render();
  
*/
  

}


void keyPressed(){
  if(key==' ') {
    mb[movieindex].stop();
    movieindex = (movieindex + 1 )%file.length;
    mb[movieindex].play();
  }
  if(key=='i')
    drawimg^=true;
  else if (key=='s')
    video.settings();
  else if(key=='t'){
    tresh-=2;
    flob.setTresh(tresh);
    println("video tresh: "+tresh);
  }
  else if(key=='T'){
    tresh+=2;
    flob.setTresh(tresh);
    println("video tresh: "+tresh);
  }  
  
  else
     flob.setBackground(video);
    //init_video_bg(); //any key sets new background to test against

    
}


/*
void stop(){
 
 for(int i=0;i<audiofile.length;i++)
   ap[i].close();
 minim.stop();
 super.stop(); 
  
}
*/
