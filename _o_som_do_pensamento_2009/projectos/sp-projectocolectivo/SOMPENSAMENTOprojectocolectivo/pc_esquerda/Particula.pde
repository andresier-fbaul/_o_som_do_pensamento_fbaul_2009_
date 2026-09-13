

/// a class que vocês podem extender

class Particula {

  float x,y,z; //posição (quem quiser não usa o z, quem quiser usa)
  float velx, vely, velz;
  float accx, accy, accz;

  float rad;
  float life; // 0 a 255

  // sempre que se cria uma particula, precisa de uma posição
  Particula(float _x, float _y){
    this(_x,_y,0.0f);   
  }  

  Particula(float _x, float _y, float _z){
    x = _x; 
    y = _y; 
    z = _z;
    velx=vely=velz=0.0f;
    accx=accy=accz=0.0f;
    rad = 52;
    life = 255;
  }


  boolean checkSendNet(){
    // ESTE é o método que tem de ficar; 
    // testa as bounds x e poe a zero e envia por rede se coiso e tal
    boolean send = false;


    if (  x < 0) { // simple bounce   
      x = 0;
      velx = -velx * 0.971; 
      send = false;  
    }

    if (  x > width) { // enviar rede 

      send = true;  
    }



    if(send){
      float data[] = new float[7];
      data[0] = x;
      data[1] = y;
      data[2] = z;
      data[3] = velx;
      data[4] = vely;
      data[5] = velz;
      data[6] = life;

      // send
      boolean side = x < 0;
      String sendstr = side ? particula2left : particula2right;
      NetAddress myRemoteLocation = side ? esquerda : direita;
      OscMessage myMessage = new OscMessage(sendstr);
      myMessage.add(data);
      oscP5.send(myMessage, myRemoteLocation); 
      // mata-la aqui
      life = -1;
//      println("------ >  enviar "+sendstr+" "+myRemoteLocation);
    }



    return send;    
  }


  // método para fazerem overload , este apenas faz checkSendNet
  void update(){
    checkSendNet();
  }


  // método exemplo draw da particula, que podem alterar completamente
  void draw(){   

    pushMatrix();
    translate(x,y,z);
    ellipse(0,0,rad,rad);
    popMatrix();          
  }

}



