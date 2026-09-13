/**
  ler buffer serial até char 9 , os 2 primeiros bytes
  são usados a visualizar 4 rects
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val0, val1;
int which=1;

void setup() 
{
  size(400, 200);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  println(portName);
  myPort = new Serial(this, portName, 9600);
  frameRate(60);
}

void draw()
{

       
   while (myPort.available() > 0) {
    int lf = 10;//9;//10;
    //Expand array size to the number of bytes you expect:
    byte[] inBuffer = new byte[7];
    myPort.readBytesUntil(lf, inBuffer);
    if (inBuffer != null) {
        val0 = int(inBuffer[0]);
        val1 = int(inBuffer[1]);
//test
//      int v1 = inBuffer[0];
//      int v2 = inBuffer[1];
//      String myString = ""+v1+" "+v2;//new String(inBuffer);
//      println(myString);
    }
  }
  
  
    background(255);     
    fill(val0);              
    rect(100, 70, 100, 100);
    fill(val1);              
    rect(230, 70, 100, 100);

    fill(20);
    stroke(0);
    float dx0 = map(val0,0,255,0,width);
    float dx1 = map(val1,0,255,0,width);
    rect(0,5,dx0,15);
    rect(0,25,dx1,15);


}




