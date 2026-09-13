class PulsingCircles {
  int nCircles; //num of pulsing circles
  float rad_0, rad_1; //preset radius, mouse-modulated radius
  float phase[], inc[]; //pulsing phase and increment factor
  float weight[]; //line-weight
  color col; // line-color
  int btn;  // modulator mouse-button
  
  PulsingCircles(int in_nCircles, int rad, color in_col, int in_btn){
    nCircles = in_nCircles;
    phase = new float[nCircles];
    inc = new float[nCircles];
    weight = new float[nCircles];
    rad_0 = rad;
    rad_1 = 0;
    col = in_col;
    btn = in_btn;
   
    for(int a=0;a<nCircles;a++){
      phase[a] = random (-1,1);
      inc[a] = random (0.02, 0.075);
      weight[a] = random(rad_0/10);
    }
  }
  
  void update(int px, int py){
    // modulate rad_1 with the mouse-button
    float filtro = 0.8; // change speed
    float shrink = 0.5; // change amount
    if(mousePressed == true && mouseButton == btn && rad_1-(rad_0*shrink)>0.1)
      rad_1 = filtro*rad_1 + (1-filtro)*rad_0*shrink;
    else if(mousePressed == true && mouseButton == btn)
      rad_1 = rad_0*shrink;
    else if(rad_0-rad_1>0.1)
      rad_1 = filtro*rad_1 + (1-filtro)*rad_0;
    else
      rad_1 = rad_0;
    
    filtro = 2/3;
    for(int a=0;a<nCircles;a++){
      // update phase
      phase[a]+= filtro*inc[a]+(1-filtro)*map(weight[a],1,ceil(rad_0/10),0.075,0.02); // modulate inc with weight to update phase
      if(phase[a]>TWO_PI)
        phase[a]-=TWO_PI;
      
      // redraw the pulsing circles
      noFill(); smooth(); stroke (col);
      for (float b = weight[a]; b>0; b-=2){
        strokeWeight(b);
        float shift = 0.5;  //shift the radius
        float diam = (2+shift)*rad_1 + (shift+0.25)*rad_1*sin (phase[a]);

        ellipse (px, py, diam, diam);
      }
    }
    //redraw the static circle
    stroke(80,125);
    strokeWeight (ceil(rad_0/10));
    float diam = 2*rad_1;
    ellipse(px,py, diam, diam);
  }
  
}
