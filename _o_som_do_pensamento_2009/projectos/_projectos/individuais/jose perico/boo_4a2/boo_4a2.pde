import processing.opengl.*;
import processing.video.*;
import s373.flob.*;

Capture cam;

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

String file[] = { "movie1.mov", "movie2.mov", "movie3.mov", "movie4.mov", "movie5.mov", "movie6.mov", "movie7.mov", "movie8.mov", "movie9.mov"};
Movie mb[] = new Movie[file.length];
PImage img;
int movieindex = 0;

int botaoactivo=0, botaoanterior=100000; //logica de botões


//PFont font;

void setup() {
  
   try { quicktime.QTSession.open(); } 
  catch (quicktime.QTException qte) { qte.printStackTrace(); }
  
  
//  size(640, 480, P2D);
  size(1024, 768, OPENGL); //dimensões de projecção
  
  font = createFont("monaco",9);
  textFont(font);
  
  frameRate(fps);
  background(0);
  rectMode(CENTER);
   
  String[] devices = Capture.list();
  println(devices);

  
  video = new Capture(this, videores, videores,devices[5], (int)fps);
//   new Capture(this, width, height, devices[5]);
  
  for(int i=0; i<file.length; i++){
    mb[i] = new Movie(this,file[i]);
    mb[i].loop();
  }
  delay(1000);
    for(int i=0; i<file.length; i++){
    mb[i].stop();
  }
  
  mb[movieindex].play();
  img = mb[movieindex];
 


  
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
  
/*b1 = new Botao (80, 60, 60, 60 ,0);
b2 = new Botao (240, 60, 60, 60,0);
b3 = new Botao (400, 60, 60, 60, 0);
b4 = new Botao (560, 60, 60, 60,0);
b5 = new Botao (80, 180, 60, 60, 0);
b6 = new Botao (240, 180, 60, 60 ,0);
b7 = new Botao (400, 180, 60, 60,0);
b8 = new Botao (560, 180, 60, 60, 0);
b9 = new Botao (80, 300, 60, 60 ,0);
b10 = new Botao (240, 300, 60, 60,0);
b11 = new Botao (400, 300, 60, 60, 0);
b12 = new Botao (560, 300, 60, 60, 0);
b13 = new Botao (80, 420, 60, 60 ,0);
b14 = new Botao (240, 420, 60, 60,0);
b15 = new Botao (400, 420, 60, 60, 0);
b16 = new Botao (560, 420, 60, 60 ,0);
font = createFont("monaco",10);
textFont(font);
*/
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
    
  
  


  tint(255, 120);
  image(img,0,0,width,height);

 //write test image to frame
  if(drawimg)
    image(flob.videotex, 0, 0, width, height);

  //report presence graphically
  fill(255,152,255);
  rect(0,0,flob.getPresencef()*width,10);

  //get and use the data
  int numblobs = flob.getNumBlobs();  
  for(int i = 0; i < numblobs; i++) {
      ABlob ab = (ABlob) flob.getABlob(i);
      mono.touch(ab.cx,ab.cy, ab.dimx, ab.dimy);  

    //box
    fill(0,0,255,100);
    rect(ab.cx,ab.cy,ab.dimx,ab.dimy);
    //centroid
    fill(0,255,0,200);
    rect(ab.cx,ab.cy, 5, 5);
    info = ""+ab.id+" "+ab.cx+" "+ab.cy;
    text(info,ab.cx,ab.cy+20);
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
      mb[botaoactivo].loop();
      movieindex = botaoactivo;
       
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

    
}


