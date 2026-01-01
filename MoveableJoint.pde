class MoveableJoint extends Joint {
  Joint prev;

  MoveableJoint(float x, float y, Joint prev) {
    super(x, y);

    this.prev = prev;
    this.diff = PVector.sub(this.pos, this.prev.pos);
    this.len = this.diff.mag();
  }

  void calculatePos() {
    PVector rel = this.prev.diff;
    
    /*
    float det = rel.x * -this.diff.y + rel.y * this.diff.x;
    println(rel);
    println(this.diff);
    if (det >= 0) {
      this.prev.angle = PVector.angleBetween(rel, this.diff);
      println("Positive " + this.prev.angle);
    } else {
      this.prev.angle = (float)(2 * Math.PI) - PVector.angleBetween(rel, this.diff);
      println("Negative " + this.prev.angle);
    }
    */

    float a = (float)(Math.cos(this.prev.angle) * rel.x - Math.sin(this.prev.angle) * -rel.y);
    float b = (float)(Math.sin(this.prev.angle) * rel.x + Math.cos(this.prev.angle) * -rel.y);

    PVector v2 = new PVector(a, b);
    v2.normalize().mult(len);

    this.pos.x = v2.x + this.prev.pos.x;
    this.pos.y = -v2.y + this.prev.pos.y;
    this.diff = PVector.sub(this.pos, this.prev.pos);
  }

  void displayArm() {
    fill(255);
    strokeWeight(15);
    line(this.prev.pos.x, this.prev.pos.y, this.pos.x, this.pos.y);
  }

  void display() {
    stroke(0);
    fill(255);
    strokeWeight(1);
    fill(0, 255, 0);
    circle(this.pos.x, this.pos.y, 20);
  }
}
