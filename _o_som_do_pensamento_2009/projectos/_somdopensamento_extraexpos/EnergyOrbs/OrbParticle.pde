import processing.core.PApplet;
import processing.core.PImage;


public class OrbParticle 
{
	public PApplet stage;
	
	public float size;
	public float halfSize;
	public float x;
	public float y;
	public float vx;
	public float vy;
	public float decayRate;
	public Orb parentOrb;
	public float energy;
	public PImage image;
	
	public boolean dead;
	
	public OrbParticle(PApplet stage, Orb parentOrb, float decayRate, PImage image)
	{
		this.stage = stage;
		this.halfSize = size-20;
		this.decayRate = decayRate;
		this.size = parentOrb.size*3f;
		this.dead = false;
		this.parentOrb = parentOrb;
		this.energy = 1;
		
		this.image = image;
	}
	
	public void Setup()
	{
		
	}
	
	public void Update()
	{
		this.energy -= this.decayRate;
		if (this.energy<=0)
		{
			this.dead = true;
		}
	}
	
	public void Draw()
	{
		//stage.brightness(255);
		float level = this.energy*155;
		stage.tint(level, level,255,level);
		//stage.tint(255,energy*255);
		float sizeParticle = this.size*0.8f*energy;
		//stage.rotate(stage.random(3));
		stage.image(this.image, this.parentOrb.x, this.parentOrb.y,size-sizeParticle,size-sizeParticle);
	}
	
}
