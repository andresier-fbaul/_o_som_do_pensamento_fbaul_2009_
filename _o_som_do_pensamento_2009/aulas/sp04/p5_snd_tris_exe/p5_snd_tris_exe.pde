

/*

  EXERCíCIO:
  
    realizar uma composição gráfica à base interactiva ao som     


*/




// import a library
import ddf.minim.*;

// um objecto da biblioteca
Minim minim;
// o objecto do input sonoro
AudioInput in;

// o valor do audio para ser passado por um filtro
float audio_energy;

// a array de triângulos
sndTri  tris[];



void setup(){

  size(700,700);

  minim = new Minim(this);
  minim.debugOn();

  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, 512);


  tris = new sndTri[10];
  for(int i=0; i<tris.length;i++){
     tris[i] = new sndTri(); 
  }

  background(0);
}



void draw(){
  //  background(0);
  fill(0,25);
  noStroke();
  rect(0,0,width,200); // só apaga até à posição 200 y


  stroke(255,150);

  // draw the waveforms
  for(int i = 0; i < in.bufferSize() - 1; i++){
    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }


  //   o valor da energia do som vai-se usar para escalar o raio do tri
  //   passado com um filtro lowpass para suavizar as transições

  float rms = in.mix.level();
  float f = 0.1;
  audio_energy = audio_energy * (1.-f) + rms * f;

 
   // renderizar todos os triangulos
 
   fill(255,150);
   stroke(0,100);
 
   for(int i=0; i<tris.length;i++){
     tris[i].update();
     tris[i].draw(); 
  }

 

}



void keyPressed(){
  if(key=='s')
    saveFrame("sndtri1-######.jpg"); 
}





