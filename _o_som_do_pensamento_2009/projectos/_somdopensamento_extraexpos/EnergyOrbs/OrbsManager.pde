public class OrbsManager 
{
	public PApplet stage;
	public PImage[] fog = new PImage[6];
	public PImage back;
	public PImage front;
	
	public ArrayList orbs = new ArrayList();
	
	public OrbsManager(PApplet stage)
	{
		this.stage = stage;
		this.fog[0] = stage.loadImage("FogParticle1.png");
		this.fog[1] = stage.loadImage("FogParticle2.png");
		this.fog[2] = stage.loadImage("FogParticle3.png");
		this.fog[3] = stage.loadImage("FogParticle1.png");
		this.fog[4] = stage.loadImage("FogParticle2.png");
		this.fog[5] = stage.loadImage("FogParticle3.png");
		this.back = stage.loadImage("OrbBack.png");
		this.front = stage.loadImage("OrbFront.png");
	}
	
	public void Setup()
	{

	}
	
	public void Update()
	{
                Orb orb;
		for(int i = 0; i < this.orbs.size() ; i++)
		{
                        orb = (Orb)this.orbs.get(i);
			orb.Update();
		}
	}
	
	public void Draw()
	{
                Orb orb;
		for(int i = 0; i < this.orbs.size() ; i++)
		{
                        orb = (Orb)this.orbs.get(i);
			orb.Draw();
		}
	}

}
