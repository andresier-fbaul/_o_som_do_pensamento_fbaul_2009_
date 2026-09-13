public class EnergyEmitter 
{
	public PApplet stage;
	public float x;
	public float y;
	public ArrayList particles = new ArrayList();
	
	public EnergyEmitter(PApplet stage)
	{
		this.stage = stage;
	}
	
	public void Setup()
	{
		
	}
	
	public void Update()
	{
		EnergyParticle particle;
		for (int i = this.particles.size()-1; i>=0 ; i--)
		{
			particle = (EnergyParticle)this.particles.get(i);
			particle.Update();
			if (particle.OutOfBounds(0,0,stage.width, stage.height))
			{
				this.particles.remove(i);
			}
		}
	}
	
	public int CountCollisions(float x, float y, float size)
	{
		int count = 0;
		EnergyParticle particle;
		for (int i = this.particles.size()-1; i>=0 ; i--)
		{
			particle = (EnergyParticle)this.particles.get(i);
			if (particle.TestCollision(x, y, size))
			{
				count++;
				this.particles.remove(i);
			}
		}
		return count;
	}
	
	public void Gravity(float x, float y, float weight)
	{
		EnergyParticle particle;
		for (int i = this.particles.size()-1; i>=0 ; i--)
		{
			particle = (EnergyParticle)this.particles.get(i);
			particle.Gravity(x, y, weight);
		}
	}
	public void Generate(float x, float y)
	{
		EnergyParticle particle = new EnergyParticle(stage, x,y,stage.random(PApplet.TWO_PI),2);
		this.particles.add(particle);
	}
	public void Draw()
	{
		stage.strokeWeight(1);
		stage.stroke(245,184,0);
		stage.tint(255);
		EnergyParticle particle;
		for (int i = this.particles.size()-1; i>=0 ; i--)
		{
			particle = (EnergyParticle)this.particles.get(i);
			particle.Draw();
		}
	}
}
