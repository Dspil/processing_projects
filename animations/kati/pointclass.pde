class point {
  float x, y, angle, w, r, g, b, size, radius;
  point father;
  boolean has_father;
  int d;
  
  point(float x, float y, float angle, float w, float r, float g, float b, float size, float radius, point father, boolean has_father, int d) {
    this.x = x;
    this.y = y;
    this.angle = angle;
    this.w = w;
    this.r = r;
    this.g = g;
    this.b = b;
    this.size = size;
    this.radius = radius;
    this.father = father;
    this.has_father = has_father;
    this.d = d;
  }
  
  void display() {
    ellipseMode(CENTER);
    fill(r,g,b);
    noStroke();
    ellipse(x, y, 1.8 * size / 3.0, 1.8 * size / 3.0);
    stroke(r, g, b);
    noFill();
    ellipse(x, y, size, size);
    /*if (has_father) {
      noFill();
      stroke(r,g,b);
      ellipse(father.x, father.y, 2 * radius, 2 * radius);
    }*/
  }
  
  void setpos() {
    if (has_father) {
      angle -= w * acceleration;
      x = father.x + cos(angle) * radius;
      y = father.y + sin(angle) * radius;
    }
  }
}