ArrayList triangles = new ArrayList();
int mgeneration = 8;
int maxgen = 1;
boolean going = true;

void setup() {
  size(displayWidth, displayHeight);
  triangles.add(new tri(width / 2, height  - 3 * (height / 2.0 - 20) / 4, height / 1.7, true, 1));
}

void draw() {
  for (int i = 0; i < triangles.size(); i++) {
    if (!((tri)triangles.get(i)).existance) {
      triangles.remove(i);
    }
  }
  maxgen = ((tri)triangles.get(triangles.size() - 1)).generation;
  int siz = triangles.size();
  fill(0,10);
  rectMode(CORNERS);
  rect(-1,-1,width + 1, height + 1);
  for (int i = 0; i < siz; i++) {
    ((tri)triangles.get(i)).act();
  }
  if (mgeneration == maxgen) {
    going = false;
  }
}

class tri {
  float x, y, x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, x6, y6, dx1, dy1, dx2, dy2, dx3, dy3, gx1, gy1, gx2, gy2, gx3, gy3, size, angle1, size1, speed;
  boolean angle2, turned, existance, starting;
  int generation, counter, counterlim;

  tri(float tempx, float tempy, float tempsize, boolean tempangle2, int tempgeneration) {
    speed = 90.0 / sqrt(tempgeneration);
    x = tempx;
    y = tempy;
    size = tempsize;
    size1 = tempsize;
    angle2 = tempangle2;
    generation = tempgeneration;
    angle1 = angle2? HALF_PI : 3 * HALF_PI;
    x1 = x;
    y1 = y - size;
    x2 = x + cos(PI / 6) * size;
    y2 = y + size / 2;
    x3 = x - cos(PI / 6) * size;
    y3 = y + size / 2;
    x4 = (x1 + x2) / 2.0;
    y4 = (y1 + y2) / 2.0;
    x5 = (x2 + x3) / 2.0;
    y5 = (y2 + y3) / 2.0;
    x6 = (x3 + x1) / 2.0;
    y6 = (y3 + y1) / 2.0;
    dx1 = abs(x4 - x1) / speed;
    dy1 = abs(y4 - y1) / speed;
    dx2 = -abs(x2 - x5) / speed;
    dy2 = 0;
    dx3 = abs(x1 - x6) / speed;
    dy3 = -abs(y6 - y1) / speed;
    gx1 = x1;
    gy1 = y1;
    gx2 = x2;
    gy2 = y2;
    gx3 = x3;
    gy3 = y3;
    existance = true;
    turned = false;
    starting = true;
    counter = 0;
    counterlim = generation >= mgeneration? 0 : 50;
  }

  void display() {
    stroke(0,150,255);
    noFill();
    triangle(x1, y1, x2, y2, x3, y3);
    if (x1 != gx1) {
      triangle(gx1, gy1, gx2, gy2, gx3, gy3);
    }
  }

  void turn() {
    if (!turned) {
      if (starting) {
        counter++;
        if (counter == counterlim) {
          starting = false;
        }
      }
      else {
        gx1 += dx1;
        gy1 += dy1;
        gx2 += dx2;
        gy2 += dy2;
        gx3 += dx3;
        gy3 += dy3;
        if (gx1 >= x4) {
          if (generation != mgeneration) {
            starting = true;
            counter = 0;
          }
          gx1 = x4;
          gx2 = x5;
          gx3 = x6;
          gy1 = y4;
          gy2 = y5;
          gy3 = y6;
          turned = true;
          if (generation != mgeneration) {
            triangles.add(new tri(x, y - size / 2.0, size / 2.0, true, generation + 1));
            triangles.add(new tri(x + cos(PI / 6) * size / 2.0, y + size / 4.0, size / 2.0, true, generation + 1));
            triangles.add(new tri(x - cos(PI / 6) * size / 2.0, y + size / 4.0, size / 2.0, true, generation + 1));
          }
        }
      }
    }
  }

  void back() {
    if (generation == maxgen) {
      if (starting) {
        counter++;
        if (counter >= counterlim) {
          starting = false;
          counter = 0;
        }
      }
      else {
        gx1 -= dx1;
        gy1 -= dy1;
        gx2 -= dx2;
        gy2 -= dy2;
        gx3 -= dx3;
        gy3 -= dy3;
        if (gx1 <= x1) {
          if (generation != 1) {
            gx1 = x1;
            gy1 = y1;
            gx2 = x2;
            gy2 = y2;
            gx3 = x3;
            gy3 = y3;
            existance = false;
          }
          else {
            gx1 = x1;
            gy1 = y1;
            gx2 = x2;
            gy2 = y2;
            gx3 = x3;
            gy3 = y3;
            going = true;
            starting = true;
            counter = 0;
            turned = false;
          }
        }
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

/*void draw() {
 if (prevdepth != depth || starting) {
 background(0);
 noFill();
 stroke(255);
 sierpinski(depth, width / 2.0, height / 2.0, height / 2.0 - 20);
 prevdepth = depth;
 starting = false;
 }
 }
 
 void sierpinski(int level, float x, float y, float size) {
 if (level == 1) {
 triangle(x, y - size, x + cos(PI / 6) * size, y + size / 2, x - cos(PI / 6) * size, y + size / 2);
 }
 else {
 sierpinski(level - 1, x, y - size / 2.0, size / 2.0);
 sierpinski(level - 1, x + cos(PI / 6) * size / 2.0, y + size / 4.0, size / 2.0);
 sierpinski(level - 1, x - cos(PI / 6) * size / 2.0, y + size / 4.0, size / 2.0);
 }
 }
 
 
 void keyPressed() {
 if (key == 'u' || key == 'U') {
 depth = constrain(depth + 1, 1, 11);
 }
 if (key == 'd' || key == 'D') {
 depth = constrain(depth - 1, 1, 11);
 }
 }*/
