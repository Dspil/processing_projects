ArrayList<point> points = new ArrayList<point>();

int depth = 1;
int vertices = 6;
float w = 2 * PI / 100;
float size = 30;
float radius = 200;
float acceleration = 0.2;
float maxa = 5;
float mina = -5;
float increase = 0.05;
float decrease = 1.3;
float acceleration2 = 3;
float base = 2;
boolean TRACE = true;

void setup() {
  size(displayWidth, displayHeight);
  background(0);
  points.add(new point(displayWidth / 2, displayHeight / 2, 0, 255, 255, 255, 255, size, 0, null, false, 0));
  populate(depth, 0);
  for (int i = 0; i < points.size(); i++) {
    points.get(i).display();
  }
}

void populate(int d, int index) {
  if (d == 1) {
    for (int i = 0; i < vertices; i++) {
      points.add(new point(0, 0, i * 2 * PI / vertices, w + (depth - d) * 2 * PI / 100 * acceleration2, 255, 255, 255, size / pow(decrease,(depth - d)), radius / pow(base, (depth - d)), points.get(index), true, depth - d + 1));
    }
  }
  else {
    for (int i = 0; i < vertices; i++) {
      points.add(new point(0, 0, i * 2 * PI / vertices, w + (depth - d) * 2 * PI / 100 * acceleration2, 255, 255, 255, size / pow(decrease,(depth - d)), radius / pow(base, (depth - d)), points.get(index), true, depth - d + 1));
      populate(d - 1, points.size() - 1);
    }
  }
}

void draw() {
  if (TRACE) {
      fill(0, 20);
      rectMode(CORNERS);
      rect(-1, -1, width+1, height+1);
  }
  else {
    background(0);
  }
  for (int i = 0; i < depth; i++) {
    for (int j = 0; j < points.size(); j++) {
      if (i == points.get(j).d) {
        points.get(j).setpos();
        //if (i == depth - 1) {
          points.get(j).display();
        //}
      }
    }
  }
}


void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if (acceleration < maxa) {
        acceleration += increase;
      }
      if (acceleration > maxa) {
        acceleration = maxa;
      }
    }
    if (keyCode == DOWN) {
      if (acceleration > mina) {
        acceleration -= increase;
      }
      if (acceleration < mina) {
        acceleration = mina;
      }
    }
    if (keyCode == LEFT || keyCode == RIGHT) {
      while (points.size() > 1) {
        points.remove(1);
      }
      if (keyCode == RIGHT && depth < 6) {
        depth++;
      }
      if (keyCode == LEFT && depth > 1) {
        depth--;
      }
      populate(depth, 0);
    }
  }
  if (key == 'u' || key == 'U' || key == 'd' || key == 'D') {
    while (points.size() > 1) {
      points.remove(1);
    }
    if ((key == 'u' || key == 'U') && vertices < 11) {
      vertices++;
    }
    if ((key == 'd' || key == 'D') && vertices > 1) {
      vertices--;
    }
    populate(depth, 0);
  }
  if (key == 'p' || key == 'P') {
    acceleration = 0;
  }
  if (key == 'w' || key == 'W') {
    acceleration2 += 0.2;
    while (points.size() > 1) {
      points.remove(1);
    }
    populate(depth, 0);
  }
  if (key == 's' || key == 'S') {
    acceleration2 -= 0.2;
    while (points.size() > 1) {
      points.remove(1);
    }
    populate(depth, 0);
  }
  if (key == '8' || key == '8') {
    base += 0.2;
    while (points.size() > 1) {
      points.remove(1);
    }
    populate(depth, 0);
  }
  if (key == '2' || key == '2') {
    base -= 0.2;
    while (points.size() > 1) {
      points.remove(1);
    }
    populate(depth, 0);
  }
    if (key == '6') {
    decrease += 0.2;
    while (points.size() > 1) {
      points.remove(1);
    }
    populate(depth, 0);
  }
  if (key == '4' || key == '4') {
    decrease -= 0.2;
    while (points.size() > 1) {
      points.remove(1);
    }
    populate(depth, 0);
  }
}
