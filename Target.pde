class Target {
  PVector pos;
  
  Target(float x, float y) {
    this.pos = new PVector(x, y);
  }
  
  void display() {
    stroke(0);
    fill(255);
    strokeWeight(1);
    fill(105, 205, 255);
    circle(this.pos.x, this.pos.y, 30);
  }
}
