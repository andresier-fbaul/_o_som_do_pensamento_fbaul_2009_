/*

 exercício com os image travellers
 
 1. escolher cores de fundo e dos travellers
 2. mudar o comportamento dos travellers de maneira a obterem reações diferentes
 3. gravar umas imagens e escolher 1 ou 2
 
 */


PImage img;

imgTraveller travellers[];
int numTravellers = 50; //500
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
  
  fill(140,2);
  noStroke();
  rect(0,0,width,height);

  if(desenhar)
    for(int i=0; i<travellers.length;i++){
      travellers[i].draw();
    } 


  if(desenhar)
   for(int i=0; i<travellers.length;i++){
      if(travellers[i].energy<0.){
        travellers[i] = new imgTraveller(random(width),random(height));
        break;
      }
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
    
  if(key=='s')
    saveFrame("imageTraveller3-#######.jpg");

}


