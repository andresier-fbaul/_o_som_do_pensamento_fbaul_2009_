/*  som do pensamento, desenhar_2
 
 não apagar o fundo e desenhar linhas continuamente,
 se o rato estiver pressionado
 
 não há qq memória dos pontos das linhas, são apenas
 desenhadas no framebuffer sem serem apagadas 
 

exercício:

1. alterar as cores de fundo e homogeneizar(sem serem iguais)
as cores das formas que desenham

2. alterar os parâmetros da curvatura dos escrivas, fazendo a 
curvatura depender da velocidade

3. gravar 2 imagens boas para o disco (nota, se quiserem melhor
qualidade, substituir '.jpg' por '.tiff')
 
 */



Scribler escrivas[];




void setup(){
  size (700,700);   
  frameRate(30);    
  background(150);

  escrivas = new Scribler[10];
  for(int i=0; i<escrivas.length;i++)
    escrivas[i] = new Scribler();
}


void draw(){

  for(int i=0; i<escrivas.length;i++)
    escrivas[i].draw();

  if(mousePressed){
    // a dist entre rato anterior e o rato actual
    float d = abs(pmouseX-mouseX) +  abs(pmouseY-mouseY); 
    // a largura da linha proporcional à distância do rato
    strokeWeight(d*0.1);
    stroke(255,255,255, 50); // cor branca com alpha reduzido

    // o comando que desenha a linha
    line (mouseX,mouseY,pmouseX,pmouseY);

    ///onde se activa o escriva..
 //   if(frameCount%10==0)//if(random(1)<0.2)
      for(int i=0; i<escrivas.length;i++){
        if(escrivas[i].energy <= 0.){
          escrivas[i] = new Scribler(mouseX,mouseY,(mouseX-pmouseX),(mouseY-pmouseY),d);
          break; // get out of the for loop if this condition is true
        }

      }

   }

}


void keyPressed(){
  if (key == 's')
    saveFrame("desenhar-2a-exe-####.tiff");//jpg");//save();
  if (key == ' ')
    background(150);

}

