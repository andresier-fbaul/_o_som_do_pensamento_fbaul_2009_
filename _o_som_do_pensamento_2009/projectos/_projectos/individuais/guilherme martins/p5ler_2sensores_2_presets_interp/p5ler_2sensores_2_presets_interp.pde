/**
  ler buffer serial até char 9 , os 2 primeiros bytes
  são usados a visualizar 4 rects
 */
import processing.serial.*;

Serial myPort;  // Create object from Serial class
// vars coming from the serialport / arduino 
int cotovelo_dir, ombro_dir, omoplata_dir, cotovelo_esq, ombro_esq, omoplata_esq, pescoco, cintura;

int val[] = new int[8];
int which=1;

Preset preset;

PFont font10;
int fontAlign = 150;


boolean fadepresets=false;
int p1 = 0;
int p2 = 5;
float presetcounter=0.f;


void setup() 
{
  size(600, 400);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  println(portName);
  myPort = new Serial(this, portName, 9600);
  frameRate(60);
  preset = new Preset();
  
  font10 = loadFont("FFF_Urban-15.vlw"); 

  textFont(font10);
}

void draw()
{
   while (myPort.available() > 0) {
    int lf = 10;
    //Expand array size to the number of bytes you expect:
    byte[] inBuffer = new byte[40];
    myPort.readBytesUntil(lf, inBuffer);
    if (inBuffer != null) {
        val[0] = cotovelo_dir = int(inBuffer[0]);
        val[1] = ombro_dir = int(inBuffer[1]);
        val[2] = omoplata_dir = int(inBuffer[2]);
        val[3] = cotovelo_esq = int(inBuffer[3]);
        val[4] = ombro_esq = int(inBuffer[4]);
        val[5] = omoplata_esq = int(inBuffer[5]);
        val[6] = pescoco = int(inBuffer[6]);
        val[7] = cintura = int(inBuffer[7]);
        
     }
  }
    background(255);    
    
    fill(20);
    stroke(0);
    
    float dx0 = map(cotovelo_dir, 0, 255, 0, 180);
    float dx1 = map(ombro_dir, 0, 255, 0, 180);
    float dx2 = map(omoplata_dir, 0, 255, 0, 180);
    float dx3 = map(cotovelo_esq, 0, 255, 0, 180);
    float dx4 = map(ombro_esq, 0, 255, 0, 180);
    float dx5 = map(omoplata_esq, 0, 255, 0, 180);
    float dx6 = map(pescoco, 0, 255, 0, 180);
    float dx7 = map(cintura, 0, 255, 0, 180);

    rect(fontAlign+50, 40, dx0, 25);
    rect(fontAlign+50, 70, dx1, 25);
    rect(fontAlign+50, 100, dx2, 25);
    rect(fontAlign+50, 130, dx3, 25);
    rect(fontAlign+50, 160, dx4, 25);
    rect(fontAlign+50, 190, dx5, 25);
    rect(fontAlign+50, 220, dx6, 25);
    rect(fontAlign+50, 250, dx7, 25);
    
    
  textFont(font10, 15); 

  text("cotovelo dir", 20, 60);
  text(cotovelo_dir, fontAlign, 60);

  text("ombro dir", 20, 90);
  text(ombro_dir, fontAlign, 90);

  text("omoplata dir", 20, 120);
  text(omoplata_dir, fontAlign, 120);

  text("cotovelo esq", 20, 150);
  text(cotovelo_esq, fontAlign, 150);
  
  text("ombro esq", 20, 180);
  text(ombro_esq, fontAlign, 180);
  
  text("omoplata esq", 20, 210);
  text(omoplata_esq, fontAlign, 210);
  
  text("pescoco", 20, 240);
  text(pescoco, fontAlign, 240);
  
  text("cintura", 20, 270);
  text(cintura, fontAlign, 270);
  
  
    text("preset "+p1+" "+p2+" "+presetcounter, 20, 350);
    
   if(fadepresets){

     preset.interpPresets(p1,p2,presetcounter);

     
     presetcounter+= 0.0101;
    
    if(presetcounter>1){
      
      fadepresets = false;
      presetcounter = 0;
      p1 = (int) random(preset.texto.length);
      p2 = (int) random(preset.texto.length);
    }
    
    
    
   } 
    
  
}

void keyPressed(){ 
 if(key=='w')
  preset.writePresets(); 
 if(key=='s')
  preset.addPreset(val); 
 if(key=='p')
  fadepresets=true;
  
}



