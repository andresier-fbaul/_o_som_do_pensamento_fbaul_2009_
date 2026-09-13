/*

 image traveller
 
 */


PImage img;

imgTraveller travellers[];


void setup(){
  size(700,700);
  img = loadImage("cloud_3cor.jpg");//loadImage("cloud_hole.jpg");//loadImage("cloud.jpg");loadImage("lava.jpg");
  background(140);
 // image(img,0,0);

  //init travellers
  travellers = new imgTraveller[100];
  for(int i=0; i<travellers.length;i++){
    travellers[i] = new imgTraveller(random(width),random(height));
  }

}



void draw(){
  for(int i=0; i<travellers.length;i++){
    travellers[i].draw();
  } 

  if(mousePressed){
    for(int i=0; i<travellers.length;i++){
      if(travellers[i].energy<0.){
        travellers[i] = new imgTraveller(mouseX,mouseY);
        break;
      }
    } 

  }

}

