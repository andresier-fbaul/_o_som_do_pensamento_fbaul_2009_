class sndTri{

  // o centro do triângulo
  float px = 0, py = 300;
  // o tamanho do triangulo
  float rad=50;
  // a inclinação do triângulo
  float angulo;

  float speed;
  int mode; // 0 = no audio interaction; 1 = audio interaction; 2 = py audio

  float speedmax,speedmin;
  float radmax,radmin;
  float angmax,angmin;

  color  cfill,cstroke;


  sndTri(){
    mode = (int)random(3);//2);
    speed = random(0.5,2.);
    rad = random(20,70);

    //color
    boolean c = (random(1)<0.5);
    cfill=(c)?color(255):color(0);
    cstroke=(c)?color(0):color(15);//(255);


    py = random(200,400);

    // mins e maxs para as escalas
    speedmax = random(0.1,5.0);
    speedmin = random(0.1,2.);
    radmax = random(5,500);
    radmin = random(5,30);
    angmax = random(1)<0.5? -random(0.001,0.7):random(0.001,0.7);
    angmin = random(-0.001,0.001);    
  }

  void update(){

    //   if(mode==1)
    rad = map (audio_energy, 0. , 0.2 , radmin,radmax);//50, 250);

    if(mode==1)
      speed = map(audio_energy, 0., 0.2, speedmin, speedmax);// 1.1, 15.);


    angulo += map(audio_energy, 0., 0.2, angmin, angmax);//-0.001, 0.3);


    // a posição incrementa-se, qd chega ao fim da linha,
    // passa para a linha de baixo, qd passa da linha de baixo,
    // vem para o início, em loop


    px = px + speed;

    // tem de passar para o draw, para não alterar o valor central de py
    //    if(mode==2)
    //      py += map(audio_energy,0.,0.2,0.,-1.);

    if(px > width){
      py = py + 100;
      px = 0;

      if(py > height)
        py = random(200,400);//300; //zero da posição y

    }


  }

  void draw(){

    fill(cfill,100);
    stroke(cstroke,100);

    pushMatrix();
    if(mode==2){
      float yoff = map(audio_energy,0.,0.2,100,-250);
      translate(px,py+yoff);    
    }else
      translate(px,py);
    rotate(angulo);

    beginShape();
    vertex(0, -rad);
    vertex(rad/2, rad);
    vertex(-rad/2, rad);
    endShape(CLOSE);    

    popMatrix();

  }



}





