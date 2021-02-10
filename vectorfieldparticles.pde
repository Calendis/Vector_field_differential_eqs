int dim[] = {1000, 900};

int particleNo = 3000;
ArrayList<Particle> particles = new ArrayList<Particle>();

float scaleX = 70;
float scaleY = 70;
float offsetX = 0.0;
float offsetY = 0.0;

float lineAlpha = 35;
float bgBrightness = 0;

float time = 0.0;
float timeStep = 0.01;

boolean redrawFunction = false;

boolean doClear = false;
boolean WRAP = false;
boolean resetOOBParticles = false;
boolean resetStuckParticles = true; // Try false if on accel mode!
boolean divOnVel = false;
String affectedMeasure = "vel"; // Must be "vel" or "accel"

float stuckThreshold = 0.00003;


PVector fieldFunc(float x, float y) {
  x = x - dim[0]/2;
  y = -dim[1]/2 + y;
  x /= scaleX;
  y /= scaleY;
  x += offsetX;
  y += offsetY;

  float delFOverDelX = sin(x) - cos(x);
  float delFOverDelY = cos(y) - sin(y);

  PVector v = new PVector(delFOverDelY, delFOverDelX);

  //v.normalize(); // Some functions make nicer particle trails when normalized... experiment!

  return v;
}


void setup() {
  
  // setSize doesn't work on some machines!! Reason is unknown...
  // If your window is not the correct size, uncomment 'size' line
  // The downside is it CANNOT accept variables as arguments, only literals
  size(1000, 900);
  surface.setSize(dim[0], dim[1]);
  
  // Use a 360-degree colour wheel
  colorMode(HSB, 360);

  // Assemble the list of particles
  for (int i = 0; i < particleNo; i++) {
    float randX = random(0, dim[0]);
    float randY = random(0, dim[1]);
    particles.add(new Particle(randX, randY, 0, 0));
  }
  clear();
  
}

boolean doneInitialDraw = false;

void draw() {
  if (doClear) {
    clear();
  }
  update();

  // Draw the function as a background once, or each frame if redrawFunction is set (slow)
  if (redrawFunction || !doneInitialDraw) {
    // Draw the vectors to a screen
    noStroke();

    for (int i = 0; i < dim[0]; i++) {

      for (int j = 0; j < dim[1]; j++) {

        PVector fieldV = fieldFunc(i, j);
        float magnitude = fieldV.mag();

        float hue = degrees(fieldV.heading()) + 180;
        float saturation = magnitude * 180 + 180;
        float value = bgBrightness;

        color c = color(hue, saturation, value);
        fill(c);

        rect(i, dim[1]-j, 1, 1);
      }
    }
    doneInitialDraw = true;
  }

  // Iterate over the particles and draw
  for (Particle p : particles) {

    float hue = degrees(p.vel.heading()) + 180;
    float saturation = 360;
    float value = 360;

    stroke(color(hue, saturation, value, lineAlpha));
    //strokeWeight(2);
    noFill();
    line(p.pos.x, dim[1]-p.pos.y, p.oldPos.x, dim[1]-p.oldPos.y);
  }
}

void update() {

  // Iterate over the particles and apply the appropriate force
  for (Particle p : particles) {
    p.update();

    PVector newVel = fieldFunc(p.pos.x, p.pos.y);
    
    if (divOnVel || affectedMeasure == "accel") {
      newVel.div(p.mass);
    
    }
    
    p.setMeasure(affectedMeasure, newVel.x, newVel.y);

    // Handle OOB or stuck particles
    if ( (resetOOBParticles && (!p.inBounds(dim[0], dim[1], 100))) || (resetStuckParticles && (p.vel.magSq() < stuckThreshold && p.accel.magSq() < stuckThreshold)) ) {
      float randX = random(0, dim[0]);
      float randY = random(0, dim[1]);
      
      // Reset the particle's position
      p.pos.x = randX;
      p.pos.y = randY;
      
      // Set the old position the same so a line doesn't draw to the new position
      p.oldPos.x = randX;
      p.oldPos.y = randY;
      
      // Reset tne particle's measure
      p.setMeasure(affectedMeasure, 0, 0);
      
      // Reset the particle's velocity
      p.vel.set(0, 0);
      
    }
  }    
  
  // Increase the time
  time += timeStep;
  
}
