ArrayList cells = new ArrayList();
ArrayList colonies = new ArrayList();
ArrayList foods = new ArrayList();
ArrayList viruses = new ArrayList();
FloatList graph = new FloatList();
FloatList graph2 = new FloatList();
FloatList graph3 = new FloatList();
FloatList graph4 = new FloatList();
FloatList graph5 = new FloatList();
FloatList graph6 = new FloatList();
FloatList graph7 = new FloatList();
FloatList graph8 = new FloatList();
int graphs = 8;
int foodControl = 0;
int foodLimit = 2000;
int foodControl1 = 2;
int foodControl2 = 0;
int virusControl = 0;
int virusControl1 = 0;
int virusLimit = 3;
int timer = 0;
int timer1 = 1000;
boolean loopControl = true;
boolean graphPrinted = false;
PFont f;
int cellIdentity = 0;
int gC = 0;
float speedControl = 1;

void setup() {
  //size(1000, 540);
  size(displayWidth, displayHeight);
  f = createFont("Arial", 13, true);
  for (int i = 0; i < 20; i++) {
    cells.add(new cell(random(0, 255), random(0, 255), random(0, 255), random(7, 13), random(0, width), random(0, height), random(3, 6.0), random(20, 25), random(6, 8)));
    //updateGraph();
  }
  for (int i = 0; i < 0; i++) {
    viruses.add(new virus(random(0, 200), random(0, 200), random(0, 200), random(0, width), random(0, height), random(2, 4), random(5, 8)));
  }
  for (int i = 0; i < 60; i++) {
    foods.add(new food(random(0, 200), random(0, 200), random(0, 200), random(0, width), random(0, height), 0, 0, random(2, 4)));
  }
}

void draw() {
  if (loopControl == true) {
    background(255);
    for (int i = 0; i < cells.size(); i++) {
      float mindist = width * width + height * height;
      int minj = 0;
      boolean VorF = false;
      for (int j = 0; j < foods.size(); j++) {
        if (dist(((cell)cells.get(i)).x, ((cell)cells.get(i)).y, ((food)foods.get(j)).x, ((food)foods.get(j)).y) < mindist) {
          mindist = dist(((cell)cells.get(i)).x, ((cell)cells.get(i)).y, ((food)foods.get(j)).x, ((food)foods.get(j)).y);
          minj = j;
        }
      }
      if (((cell)cells.get(i)).Tcell == true) {
        for (int j = 0; j < viruses.size(); j++) {
          if (dist(((cell)cells.get(i)).x, ((cell)cells.get(i)).y, ((virus)viruses.get(j)).x, ((virus)viruses.get(j)).y) < mindist && ((virus)viruses.get(j)).cellInfected == true && (((virus)viruses.get(j)).hoast).size < ((cell)cells.get(i)).size / 2) {
            mindist = dist(((cell)cells.get(i)).x, ((cell)cells.get(i)).y, ((virus)viruses.get(j)).x, ((virus)viruses.get(j)).y);
            minj = j;
            VorF = true;
          }
        }
      }
      if (((cell)cells.get(i)).Tcell == false || VorF == false) {
        if (cells.size() > 0 && foods.size() > 0) {
          float newangle = asin((((food)foods.get(minj)).y - ((cell)cells.get(i)).y) / mindist);
          if (((food)foods.get(minj)).x < ((cell)cells.get(i)).x) {
            newangle = PI - newangle;
          }
          ((cell)cells.get(i)).turn(newangle);
        }
      }
      else {
        if (cells.size() > 0 && viruses.size() > 0) {
          float newangle = asin((((virus)viruses.get(minj)).y - ((cell)cells.get(i)).y) / mindist);
          if (((virus)viruses.get(minj)).x < ((cell)cells.get(i)).x) {
            newangle = PI - newangle;
          }
          ((cell)cells.get(i)).turn(newangle);
        }
      }
    }
    for (int i = 0; i < viruses.size(); i++) {
      if (((virus)viruses.get(i)).cellInfected == false) {
        float mindist2 = width * width + height * height;
        int minj2 = 0;
        for (int j = 0; j < cells.size(); j++) {
          if (dist(((virus)viruses.get(i)).x, ((virus)viruses.get(i)).y, ((cell)cells.get(j)).x, ((cell)cells.get(j)).y) < mindist2 && ((cell)cells.get(j)).isInfected == false && identityCheck((virus)viruses.get(i), (cell)cells.get(j)) == true) {
            mindist2 = dist(((virus)viruses.get(i)).x, ((virus)viruses.get(i)).y, ((cell)cells.get(j)).x, ((cell)cells.get(j)).y);
            minj2 = j;
          }
        }
        if (viruses.size() > 0 && cells.size() > 0 && nonInfectedCell((virus)viruses.get(i)) == true) {
          float newangle2 = asin((((cell)cells.get(minj2)).y - ((virus)viruses.get(i)).y) / mindist2);
          if (((cell)cells.get(minj2)).x < ((virus)viruses.get(i)).x) {
            newangle2 = PI - newangle2;
          }
          ((virus)viruses.get(i)).turn(newangle2);
        }
      }
    }
    timer += 1;
    if (timer == timer1) {
      timer = 0;
      updateMeanGraph();
    }
    foodControl += 1;
    if (foodControl == foodControl1 * speedControl) {
      if (foods.size() < foodLimit) {
        foods.add(new food(random(0, 200), random(0, 200), random(0, 200), random(0, width), random(0, height), 0, 0, random(2, 4)));
      }
      foodControl = 0;
    }
    foodControl2 += 1;
    if (foodControl2 == 1000000 * speedControl) {
      foodControl1 += 1;
      foodControl2 = 0;
    }
    virusControl += 1;
    if (virusControl == virusControl1 * speedControl){
      if (viruses.size() < virusLimit){
        viruses.add(new virus(random(0, 200), random(0, 200), random(0, 200), random(0, width), random(0, height), random(minCellSpeed(), maxCellSpeed()), random(minPossibilityOfInfection() - 1, maxPossibilityOfInfection())));
      }
      virusControl = 0;
    }
    for (int i = 0; i < cells.size(); i++) {
      ((cell)cells.get(i)).move();
      ((cell)cells.get(i)).grow();
      ((cell)cells.get(i)).display();
    }
    for (int i = 0; i < foods.size(); i++) {
      ((food)foods.get(i)).move();
      ((food)foods.get(i)).display();
    }
    for (int i = 0; i < viruses.size(); i++) {
      ((virus)viruses.get(i)).move();
      ((virus)viruses.get(i)).grow();
      ((virus)viruses.get(i)).display();
    }
    for (int j = 0; j < cells.size(); j++) {
      for (int k = 0; k < foods.size(); k++) {
        eat((cell)cells.get(j), (food)foods.get(k));
      }
    }
    for (int j = 0; j < viruses.size(); j++) {
      for (int k = 0; k < cells.size(); k++) {
        infect((cell)cells.get(k), (virus)viruses.get(j));
        fagocytosis((cell)cells.get(k), (virus)viruses.get(j));
      }
    }
    for (int i = 0; i < viruses.size(); i++) {
      reproduceOrDie((virus)viruses.get(i));
    }
    for (int i = 0; i < foods.size(); i++) {
      if (((food)foods.get(i)).existance == false) {
        foods.remove(i);
      }
    }
    for (int j = 0; j < cells.size(); j++) {
      for (int k = j + 1; k < cells.size(); k++) {
        cellCollision((cell)cells.get(j), (cell)cells.get(k));
      }
    }
    for (int j = 0; j < viruses.size(); j++) {
      for (int k = j + 1; k < viruses.size(); k++) {
        virusCollision((virus)viruses.get(j), (virus)viruses.get(k));
      }
    }
    for (int i = 0; i < cells.size(); i++) {
      if (((cell)cells.get(i)).existance == false) {
        cells.remove(i);
      }
    }
    for (int i = 0; i < cells.size(); i++) {
      if (((cell)cells.get(i)).age > ((cell)cells.get(i)).diepoint) {
        if (((cell)cells.get(i)).isInfected == true) {
          ((cell)cells.get(i)).cellVirus.age = 0;
          ((cell)cells.get(i)).cellVirus.cellInfected = false;
        }
        graph.set(((cell)cells.get(i)).identity - 1, 0);
        cells.remove(i);
      }
    }
    for (int i = 0; i < viruses.size(); i++) {
      if (((virus)viruses.get(i)).existance == false) {
        viruses.remove(i);
      }
    }
    for (int i = 0; i < cells.size(); i++) {
      bisect((cell)cells.get(i));
    }
    for (int i = 0; i < cells.size(); i++) {
      if (((cell)cells.get(i)).speed0 / speedControl > 10) {
        speedControl++;
      }
    }
  }
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    foods.add(new food(random(0, 200), random(0, 200), random(0, 200), float(mouseX), float(mouseY), random(-5.0, 5.0), random(-5.0, 5.0), random(2, 4)));
  }
  else {
    cells.add(new cell(random(0, 255), random(0, 255), random(0, 255), random(7, 13), float(mouseX), float(mouseY), random(3, 6.0), random(20, 25), random(6, 8)));
    updateGraph();
  }
}

void keyPressed() {
  if (key == 'P' || key == 'p') {
    loopControl = !loopControl;
    if (loopControl == true) {
      graphPrinted = false;
      gC = 0;
    }
  }
  if (key == 'V' || key == 'v') {
    viruses.add(new virus(random(0, 200), random(0, 200), random(0, 200), random(0, width), random(0, height), random(minCellSpeed(), maxCellSpeed()), random(minPossibilityOfInfection() - 1, maxPossibilityOfInfection())));
  }
  if (key == 'd' || key == 'D') {
    viruses.add(new virus(random(0, 200), random(0, 200), random(0, 200), random(0, width), random(0, height), maxCellSpeed() + 5, maxPossibilityOfInfection() + 100));
  }
  if (key == 'G' || key == 'g') {
    if (loopControl == false) {
      printGraph();
      if (gC == graphs + 1) {
        graphPrinted = false;
      }
      else {
        graphPrinted = true;
      }
    }
  }
}


void mouseMoved() {
  if (loopControl == false) {
    if (graphPrinted == false) {
      background(255);
      for (int j = 0; j < cells.size(); j++) {
        ((cell)cells.get(j)).display();
      }
      for (int k = 0; k < foods.size(); k++) {
        ((food)foods.get(k)).display();
      }
      for (int k = 0; k < viruses.size(); k++) {
        ((virus)viruses.get(k)).display();
      }
      for (int i = 0; i < cells.size(); i++) {
        if (mouseX > ((cell)cells.get(i)).x - ((cell)cells.get(i)).size && mouseX < ((cell)cells.get(i)).x + ((cell)cells.get(i)).size && mouseY > ((cell)cells.get(i)).y - ((cell)cells.get(i)).size && mouseY < ((cell)cells.get(i)).y + ((cell)cells.get(i)).size) {
          rectMode(CORNER);
          fill(255);
          rect(constrain(mouseX, 0, width - 180), constrain(mouseY + 35, 0, height - 20) - 13, 180, 30);
          fill(0);
          text("velocity: " + round(100 * ((cell)cells.get(i)).speed0) / 100.0 + ", maxsize:" + round(100 * ((cell)cells.get(i)).maxsize) / 100.0 + "\n" + "maturePoint: " + round(100 * ((cell)cells.get(i)).maturepoint) / 100.0 + ", diePoint: " + round(100 * ((cell)cells.get(i)).diepoint) / 100.0 + ".", constrain(mouseX, 0, width - 180), constrain(mouseY + 35, 0, height - 20));
        }
      }
    }
  }
}

