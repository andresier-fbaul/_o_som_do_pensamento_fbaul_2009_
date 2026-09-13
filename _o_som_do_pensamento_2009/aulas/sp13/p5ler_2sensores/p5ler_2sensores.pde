/**
 * Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
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
    int lf = 9;//10;
    //Expand array size to the number of bytes you expect:
    byte[] inBuffer = new byte[3];
    myPort.readBytesUntil(lf, inBuffer);
    if (inBuffer != null) {
        
//test
//      int v1 = inBuffer[0];
//      int v2 = inBuffer[1];
//      String myString = ""+v1+" "+v2;//new String(inBuffer);
//      println(myString);
    }
  }

/*

  if ( myPort.available() > 0) {  // If data is available,  
    
    myPort.bufferUntil(9);
    int raw = (int)myPort.read(); 
 //   println(raw);
    if(raw==9) {
      which = 1;
      return;
    }

    if(which == 1)
      val0 = raw;
    if(which == 2)
      val1 = raw;

    which++;
 
  }
  
  */
  
    background(255);     // 
    fill(val0);              // 
    rect(50, 50, 100, 100);
    fill(val1);              // 
    rect(200, 50, 100, 100);

//  }

}



/*

 // Wiring / Arduino Code
 // Code for sensing a switch status and writing the value to the serial port.
 
 int switchPin = 4;                       // Switch connected to pin 4
 
 void setup() {
 pinMode(switchPin, INPUT);             // Set pin 0 as an input
 Serial.begin(9600);                    // Start serial communication at 9600 bps
 }
 
 void loop() {
 if (digitalRead(switchPin) == HIGH) {  // If switch is ON,
 Serial.print(1, BYTE);               // send 1 to Processing
 } else {                               // If the switch is not ON,
 Serial.print(0, BYTE);               // send 0 to Processing
 }
 delay(100);                            // Wait 100 milliseconds
 }
 
 */

