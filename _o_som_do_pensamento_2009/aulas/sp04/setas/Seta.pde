
class Seta{

  // dados para a seta
  float px,py; // pos da seta
  float len=50;   // comprimento da seta
  float ang;   // angulo da seta

  Seta(){
    rePosSeta();
  }

  void render(){
    updateSeta();
    desenhaSeta(); 
  }




  void rePosSeta(){
    px = random(len,width-len);
    py = random(len,height-len); 
  }


  void updateSeta(){
    //ver o angulo da seta até ao rato (rato - seta)
    float dx = mouseX - px; 
    float dy = mouseY - py; 
    ang = atan2(dy,dx);

    if(mousePressed&&mouseButton==RIGHT)
      if(frameCount%5==0) //atrasar um pouco a resposta
        rePosSeta();

    if(mousePressed&&mouseButton==LEFT)
      andaSeta();

  }

  void desenhaSeta(){
    pushMatrix();
    translate(px,py);    //move a posição para o centro px, py
    rotate(ang);         //roda na pos actual ang radianos
    stroke(255,20);         // cor a branco
    //  rect(0,0,2,2);      // quadrado no centro da seta (reparem q a pos é 0,0 pois já estamos no centro)
    line(-len/2,0,len/2,0);  //corpo da seta
    //  line(len/3,10,len/2,0);  //braço1 da seta
    //  line(len/3,-10,len/2,0); //braço2 da seta
    popMatrix();

  }

  void andaSeta(){
    // a posição vai andar ao longo da direcção definida
    float walk = 0.5;
    px = px + cos(ang) * walk;
    py = py + sin(ang) * walk;
  }



}





