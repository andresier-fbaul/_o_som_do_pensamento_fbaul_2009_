import processing.core.PApplet;


public class EnergyParticle {

	float x;
	float y;
	float x2;
	float y2;
	float vx;
	float vy;
	float angle;
	float speed;
	PApplet stage;
	
	
	public EnergyParticle(PApplet stage, float x, float y, float angle, float speed)
	{
		this.stage = stage;
		this.x = x;
		this.y = y;
		this.x2 = x;
		this.y2 = y;
		this.angle = angle;
		this.speed = speed;
		this.CalcV();
	}
	public void CalcV()
	{
		this.vx = this.speed * PApplet.cos(this.angle);
		this.vy = this.speed * PApplet.sin(this.angle);
	}
	public void CalcAngle()
	{
		this.angle = PApplet.atan2(this.vy, this.vx);
		this.speed = PApplet.sqrt(PApplet.sq(this.vx)+PApplet.sq(this.vy));
	}
	public void Gravity(float x, float y, float weight)
	{
		float dx = x-this.x;
		float dy = y-this.y;
		float dist = PApplet.sqrt(PApplet.sq(dx)+PApplet.sq(dy));
		this.vx += 100*dx/PApplet.sq(dist);
		this.vy += 100*dy/PApplet.sq(dist);	
	}
	public boolean TestCollision(float x, float y, float size)
	{
		return PApplet.dist(this.x, this.y, x, y)<size;
	}
	public void Update()
	{
		this.x2 = this.x;
		this.y2 = this.y;
		this.x += this.vx;
		this.y += this.vy;
	}

	public void Draw()
	{
		stage.line(this.x, this.y, this.x2, this.y2);
	}
	public boolean OutOfBounds(float left, float up, float right, float down)
	{
		return (this.x<left || this.x>right || this.y<up || this.y>down);
	}
}
