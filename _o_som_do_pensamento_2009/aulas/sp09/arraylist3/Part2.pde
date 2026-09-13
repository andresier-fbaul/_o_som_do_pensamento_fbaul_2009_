class Part2 extends Part{

  Part2(float _x, float _y){    
    super(_x,_y);
    energy_dec = random(0.5,1.2);//0.5;
  }
  
  void render(){
    update();
    fill(random(200),random(200),random(200),energy);
    float amt = energy*0.005;
    ellipse(x+random(-amt,amt) , y+random(-amt,amt) , 50,50); 
  }


}

