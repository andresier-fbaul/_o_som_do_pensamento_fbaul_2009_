PImage h[] = new PImage[8];
PImage m[] = new PImage[8]; // celula mask


void loadImages(){
 
  // retirado do exemplo Alphamask
  
 for(int i=1; i < 8; i++) {
   h[i] = loadImage("f.jpg");
   m[i] = loadImage("fm.jpg");
   h[i].mask(m[i]);
   //println("acabei de ler "+"humanmasks/h"+i+".jpg e sua máscara humanmasks/m"+i+".jpg");
 } 

  
}
