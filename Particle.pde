public class Particle {
  PVector pos = new PVector();
  PVector oldPos = new PVector();
  PVector vel = new PVector();
  PVector accel = new PVector();
  
  float mass = 30.0;

  public Particle(float x, float y, float vx, float vy) {
    pos.set(x, y);
    vel.set(vx, vy);
    accel.set(0, 0);
  }

  public void update() {

    oldPos.set(pos);

    // Do physics
    vel.add(accel);
    pos.add(vel);
    accel.set(0, 0);

    if (WRAP) {
      // Wrap
      if (pos.x < 0) {
        pos.x = dim[0]-1;
        oldPos.set(pos);
      } else if (pos.x > dim[0]-1) {
        pos.x = 0;
        oldPos.set(pos);
      }

      if (pos.y < 0) {
        pos.y = dim[1]-1;
        oldPos.set(pos);
      } else if (pos.y > dim[1]-1) {
        pos.y = 0;
        oldPos.set(pos);
      }
    }
  }
  
  public boolean inBounds(float boundX, float boundY, float leway) {
    return (pos.x >= 0 - leway) &&
           (pos.x < boundX + leway) &&
           (pos.y >= 0 - leway) &&
           (pos.y < boundY + leway);
  }
  
  public PVector getMeasure(String m) {
    if (m == "vel") {
      return vel;
    }
    else if (m == "accel") {
      return accel;
    }
    
    return new PVector(0, 0);
  }
  
  public void setMeasure(String m, float x, float y) {
    if (m == "vel") {
      vel.x = x;
      vel.y = y;
    }
    else if (m == "accel") {
      accel.x = x;
      accel.y = y;
    }
  }
  
}
