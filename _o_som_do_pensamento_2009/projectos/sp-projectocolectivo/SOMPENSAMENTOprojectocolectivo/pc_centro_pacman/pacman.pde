class Pacman
{
  PImage pacmanImage;
  PImage burstModeImg;
  float angle;
  float v;
  float x,y;
  float fat;
  float pacWidth;
  float pacHeight;
  float eatDist;
  float timeFat;
  boolean burstMode = false;
  float thinner = 0;
  
  Pacman(PImage pacman, PImage burstModeImg)
  {
    this.pacmanImage = pacman;
    this.burstModeImg = burstModeImg;
    this.x = width/2;
    this.y= height/2;
    this.angle = 0;
    this.v = 0;
    fat = 0.5;
    timeFat = millis();
    CalcSize();
  }
  
  void CalcSize()
  {
    pacWidth = pacmanImage.width * fat;
    pacHeight = pacmanImage.height * fat;
    eatDist = 20*fat;
  }
  
  void update(ArrayList particles)
  {
    Particula maxParticle = null;
    float distMax = 0;
    Particula particle = null;
    float dist;
    
    if (burstMode)
    {
      v=0;
      angle+=0.5;
      fat -= thinner;

      if (fat < 0.5)
      {
        fat = 0.5;
        burstMode = false;
      }
      
    }
    else
    {
      for(int i=0; i< particles.size() ; i++)
      {
        particle = (Particula)particles.get(i);
        dist = PApplet.dist(particle.x,particle.y,x,y);
        if (dist<eatDist)
        {
          particle.life = -1;
          fat+=0.1;
        }
        if (maxParticle == null || dist < distMax)
        {
          distMax = dist;
          maxParticle = particle;
        }
      }
      
      
      if (maxParticle != null)
      {
        angle = atan2(maxParticle.y-y, maxParticle.x-x);
        v = 10;
      }
      else
      {
        angle = 0;
        v = 0;
      }
    }
    CalcSize();
    this.x += v*cos(angle);
    this.y += v*sin(angle);
    if (fat > 2)
    {
      burstMode = true;
      float timeSpan = millis()-timeFat;
      timeFat = millis();
      thinner = 1000/timeSpan;
    }
  }
  
  void draw()
  {
    imageMode(CENTER);
    pushMatrix();

    if (burstMode)
    {
      translate(x+random(-20,20),y+random(-20+20));
      rotate(angle);
      image(burstModeImg,0,0,pacWidth, pacHeight);
    }
    else
    {
      translate(x,y);
      rotate(angle);
      image(pacmanImage,0,0,pacWidth, pacHeight);
    }
    popMatrix();
  }
}
