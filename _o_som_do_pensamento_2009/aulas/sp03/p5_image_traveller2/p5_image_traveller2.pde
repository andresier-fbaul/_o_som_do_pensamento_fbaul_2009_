/*

 image traveller2
 
 agora nunca decai a energia...
 
 */


PImage img;

imgTraveller travellers[];
int numTravellers = 5; //500
int headTraveller=0;
boolean desenhar = true;


void setup(){
  size(700,700);
  img = loadImage("cloud_hole.jpg");//loadImage("lava.jpg");//loadImage("cloud_3cor.jpg");
  //loadImage("cloud_hole.jpg");//loadImage("cloud.jpg");loadImage("lava.jpg");
  background(140);
  // image(img,0,0);

  //init travellers
  travellers = new imgTraveller[numTravellers];
  for(int i=0; i<travellers.length;i++){
    travellers[i] = new imgTraveller(random(width),random(height));
  }

}



void draw(){

  if(desenhar)
    for(int i=0; i<travellers.length;i++){
      travellers[i].draw();
    } 

  if(mousePressed){
    travellers[headTraveller] = new imgTraveller(mouseX,mouseY);
    headTraveller = (headTraveller+1) % travellers.length;
  }

}


void keyPressed(){
  if(key=='d'){
    if(desenhar)
      desenhar=false;
    else
      desenhar = true;
  }
  
  if(key=='i')
   image(img,0,0);

  if(key==' ')
    background(140);

}


