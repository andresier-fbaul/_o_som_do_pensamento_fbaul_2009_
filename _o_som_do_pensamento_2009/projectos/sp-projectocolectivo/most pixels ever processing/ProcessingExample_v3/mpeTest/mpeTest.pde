/**
 * Simple Bouncing Ball Demo
 * <http://code.google.com/p/mostpixelsever/>
 * @author Shiffman
 */
 
import mpe.client.*;


// The list of balls
ArrayList balls;

// A client object
UDPClient client;

// Stays false until all clients have connected
boolean start = false;


// This is triggered by the client whenever a new frame should be rendered
void frameEvent(UDPClient c){
  if (c.messageAvailable()) {
    String[] msg = c.getDataMessage();
    String[] xy = msg[0].split(",");
    float x = Integer.parseInt(xy[0]);
    float y = Integer.parseInt(xy[1]);
    balls.add(new Ball(x,y));
  }
  // Set to true for the first time we begin
  start = true;
  // Draw the next frame
  // redraw(); switched to loop()
  loop();
}


void setup() {
  // Make a new Client with an INI file.  
  // sketchPath() is used so that the INI file is local to the sketch
  client = new UDPClient(sketchPath("mpe.ini"),this);
  // The size is determined by the client's local width and height
  size(client.getLWidth(), client.getLHeight());
  // Always seed random numbers so that each client produces the same sequence
  randomSeed(1);
  
  // Start with 10 balls
  balls = new  ArrayList();
  for (int i = 0; i < 10; i++) {
    Ball ball= new Ball(random(client.getMWidth()),random(client.getMHeight()));
    balls.add(ball);
  }
  
  smooth();
  // IMPORTANT, MUST START THE CLIENT!
  client.start();
  // CRUCIAL, MUST STOP THE AUTOMATIC LOOPING OF PROCESSING!
  noLoop();
}


public void draw() {
  
  if (start) {
    // Before we do anything, the client must place itself within the larger display
    // (This is done with translate, so use push/pop if you want to overlay any info on all screens)
    client.placeScreen();
    // Do whatever it is you would normally do
    background(255);
    
    for (int i = 0; i < balls.size(); i++) {
      Ball ball = (Ball) balls.get(i);
      ball.calc();
      ball.display();
    }
    println("balls client 0 "+balls.size());
    // Alert the server that you've finished drawing a frame
    client.done();
  } 
  // Added since we are using loop() instead of redraw()
  noLoop();
}

public void mousePressed() {
  // How to broadcast a message
  // Do not include a ":" in your message
  int x = mouseX + client.getXoffset();
  int y = mouseY + client.getYoffset();
  client.broadcast(x + "," + y);
}

