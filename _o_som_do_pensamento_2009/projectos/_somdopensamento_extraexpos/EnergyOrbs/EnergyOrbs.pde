
import processing.video.Capture;
import processing.video.MovieMaker;
import s373.flob.Flob;
import s373.flob.trackedBlob;
import processing.opengl.*;
import javax.media.opengl.*;
import javax.media.opengl.glu.*;
import krister.Ess.*;



	OrbsManager orbsManager;
	EnergyEmitter energyEmitter;

	Flob flob;
	Capture video;
	int thresh = 20; 
	int videotex = 0; 
	int fade = 2;
  AudioChannel myChannel;

	PImage fog;
	
	MovieMaker mm;  // Declare MovieMaker objec
	
	boolean recording = false;

	void setup()
	{
                  //bug 882 processing 1.0.1
                try { 
                  quicktime.QTSession.open();  
                } 
                catch (quicktime.QTException qte) {  
                  qte.printStackTrace();  
                }
		size(1024,768,OPENGL);
		frameRate(30);
		background(0);
		smooth();
   Ess.start(this);
                myChannel=new AudioChannel("Electric.mp3");

		// Init video data and stream
		video = new Capture(this, 160, 120, 25); 

		// Init blob tracker
		flob = new Flob(this, video, width,height); // new: pass in width and height of scene, get values in those ranges
		flob.setThresh(thresh);
		flob.setSrcImage(videotex);
		flob.setBlur(1);
		flob.setMirror(true,false);
		flob.setOm(Flob.CONTINUOUS_DIFFERENCE);

		// Orbs Manager
		orbsManager = new OrbsManager(this);
		orbsManager.Setup();

		// Energy Particle Emitter
		energyEmitter = new EnergyEmitter(this);
		energyEmitter.Setup();

		this.imageMode(PApplet.CENTER);
		
		PFont font;
		// The font must be located in the sketch's 
		// "data" directory to load successfully
		font = loadFont("Arial.vlw"); 
		textFont(font); 
	}


	void Update()
	{
		//get and use the data tracking data
		int numblobs = flob.getNumTrackedBlobs(); 
		boolean covered = false;
		// handle tracked blobs
		float dist;
		float dx;
		float dy;
		//this.energyEmitter.Generate(100, 100);
		for(int i = 0; i < numblobs; i++) {
			trackedBlob tb = flob.getTrackedBlob(i); 
			// generate energy particles from blob
			this.energyEmitter.Generate(tb.cx, tb.cy);
			covered = false;
			// find out about blobs near by
                      Orb orb;
			for(int j=0; j<orbsManager.orbs.size();j++)
			{
                              orb = (Orb)orbsManager.orbs.get(j);
				dx = tb.cx - orb.x;
				dy = tb.cy - orb.y;
				dist = PApplet.sqrt(PApplet.sq(dx)+ PApplet.sq(dy));
				if (dist <(orb.size + 400))
				{
					covered = true;
					if (dist>orb.size)
					{
						orb.vx = dx/dist;
						orb.vy = dy/dist;
					}
				}
			}
			// if there is no orb close by
			if (covered == false)
			{
				// create new orb
				Orb orbNew = new Orb(this,this.orbsManager,tb.cx, tb.cy,0,0,30);
				this.orbsManager.orbs.add(orbNew);
			}
		}
		
		/*if (this.mousePressed)
		{
			this.energyEmitter.Generate(this.mouseX, this.mouseY);
		}*/
		orbsManager.Update();
		Orb orb;
		for(int i = orbsManager.orbs.size()-1;i>=0;i--)
		{
			orb = (Orb)orbsManager.orbs.get(i);
			this.energyEmitter.Gravity(orb.x, orb.y, orb.size);
			orb.SetSize(orb.size+(this.energyEmitter.CountCollisions(orb.x, orb.y, orb.size/2)*100/orb.size));
			orb.size-=orb.size/200;
			if (orb.size < 20)
			{
				orbsManager.orbs.remove(i);
			}
		}
		this.energyEmitter.Update();
	}

	void draw()
	{
		// Motion Capture
		if(video.available()) {
			video.read();
			PImage bin = flob.binarize(video);
			flob.track(bin);
		}

		this.Update();
		
		//Draw
		background(0);
		image(flob.getSrcImage(),width/2,height/2,width,height);
		
		if (millis()<5000)
		{
			return;
		}
		
		orbsManager.Draw();
		this.energyEmitter.Draw();
		
		// Electricity
		Orb orbAnterior = null;
		Orb orb;
                boolean electricActive = false;
		for(int i = orbsManager.orbs.size()-1;i>=0;i--)
		{
			orb = (Orb)orbsManager.orbs.get(i);
			
			if (orbAnterior != null)
			{
				if (PApplet.dist(orbAnterior.x, orbAnterior.y, orb.x, orb.y)<(orbAnterior.size+orb.size)*0.5f)
				{
					orbAnterior.size = (orbAnterior.size+orb.size)*0.7f;
					orbsManager.orbs.remove(i);
				}
			}
			if (orb.size>100)
			{
				if (orbAnterior != null)
				{
                                        ElectricityFX efx = new ElectricityFX();
					// Electricity
					efx.GenerateArc(this, (int)orbAnterior.x, (int)orbAnterior.y, (int)orb.x, (int)orb.y, 3);
					efx.GenerateArc(this, (int)orbAnterior.x, (int)orbAnterior.y, (int)orb.x, (int)orb.y, 1);
					efx.GenerateArc(this, (int)orbAnterior.x, (int)orbAnterior.y, (int)orb.x, (int)orb.y, 1);
                                        electricActive = true;
				}
				orbAnterior = orb;
			}
		}
if (electricActive)
{
      myChannel.play(Ess.FOREVER);
}
else
{
      myChannel.pause();

}

		text("Fps:"+this.frameRate+"\nParticles:"+this.energyEmitter.particles.size(), 15, 30);
		if (recording)
			mm.addFrame();
	}

	public void mousePressed() {

	}
	
	public void keyPressed() {
		  if (key == ' ') {
			  if (recording)
			  {
				  recording = false;
				  mm.finish();  // Finish the movie if space bar is pressed!
			  }
			  else
			  {
				  recording = true;
				  mm = new MovieMaker(this, width, height, "dragonball.mov",
	                       30, MovieMaker.MOTION_JPEG_A, MovieMaker.LOW);
			  }
		  }
		}


