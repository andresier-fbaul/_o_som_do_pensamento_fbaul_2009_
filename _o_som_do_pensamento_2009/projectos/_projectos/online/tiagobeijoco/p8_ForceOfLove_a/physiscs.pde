float[] physics(float[][] input, int type){
  // determine colision normal vector: d(dx,dy); determine distance between emitters: d
  float dx = input[0][0]-input[1][0];
  float dy = input[0][1]-input[1][1];
  float d2 = sq(dx) + sq(dy);
  float d = sqrt(d2);

  // apply gravity
  if ((type == 0 || type == 2)&& d>0){ 
    float fg = 0.052*input[0][5]*input[1][5]/d2;  // fg(fgx,fgy)=GravConst*(mass1*mass2)/sq(distance);
    float fgx = fg*dx/d;// * 0.25;
    float fgy = fg*dy/d;// *0.25;
    input[0][2] -= fgx/input[0][5]; input[0][3] -= fgy/input[0][5];
    input[1][2] += fgx/input[1][5]; input[1][3] += fgy/input[1][5];
  }

  //check for elastic colision
  if (type>0 && d <= input[0][4]+input[1][4] && d>0){
    // get bodies' velocity in the colision normal and tangent; 
    // apply spring to normal velocity and parse them back to the v(x,y)
    float d_rot = acos(dx/d);  // d(dx,dy) rotation
    float dn_rot = PI / 2 - d_rot;  // dn(dnx,dny) rotation
    for(int a=0;a<2; a++){
      float v = sqrt(sq(input[a][2])+sq(input[a][3]));  // linear velocity
      if (v>0){
        float dv_rot = acos(input[a][2]/v) - d_rot;  // v(vx,vy) rotation in (d,dn)
        float fd = -(0.00001/input[a][4])*pow(input[0][4]*input[1][4]-d,1);  // spring normal repulsion.
        float vd = v * cos(dv_rot) + fd / input[a][5];  // velocity along the colision normal
        float vdn = v * sin(dv_rot);  // velocity along the colision tangent
        input[a][2] = vd * cos(d_rot) + vdn * cos(dn_rot);
        input[a][3] = vd * sin(d_rot) + vdn * sin(dn_rot);
  }}}

  float[] physVals = {input[0][2], input[0][3], input[1][2], input[1][3]};
  return physVals;
}
