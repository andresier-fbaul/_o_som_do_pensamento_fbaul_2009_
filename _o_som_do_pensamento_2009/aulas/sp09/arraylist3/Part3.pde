class Part3 extends Part{

  Part3(float _x, float _y){    
    super(_x,_y);
    energy_dec = random(0.05,0.12);//0.5;
  }
  
  void render(){
    update();
    fill(0,255,0,energy);
    float amt = (cos(frameCount*0.05)*10.);
    ellipse(x+random(-amt,amt) , y+random(-amt,amt) , 50,50); 
  }


}

