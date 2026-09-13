// pd processing communication via OSC
// som do pensamento 2009, andré sier


// net stuff; need to download and install in processing: oscp5
// pd stuff; need to download and install in processing: oscreceive, oscsend
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

/// vars required
float audio;
int b1,b2;

void setup(){
  size(500,300);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);
  /* write messages at port 12001 in self ip */
  myRemoteLocation = new NetAddress("127.0.0.1",12001);
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/audio")==true) {
    audio = theOscMessage.get(0).floatValue();
  }
  if(theOscMessage.checkAddrPattern("/b1")==true) {
    b1 = theOscMessage.get(0).intValue();
  }

  if(theOscMessage.checkAddrPattern("/b2")==true) {
    b2 = theOscMessage.get(0).intValue();
  }

}

void draw(){
  //  background(0);
  fill(0,100);
  noStroke(); 
  rect(0,0,width,height);

  float tamanho = 10 + map(audio,0.,1.,0,200);

  fill(255,155);
  ellipse(width/2,height/2,tamanho,tamanho);


  fill(125,255,0);
  ellipse(mouseX,mouseY,50,50);

  if(b1>0){
    int c = (int) random(255);
    fill(c);
    ellipse(random(width),random(height),random(10,25),random(10,25));    
  }


  if(b2>0){
    fill(random(255),random(255),random(255));
    ellipse(random(width),random(height),random(10,25),random(10,25));    
  }


    //send 3-4 osc messages
    OscMessage myMessage = new OscMessage("/x");
    myMessage.add(mouseX);
    oscP5.send(myMessage, myRemoteLocation); 
 
    myMessage = new OscMessage("/y");
    myMessage.add(mouseY);
    oscP5.send(myMessage, myRemoteLocation); 

    myMessage = new OscMessage("/mousePressed");
    myMessage.add(mousePressed);
    oscP5.send(myMessage, myRemoteLocation); 

  if(random(1)<0.1){
    myMessage = new OscMessage("/colide");
    myMessage.add("bang");
    oscP5.send(myMessage, myRemoteLocation); 
  }


}




