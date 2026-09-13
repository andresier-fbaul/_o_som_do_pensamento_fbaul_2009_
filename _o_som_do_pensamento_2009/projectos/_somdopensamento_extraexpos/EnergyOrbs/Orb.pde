public class Orb 
{
	public PApplet stage;
	
	public float size;
	public float artSize;
	public float x;
	public float y;
	public float vx;
	public float vy;
	public OrbsManager manager;
	public ArrayList orbParticles = new ArrayList();
	public int maxParticles;
	public int counter = 0;
	
	public Orb(PApplet stage, OrbsManager manager,float x, float y, float vx, float vy, float size)
	{
		this.stage = stage;
		this.x = x;
		this.y = y;
		this.vx = vx;
		this.vy = vy;
		this.SetSize(size);
		this.manager = manager;	
		this.maxParticles = (int)size;
	}
	
	public void Update()
	{
		this.x +=this.vx;
		this.y += this.vy;
		
		counter++;

		if (this.orbParticles.size() < this.maxParticles && counter > 20)
		{
			counter = 0;
			this.orbParticles.add(new OrbParticle(stage, this, 0.01f,this.manager.fog[PApplet.round(stage.random(5))]));
		}
		OrbParticle orbParticle;
		for (int i = this.orbParticles.size()-1; i>=0 ; i--)
		{
			orbParticle = (OrbParticle)this.orbParticles.get(i);
			orbParticle.Update();
			if (orbParticle.dead)
			{
				this.orbParticles.remove(orbParticle);
			}
		}

	}
	public void SetSize(float size)
	{
		this.size = size;
		
	}
	public void Draw()
	{
		stage.fill(255);

		OrbParticle orbParticle;
		for (int i = this.orbParticles.size()-1; i>=0 ; i--)
		{
			orbParticle = (OrbParticle)this.orbParticles.get(i);

			orbParticle.Draw();

		}
		stage.noTint();
		this.artSize = (float)(size*stage.random(2.5f,2.55f));
		stage.image(manager.front, x, y, artSize, artSize);
	}
}
