ArrayList triangles = new ArrayList();
int mgeneration = 6;
int maxgen = 1;
boolean started = true;
boolean going = true;

void setup() {
  size(displayWidth, displayHeight);
  triangles.add(new tri(width / 2, height / 2, height / 2.0 - 20, true, 1));
}

void draw() {
  if (started){
  maxgen = ((tri)triangles.get(triangles.size() - 1)).generation;
  for (int i = 0; i < triangles.size(); i++) {
    if (!((tri)triangles.get(i)).existance) {
      triangles.remove(i);
    }
  }
  int siz = triangles.size();
  fill(0,20);
  rectMode(CORNERS);
  rect(-1,-1,width + 1, height + 1);
  for (int i = 0; i < siz; i++) {
    ((tri)triangles.get(i)).act();
  }
  if (mgeneration == maxgen) {
    going = false;
  }
  }
  else {
    background(0);
  }
}

class tri {
  float x, y, size, angle1;
  boolean angle2, turned, existance, starting;
  int generation, counter, counterlim;

  tri(float tempx, float tempy, float tempsize, boolean tempangle2, int tempgeneration) {
    x = tempx;
    y = tempy;
    size = tempsize;
    angle2 = tempangle2;
    generation = tempgeneration;
    angle1 = angle2? HALF_PI : 3 * HALF_PI;
    existance = true;
    turned = false;
    starting = true;
    counter = 0;
    counterlim = generation >= mgeneration? 0 : 50;
  }

  void turn() {
    if (!turned) {
      if (starting) {
        counter += sqrt(generation);
        if (counter >= counterlim) {
          starting = false;
        }
      }
      else {
        angle1 -= PI / 180 * sqrt(float(generation));
        if (angle2 && angle1 <= PI / 6 || !angle2 && angle1 <= 7 * PI / 6) {
          turned = true;
          if (generation != mgeneration) {
            starting = true;
            counter = 0;
          }
          angle1 = angle2? PI / 6 : 7 * PI / 6;
          if (generation != mgeneration) {
            triangles.add(new tri(x, y - 2 * size / 3, size / 3, angle2? angle2 : !angle2, generation + 1));
            triangles.add(new tri(x, y + 2 * size / 3, size / 3, angle2? !angle2 : angle2, generation + 1));
            triangles.add(new tri(x + 2 * cos(PI / 6) * size / 3, y - size / 3, size / 3, angle2? !angle2 : angle2, generation + 1));
            triangles.add(new tri(x - 2 * cos(PI / 6) * size / 3, y - size / 3, size / 3, angle2? !angle2 : angle2, generation + 1));
            triangles.add(new tri(x + 2 * cos(PI / 6) * size / 3, y + size / 3, size / 3, angle2? angle2 : !angle2, generation + 1));
            triangles.add(new tri(x - 2 * cos(PI / 6) * size / 3, y + size / 3, size / 3, angle2? angle2 : !angle2, generation + 1));
          }
        }
      }
    }
  }

  void back() {
    if (maxgen == generation) {
      if (starting) {
        counter += sqrt(generation);
        if (counter >= counterlim) {
          starting = false;
        }
      }
      else {
        angle1 += PI / 180 * sqrt(float(generation));
        if (angle2 && angle1 >= HALF_PI || !angle2 && angle1 >= 3 * HALF_PI) {
          if (generation != 1) {
            existance = false;
          }
          else {
            angle1 = HALF_PI;
            going = true;
            starting = true;
            counter = 0;
            turned = false;
          }
        }
      }
    }
  }


  void display() {
    if (existance) {
      noFill();
      stroke(0,150, 255);
      if (generation == 1) {
        triangle(x, angle2? y - size : y + size, x + cos(PI / 6) * size, angle2? y + size / 2 : y - size / 2, x - cos(PI / 6) * size, angle2? y + size / 2 : y - size / 2);
      }
      if (turned && going) {
        triangle(x, !angle2? y - size : y + size, x + cos(PI / 6) * size, !angle2? y + size / 2 : y - size / 2, x - cos(PI / 6) * size, !angle2? y + size / 2 : y - size / 2);
      }
      else if (angle1 != HALF_PI && angle1 != 3 * HALF_PI) {
        triangle(x + cos(angle1) * size, y - sin(angle1) * size, x + cos(angle1 + 2 * PI / 3) * size, y - sin(angle1 + 2 * PI / 3) * size, x + cos(angle1 - 2 * PI / 3) * size, y - sin(angle1 - 2 * PI / 3) * size);
      }
    }
  }

  void act() {
    if (going) {
      turn();
    }
    else {
      back();
    }
    display();
  }
}

void keyPressed() {
  if (key == 'u' || key == 'U') {
    mgeneration = constrain(mgeneration + 1, 1, 6);
    started = true;
  }
  if (key == 'd' || key == 'D') {
    mgeneration = constrain(mgeneration - 1, 1, 6);
  }
}

