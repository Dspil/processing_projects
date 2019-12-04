double x = 0;
double y = 0;
double scale = 0.7;
boolean changed = true;

void setup() {
  size(displayWidth, displayHeight);
}

void draw() {
  if (changed) {
    loadPixels();
    println(displayWidth);
    println(displayHeight);
    int analysis = 100, infinity = 2;
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        int end;
        double a = 0;
        double b = 0;
        double tempa;
        end = 0;
        for (int k = 0; k < analysis; k++) {
          tempa = a;
          a = a * a - b * b + map(i, 0, width, x - 2 * scale * width / height, x + 2 * scale * width / height);
          b  = 2 * tempa * b + map(j, 0, height, y - 2 * scale, y + 2 * scale);
          if (checkdist(0, 0, a, b, infinity)) {
            end = k;
            break;
          }
        } 
        pixels[i + j * width] = color(0,255 / analysis * end,255 / analysis * end);
      }
    }
    updatePixels();
    changed = false;
  }
}

double map(double n, double oldmin, double oldmax, double newmin, double newmax) {
  return (n - oldmin) / (oldmax - oldmin) * (newmax - newmin) + newmin;
}

boolean checkdist(double x, double y, double a, double b, double threshold) {
  return ((x - a) * (x - a) + (y - b) * (y - b) > threshold);
}

void keyPressed() {
  changed = true;
  if (key == CODED) {
    if (keyCode == UP) {
      y -= 1 * scale;
    }
    if (keyCode == DOWN) {
      y += 1 * scale;
    }
    if (keyCode == LEFT) {
      x += 0.1 * scale;
    }
    if (keyCode == RIGHT) {
      x -= 0.1 * scale;
    }
  }
  if (key == 'i' || key == 'I') {
    scale = scale / 10;
  }
  if (key == 'O' || key == 'o') {
    scale = scale * 10;
  }
}
    
      