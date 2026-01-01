class EndEffector {
  Joint j;
  int w = 50;
  int h = 15;
  
  EndEffector(Joint j) {
    this.j = j;
  }
  
  void display() {
    stroke(0);
    fill(255, 0, 0);
    rectMode(CENTER);
    pushMatrix();
    translate(j.pos.x, j.pos.y);
    rotate(j.angle);
    rect(0, 0, w, h);
    popMatrix();
    rectMode(CORNER);
  }
}
