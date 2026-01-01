Joint[] joints;
Target t;
EndEffector end;

void setup() {
  size(800, 600);
  frameRate(60);
  
  joints = new Joint[3];
  joints[0] = new Joint(400, 500);
  joints[1] = new MoveableJoint(250, 350, joints[0]);
  joints[2] = new MoveableJoint(300, 200, joints[1]);
  end = new EndEffector(joints[2]);
  
  t = new Target(600, 300);
}

void calculateAngles(int x_coord, int y_coord) {
  Joint j0 = joints[0];
  Joint j1 = joints[1];
  Joint j2 = joints[2];
  
  /*
   System of equations:
   -90 = theta1 + theta2 + theta3
   target.x = j1.len * cos(theta1) + j2.len * cos(theta1 + theta2)
   target.y = j1.len * sin(theta1) + j2.len *  sin(theta1 + theta2)
  */
  
  float truex = (x_coord - j0.pos.x);
  float truey = (j0.pos.y - y_coord);
  
  double L1 = j1.len;
  double L2 = j2.len;
  
  double r2 = truex * truex + truey * truey;
  
  double theta2 = Math.acos((r2 - L1*L1 - L2*L2) / (2 * L1 * L2));
  theta2 = truex > 0 ? theta2 * -1 : theta2;
  double theta1 = Math.atan2(truey, truex)
                - Math.atan2(L2 * Math.sin(theta2),
                             L1 + L2 * Math.cos(theta2));
  double theta3 = Math.toRadians(-90) - theta1 - theta2;
  
  j0.angle = (float)theta1;
  j1.angle = (float)theta2;
  j2.angle = (float)theta3;
}

void mouseMoved() {
  Joint j0 = joints[0];
  Joint j1 = joints[1];
  Joint j2 = joints[2];
  
  float dx = j0.pos.x - mouseX;
  float dy = j0.pos.y - mouseY;
  if (Math.sqrt(dx*dx + dy*dy) > j1.len + j2.len || 
      Math.sqrt(dx*dx + dy*dy) < Math.abs(j1.len - j2.len)) {
    return;
  }
  
  calculateAngles(mouseX, mouseY);
  for (Joint j : joints) {
    j.calculatePos();
  }
}

void draw() {
  background(255);
  
  t.display();
  
  // Floor
  fill(25);
  rect(0, 500, width, height);
  
  // Calculate positions and display all objects
  for (Joint j : joints) {
    j.displayArm();
  }
  for (Joint j : joints) {
    j.display();
  }
  end.display();
}
