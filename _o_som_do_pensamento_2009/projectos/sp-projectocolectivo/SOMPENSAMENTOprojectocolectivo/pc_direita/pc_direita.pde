
/// o som do pensamento - jun 2009
/// projecto colectivo
/// cliente direita

// apenas recebe e bounça as parts
// ou gera...

// vamos usar apenas osc entre os clientes
// dentro da classe particula é q ocorre a única regra:
// se as partículas saem pela direita, são removidas da nossa arraylist,
// e passadas para a arraylist do cliente à direita para a sua posição 0;
// se saem da esquerda, passam para a direita do cliente da esquerda;
// mantemos o y, e as velocidades ao transporar entre os clients

// vão extendendo este que depois é só afinar os valores de rede
// é simples

import oscP5.*;
import netP5.*;
import processing.opengl.*;

/// as cenas de rede

OscP5 oscP5;
NetAddress esquerda;
NetAddress direita;
NetAddress self; // nós
String particula2right = "/particula2right";
String particula2left = "/particula2left";

ArrayList particulas; // a nossa arraylist
PFont font;

void setup() {

//  size(1024,768,OPENGL); // ou 800 x 600, escolham...
  size(200,600,OPENGL); // ou 800 x 600, escolham...
  frameRate(30);

  // Start with 0 balls
  //  balls = new  ArrayList();
  particulas = new  ArrayList();


  /// net stuff

  oscP5 = new OscP5(this,16002); // ler na porta 16002
  esquerda = new NetAddress("127.0.0.1",16001);/// para teste, depois usamos numeros de rede no pp dia...;
  direita = null;//new NetAddress("127.0.0.1",16000); // o da direita deste é o do centro
 // self = new NetAddress("127.0.0.1",16002);/// para teste, depois usamos numeros de rede no pp dia...;

  font = createFont("monaco",10);
  textFont(font);
  stroke(227);

}




public void draw() {  

  /// aqui podem começar a costumizar as coisas
  /// como quiserem

  background(0);//random(100));

  for (int i = 0; i < particulas.size(); i++) {
    MYPART2D part = (MYPART2D) particulas.get(i);
    part.update();
    part.draw();
    //isto tem de ficar para remover as partículas, 
    //basta por a life delas a 0
    if(part.life<=0){
      particulas.remove(i);
      i--; 
    }

  }

  ///stats
  String stats = ""+frameRate+"\nnum: "+particulas.size()+
  "\nself "+self+"\nesqierda "+esquerda+"\ndireita "+direita;
  fill(255);
  text(stats,5,25);
}




/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {

  if(theOscMessage.checkAddrPattern(particula2right)==true) {
//    println("recebido da direita no cliente à direita");
    MYPART2D part = new MYPART2D(0.f,0.f);
    part.x = 0; //theOscMessage.get(0).floatValue();
    part.y = theOscMessage.get(1).floatValue();
    part.z = theOscMessage.get(2).floatValue();
    part.velx = theOscMessage.get(3).floatValue();
    part.vely = theOscMessage.get(4).floatValue();
    part.velz = theOscMessage.get(5).floatValue();
    part.life = theOscMessage.get(6).floatValue();    //255;//theOscMessage.get(6).floatValue();
    // adicionar uma particula da esquerda
    particulas.add(part);
  }


  if(theOscMessage.checkAddrPattern(particula2left)==true) {

    println("2esquerda no da direita");
    
    //    MYPART2D part = new MYPART2D(0.f,0.f);
//    part.x = width; //theOscMessage.get(0).floatValue();
//    part.y = theOscMessage.get(1).floatValue();
//    part.z = theOscMessage.get(2).floatValue();
//    part.velx = theOscMessage.get(3).floatValue();
//    part.vely = theOscMessage.get(4).floatValue();
//    part.velz = theOscMessage.get(5).floatValue();
//    part.life = theOscMessage.get(6).floatValue();    
//    // adicionar uma particula da direita
//    particulas.add(part);
  }


}




public void mousePressed() {
 
  MYPART2D part = new MYPART2D(mouseX,mouseY);
  particulas.add(part);


}


