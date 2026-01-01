class Joint {
  PVector pos;
  PVector diff;
  float angle; // measured in radians
  float len;
  
  Joint(float x, float y) {
    this.pos = new PVector(x, y);
    this.diff = new PVector(1, 0);
  }
  
  void display() {
    stroke(0);
    fill(255);
    strokeWeight(1);
    fill(0, 255, 255);
    circle(this.pos.x, this.pos.y, 15);
  }
  
  void calculatePos() {
    return;
  }
  
  void displayArm() {
    return;
  }
}
