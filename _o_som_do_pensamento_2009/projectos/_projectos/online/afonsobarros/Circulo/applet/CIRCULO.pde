/*  circulo, som do pensamento + scribler */
// afonsobarros@gmail.com




float raio;
float angulo;

float ppx, ppy; //previous px, py
float px, py;

Scribler escrivas[];

void setup(){
 size(800,600);
 frameRate(30);
 background(255);   
  //inicializar tudo no centro
 ppx = px = width/2;
 ppy = py = height/2;
escrivas = new Scribler[50];
  for(int i=0; i<escrivas.length;i++)
    escrivas[i] = new Scribler();



}


void draw(){
 
 angulo = angulo + ( map (mouseX, 0 , width, -0.9,0.9) );
 raio = map(mouseY,0,height,0.,250.);
 for(int i=0; i<escrivas.length;i++)
    escrivas[i].draw();
 //guardar as posições anteriores
 ppx = px;
 ppy = py;
 //calcular as novas posições do circulo:
 // cos/sin(angulo) * raio + centro
 px = cos(angulo) * raio + width/2;
 py = sin(angulo) * raio + height/2;
 
 
   ///onde se activa o escriva..
   if(mousePressed)//if(random(1)<0.2)
      for(int i=0; i<escrivas.length;i++){
        if(escrivas[i].energy <= 0.){
          escrivas[i] = new Scribler(px,py,(px-ppx),(py-ppy),20);
          break; // get out of the for loop if this condition is true
        }
      }
 
 stroke(255,255);
 line (px,py,ppx,ppy);
 
  
}

void keyPressed(){
  if (key == 's')
    saveFrame("desenhar-2a-exe-####.jpg");//save();
  if (key == ' ')
    background(255);

}
