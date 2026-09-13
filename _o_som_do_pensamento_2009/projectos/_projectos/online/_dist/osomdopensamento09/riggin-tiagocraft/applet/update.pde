void update(){
  corpo.update();
  
  /* aste frente 1 */ {
  if(corpo.py*0.6 >= -rodaFrente.rad*0.6) asteFrente1.rot = HALF_PI;  // corpo a altura <= raio da roda: aste bate no corpo e não roda mais.
  else{
    if(corpo.py*0.6 <= -asteFrente1.x-rodaFrente.rad*0.6) asteFrente1.rot = 0;  // corpo a altura >= comprimento da aste: aste pendurada na vertical
    else{
      float rotSin = (corpo.py+rodaFrente.rad)*0.6/asteFrente1.x; // corpo a altura intermédia: rotação da aste depende da altura
      asteFrente1.rot = HALF_PI+asin(rotSin);
  }}}
  
  /* aste frente 2 */ {
  if(corpo.py*0.4 >=-rodaFrente.rad*0.4){
    asteFrente2.rot = HALF_PI-asteFrente1.rot;
    rodaFrente.contacto=1;
  }
  else{
    if(corpo.py < -asteFrente1.x-asteFrente2.x-rodaFrente.rad*0.4){
      asteFrente2.rot = 0;
      rodaFrente.contacto=0;
    }else{
      float rotSin = (corpo.py+rodaFrente.rad)*0.4/asteFrente2.x;
      asteFrente2.rot = HALF_PI+asin(rotSin)-asteFrente1.rot;
      rodaFrente.contacto=1;
  }}}

  /* aste meio */ {
  if(corpo.py*0.4 >=-rodaMeio.rad*0.4){
    asteMeio.rot = HALF_PI+asteFrente1.rot;
    rodaMeio.contacto=1;
  }else{
    if(corpo.py < -asteFrente1.x-asteMeio.x-rodaMeio.rad*0.4){
      asteMeio.rot = -asteFrente1.rot;
      rodaMeio.contacto = 0;
    }else{
      float rotSin = (corpo.py+rodaMeio.rad)*0.4/asteMeio.x;
      asteMeio.rot =-HALF_PI-asin(rotSin)-asteFrente1.rot;
      rodaMeio.contacto = 1;
  }}}

  /* aste trás */{
  if(corpo.py >= -rodaTras.rad){
    asteTras.rot = -HALF_PI;
    rodaTras.contacto = 1;
  }else{
    if(corpo.py < -asteTras.x-rodaTras.rad){
      asteTras.rot=0;
      rodaTras.contacto = 0;
    }else{
      float rotSin = (corpo.py + rodaTras.rad)/asteTras.x;
      asteTras.rot = -HALF_PI-asin(rotSin);
      rodaTras.contacto = 1;
  }}}

  // roda frente
  if(rodaFrente.contacto==1) rodaFrente.rot -= float(mouseX - pmouseX)/rodaFrente.rad;
  // roda meio
  if(rodaMeio.contacto==1) rodaMeio.rot -= float(mouseX - pmouseX)/rodaMeio.rad;
  // roda tras
  if(rodaTras.contacto ==1) rodaTras.rot -= float(mouseX - pmouseX)/rodaTras.rad;
}
