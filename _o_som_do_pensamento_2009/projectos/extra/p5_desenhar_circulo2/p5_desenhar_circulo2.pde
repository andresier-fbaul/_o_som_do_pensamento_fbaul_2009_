/*  circulo, som do pensamento

  este sketch procura mostrar como se constroiem círculos,
  e como convertemos entre coordenadas cartesianas e polares
    
  um ponto cartesiano (x,y) pode ser descrito como (alpha,raio) polar,
  e vice-versa, um ponto polar tem correspondentes no sistema cartesiano.

  //  CONVERSÃO POLAR->CARTESIANO

  tendo angulo e raio, converte-se para coords cartesianas usando sin e cos
  
  x = raio * cos (angulo);
  y = raio * sin (angulo);


  //  CONVERSÃO CARTESIANO->POLAR

  tendo x e y, converte-se para coordenadas polares usando o teorema de pitágoras

  raio = √ ( x^2 + y^2 ); // raiz quadrada da soma dos quadrados de x e y
  angulo = atan2 (y,x);
  
*/

float raio;
float angulo;

float ppx, ppy; //previous px, py
float px, py;

void setup(){
 size(700,700);
 frameRate(30);
 background(100);   
  //inicializar tudo no centro
 ppx = px = width/2;
 ppy = py = height/2;
}


void draw(){
 
 angulo = angulo +( map (mouseX, 0 , width, -0.2,0.2) );
 raio = map(mouseY,0,height,300.,0.);
 
 //guardar as posições anteriores
 ppx = px;
 ppy = py;
 //calcular as novas posições do circulo:
 // cos/sin(angulo) * raio + centro
 px = cos(angulo) * raio + width/2;
 py = sin(angulo) * raio + height/2;
 
 stroke(255,100);
 line (px,py,ppx,ppy);
 
  
}


void keyPressed(){
 if(key=='s')
  saveFrame("circulo-####.tiff"); 
}

