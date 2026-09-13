class sndTri{

  // o centro do triângulo
  float px = 0, py = 300;
  // o tamanho do triangulo
  float rad=50;
  // a inclinação do triângulo
  float angulo;

  float speed;
  int mode; // 0 = no audio interaction; 1 = audio interaction

  sndTri(){
    mode = (int)random(2);
    speed = random(0.5,2.);
    rad = random(20,70);
  }

  void update(){

 //   if(mode==1)
       rad = map (audio_energy, 0. , 0.2 , 50, 250);
  
    if(mode==1)
      speed = map(audio_energy, 0., 0.2, 1.1, 15.);
 

//    if(mode==0)
//      angulo += 0.01;
//    else
      angulo += map(audio_energy, 0., 0.2, 0., 0.1);
   
    
  // a posição incrementa-se, qd chega ao fim da linha,
  // passa para a linha de baixo, qd passa da linha de baixo,
  // vem para o início, em loop


    px = px + speed;
    
    
    if(px > width){
      py = py + 100;
      px = 0;
      
      if(py > height)
        py = 300; //zero da posição y

    }


  }

  void draw(){

    pushMatrix();
    translate(px,py);
    rotate(angulo);
 //   scale(rad);
    
    beginShape();
//     vertex(0, -0);
//    vertex(rad/2, rad);
//    vertex(rad, rad);
    curveVertex(0, -rad);
    curveVertex(rad/2, rad);
    curveVertex(-rad/2, rad);
 
    curveVertex(0, -rad);
    curveVertex(rad/2, rad);
    curveVertex(-rad/2, rad);
 
    endShape();    
    
    popMatrix();
    
  }



}




