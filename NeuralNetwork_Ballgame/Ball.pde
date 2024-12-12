class Ball {
  PVector pos, prevpos;
  PVector velocity;
  PVector acceleration;
  PVector heading;
  PVector gravity;
  float g;
  int size = 20;


  Ball() {
    pos = new PVector(width/8, height/4);
    gravity = new PVector(0, 0.1);
    velocity = new PVector();
    heading = new PVector();
    acceleration = new PVector();
    prevpos = new PVector();
  }


  void update() {
    acceleration.add(gravity);

    prevpos = pos.copy();
    velocity.add(acceleration);
    pos.add(velocity);
    acceleration.mult(0);
  }


  void applyForce (PVector f) {
    acceleration.add(f);
  }


  void display() {
    noStroke();
    fill(128);
    ellipse(pos.x, pos.y, size, size);
    stroke(255, 0, 0);
    line(prevpos.x, prevpos.y, pos.x, pos.y);
  }
}
