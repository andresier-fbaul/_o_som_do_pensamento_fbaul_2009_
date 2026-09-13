import processing.serial.*;

Serial myPort;

void setup(){
  size(300,300);
  background(100);
  myPort = new Serial(this, Serial.list()[1], 9600); // no meu pc é a com4
}

void draw(){
  while (myPort.available() > 0) {
    int lf = 10;
    byte[] inBuffer = new byte[4];//7
    myPort.readBytesUntil(lf, inBuffer);
    if (inBuffer != null){
      int pot_values = inBuffer[0]+inBuffer[1]+inBuffer[2];
//      int ldr_values = inBuffer[4]+inBuffer[5]+inBuffer[6];
      background(pot_values);
//      fill(ldr_values);
//      rect(75,75,150,150);
    }
  }
}

