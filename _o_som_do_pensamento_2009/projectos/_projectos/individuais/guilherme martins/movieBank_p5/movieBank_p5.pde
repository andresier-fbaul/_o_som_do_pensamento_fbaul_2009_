// movie bank p5 // o som do pensamento 2009


import processing.video.*;


Movie m[] = new Movie[4];


String filelist[] = {
  "absges03-lissa320.mov",
  "absges07-d2<>320.mov",
  "absges10-trrclar320.mov",
  "absjau01-zoomtrr300.mov"
};

PImage video;
int videoindex = 0;

void setup(){
  size(640,480);

  for(int i=0; i<m.length; i++){
    m[i] = new Movie(this,filelist[i]);
    m[i].loop();
    println("read "+filelist[i]);
  }

  video = m[videoindex];

}


void movieEvent(Movie movie) {  
  if(m[videoindex].available()){
    m[videoindex].read();
    video = m[videoindex];
  }
}



void draw(){

  tint(255, 50); // arrasto podes por e tirar
  image(video,0,0,width,height);

}


void keyPressed(){
  if(key=='p'){
    videoindex = (videoindex + 1 ) % m.length;
  }

}


