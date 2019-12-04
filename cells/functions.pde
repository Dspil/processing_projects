void collision(food a, food b) {
  if (dist(a.x, a.y, b.x, b.y) < a.radius + b.radius) {
    float tempxspeeda = 2 * b.mass * b.xspeed;
    float tempyspeeda = 2 * b.mass * b.yspeed;
    float tempxspeedb = 2 * a.mass * a.xspeed;
    float tempyspeedb = 2 * a.mass * a.yspeed;
    float tempax = a.xspeed;
    float tempay = a.yspeed;
    a.xspeed *= (a.mass - b.mass);
    a.yspeed *= (a.mass - b.mass);
    a.xspeed += tempxspeeda;
    a.yspeed += tempyspeeda;
    a.xspeed /= a.mass + b.mass;
    a.yspeed /= a.mass + b.mass;
    b.xspeed *= (b.mass - a.mass);
    b.yspeed *= (b.mass - a.mass);
    b.xspeed += tempxspeedb;
    b.yspeed += tempyspeedb;
    b.xspeed /= a.mass + b.mass;
    b.yspeed /= a.mass + b.mass;
    float tempx = a.x - b.x;
    float tempy = a.y - b.y;
    tempx = (tempx / dist(a.x, a.y, b.x, b.y)) * (a.radius + b.radius) - tempx;
    tempy = (tempy / dist(a.x, a.y, b.x, b.y)) * (a.radius + b.radius) - tempy;
    a.x += tempx/2;
    a.y += tempy/2;
    b.x -= tempx/2;
    b.y -= tempy/2;
  }
}


void eat(cell a, food b) {
  if (dist(a.x, a.y, b.x, b.y) < a.size + b.radius) {
    a.size += b.radius / 3;
    a.size = constrain(a.size, 3, a.maxsize);
    b.existance = false;
  }
}


void bisect(cell a) {
  if (a.age > a.maturepoint) {
    if (a.size > a.maxsize/2.0) {
      if (a.isInfected == false) {
        cells.add(new cell(constrain(a.r + int(random(-5,5)), 0, 250), constrain(a.g + int(random(-5,5)), 0, 250), constrain(a.b + int(random(-5,5)), 0, 250), a.size / 2, a.x, a.y, a.speed0 + random(-0.2, 0.2), constrain(a.maxsize + random(-1, 1), 6.1, 1000), a.possibilityOfInfection + random(-1, 1)));
        updateGraph();
        cells.add(new cell(constrain(a.r + int(random(-5,5)), 0, 250), constrain(a.g + int(random(-5,5)), 0, 250), constrain(a.b + int(random(-5,5)), 0, 250), a.size / 2, a.x, a.y, a.speed0 + random(-0.2, 0.2), constrain(a.maxsize + random(-1, 1), 6.1, 1000), a.possibilityOfInfection + random(-1, 1)));
        updateGraph();
        a.existance = false;
      }
      else {
        cells.add(new cell(a.r, a.g, a.b, a.size / 2, a.x, a.y, a.speed0 + random(-0.2, 0.2), constrain(a.maxsize + random(-1, 1), 6.1, 1000), a.possibilityOfInfection + random(-1, 1)));
        updateGraph();
        cells.add(new cell(a.r, a.g, a.b, a.size / 2, a.x, a.y, a.speed0 + random(-0.2, 0.2), constrain(a.maxsize + random(-1, 1), 6.1, 1000), a.possibilityOfInfection + random(-1, 1)));
        updateGraph();
        a.existance = false;
        viruses.add(new virus(a.cellVirus.r, a.cellVirus.g, a.cellVirus.b, a.cellVirus.x + 20, a.cellVirus.y + 20, a.cellVirus.speed + random(-0.1, 0.1), a.cellVirus.power + random(-1, 1)));
        a.cellVirus.hoast = ((cell)cells.get(cells.size() - 1));
        ((virus)viruses.get(viruses.size() - 1)).hoast = ((cell)cells.get(cells.size() - 2));
        ((virus)viruses.get(viruses.size() - 1)).cellInfected = true;
        ((virus)viruses.get(viruses.size() - 1)).age = a.cellVirus.age - 0.01;
        ((cell)cells.get(cells.size() - 1)).isInfected = true;
        ((cell)cells.get(cells.size() - 1)).cellVirus = a.cellVirus;
        ((cell)cells.get(cells.size() - 2)).isInfected = true;
        ((cell)cells.get(cells.size() - 2)).cellVirus = ((virus)viruses.get(viruses.size() - 1));
      }
    }
  }
}

/*void fagocytosis(cell a, cell b) {
 if (a.size + b.size > dist(a.x, a.y, b.x, b.y)) {
 if (a.size > 2 * b.size) {
 a.size += b.size / 3;
 a.size = constrain(a.size, 0, a.maxsize);
 b.existance = false;
 }
 if (b.size > 2 * a.size) {
 b.size += a.size / 3;
 b.size = constrain(b.size, 0, b.maxsize);
 a.existance = false;
 }
 }
 }*/

void fagocytosis(cell a, virus b) {
  if (b.cellInfected && a.size + (b.hoast).size > dist(a.x, a.y, (b.hoast).x, (b.hoast).y) && a.Tcell) {
    if (a.size > 2 * (b.hoast).size) {
      a.size += (b.hoast).size / 3;
      a.size = constrain(a.size, 0, a.maxsize);
      (b.hoast).existance = false;
      b.existance = false;
    }
  }
}


void cellCollision(cell a, cell b) {
  if (dist(a.x, a.y, b.x, b.y) < a.size + b.size) {
    float tempx = a.x - b.x;
    float tempy = a.y - b.y;
    tempx = (tempx / dist(a.x, a.y, b.x, b.y)) * (a.size + b.size) - tempx;
    tempy = (tempy / dist(a.x, a.y, b.x, b.y)) * (a.size + b.size) - tempy;
    a.x += tempx/2;
    a.y += tempy/2;
    b.x -= tempx/2;
    b.y -= tempy/2;
  }
}


void virusCollision(virus a, virus b) {
  if (dist(a.x, a.y, b.x, b.y) < a.size + b.size) {
    float tempx = a.x - b.x;
    float tempy = a.y - b.y;
    tempx = (tempx / dist(a.x, a.y, b.x, b.y)) * (a.size + b.size) - tempx;
    tempy = (tempy / dist(a.x, a.y, b.x, b.y)) * (a.size + b.size) - tempy;
    a.x += tempx/2;
    a.y += tempy/2;
    b.x -= tempx/2;
    b.y -= tempy/2;
  }
}


void infect(cell a, virus b) {
  if (dist(a.x, a.y, b.x, b.y) < a.size + b.size && a.isInfected == false && b.cellInfected == false) {
    if (b.power > a.possibilityOfInfection && !a.Tcell) {
      a.isInfected = true;
      a.cellVirus = b;
      b.cellInfected = true;
      b.hoast = a;
      b.age = 0;
    }
    else {
      b.identities.append(a.identity);
    }
  }
}


int newIdentity() {
  cellIdentity++;
  return cellIdentity;
}


boolean nonInfectedCell(virus v) {
  boolean a = false;
  for (int i = 0; i < cells.size(); i++) {
    if (((cell)cells.get(i)).isInfected == false && identityCheck(v, (cell)cells.get(i)) == true) {
      a = true;
      break;
    }
  }
  return a;
}


void reproduceOrDie(virus a) {
  if (a.cellInfected == false) {
    if (a.age > a.diepoint) {
      a.existance = false;
    }
  }
  else {
    if (a.age > a.reproducepoint) {
      a.age = 0;
      (a.hoast).existance = false;
      a.cellInfected = false;
      a.existance = false;
      viruses.add(new virus(a.r, a.g, a.b, a.x + 10, a.y + 10, a.speed + random(-0.1, 0.1), a.power + random(-1, 1)));
      viruses.add(new virus(a.r, a.g, a.b, a.x - 10, a.y - 10, a.speed + random(-0.1, 0.1), a.power + random(-1, 1)));
    }
  }
}


boolean identityCheck(virus a, cell b) {
  boolean answer = true;
  for (int i = 0; i < (a.identities).size(); i++) {
    if (a.identities.get(i) == b.identity) {
      answer = false;
      break;
    }
  }
  return answer;
}


void updateGraph() {
  graph.append(((cell)cells.get(cells.size() - 1)).speed0);
  graph2.append(((cell)cells.get(cells.size() - 1)).maxsize);
  graph3.append(((cell)cells.get(cells.size() - 1)).maturepoint);
  graph4.append(((cell)cells.get(cells.size() - 1)).possibilityOfInfection);
}

void updateMeanGraph() {
  if (cells.size() > 0) {
    graph5.append(meanSpeed());
    graph6.append(meanSize());
    graph7.append(meanMaturePoint());
    graph8.append(meanInfectionChance());
  }
}

float meanSpeed(){
  float mSpeed = 0;
  for (int i = 0; i < cells.size(); i++) {
    mSpeed += ((cell)cells.get(i)).speed0;
  }
  mSpeed /= cells.size();
  return mSpeed; 
}

float meanSize(){
  float mSize = 0;
  for (int i = 0; i < cells.size(); i++) {
    mSize += ((cell)cells.get(i)).maxsize;
  }
  mSize /= cells.size();
  return mSize;
}

float meanMaturePoint(){
  float mmpoint = 0;
  for (int i = 0; i < cells.size(); i++) {
    mmpoint += ((cell)cells.get(i)).maturepoint;
  }
  mmpoint /= cells.size();
  return mmpoint;
}

float meanInfectionChance(){
  float mpoi = 0;
  for (int i = 0; i < cells.size(); i++) {
    mpoi += ((cell)cells.get(i)).possibilityOfInfection;
  }
  mpoi /= cells.size();
  return mpoi;
}

int graphControl() {
  if (!loopControl) {
    if (gC == graphs) {
      gC = 1;
    }
    else {
      gC++;
    }
  }
  println(gC);
  return gC;
}

void printGraph1(FloatList graphx, boolean seeLines, String xaxis, String yaxis) {
  if (graphx.size() > 1) {
    FloatList ghostgraph = new FloatList();
    for (int i = 0; i < graphx.size(); i++) {
      if (graphx.get(i) != 0) {
        ghostgraph.append(graphx.get(i));
      }
    }
    if (ghostgraph.size() > 1) {
      float maxval = 0;
      float minval = 100;
      float xstep = (width - 70) / float(ghostgraph.size() - 1);
      stroke(0);
      background(255);
      line(35, height - 35, width - 35, height - 35);
      line(35, height - 35, 35, 35);
      fill(0);
      text(yaxis, 5, 15);
      text(xaxis, width - 40, height - 12);
      for (int i = 0; i < ghostgraph.size(); i++) {
        if (ghostgraph.get(i) > maxval) {
          maxval = ghostgraph.get(i);
        }
        if (ghostgraph.get(i) < minval) {
          minval = ghostgraph.get(i);
        }
      }
      for (int i = 0; i < ghostgraph.size(); i++) {
        if (i < ghostgraph.size() - 1) {
          if (seeLines) {
            stroke(0);
            line(i * xstep + 35, height - map(ghostgraph.get(i), minval, maxval, 35, height - 35), (i + 1) * xstep + 35, height - map(ghostgraph.get(i + 1), minval, maxval, 35, height - 35));
          }
          fill(100, 0, 0);
          noStroke();
          ellipse(i * xstep + 35, height - map(ghostgraph.get(i), minval, maxval, 35, height - 35), 7, 7);
        }
      }
      ellipse((ghostgraph.size() - 1) * xstep + 35, height - map(ghostgraph.get((ghostgraph.size() - 1)), minval, maxval, 35, height - 35), 7, 7);
      fill(0);
      text("(0, " + round(minval * 100) / 100.0 + ")", 5, height - 12);
      text("" + round(maxval * 100) / 100.0, 3, 40);
    }
  }
}


void printGraph() {
  int x = graphControl();
  switch(x) {
  case 1:
    printGraph1(graph, false, "Cell", "Speed");
    break;
  case 2:
    printGraph1(graph2, false, "Cell", "Size");
    break;
  case 3:
    printGraph1(graph3, false, "Cell", "MaturePoint");
    break;
  case 4:
    printGraph1(graph4, false, "Cell", "InfectionChance");
    break;
  case 5:
    printGraph1(graph5, true, "Time", "MeanSpeed");
    break;
  case 6:
    printGraph1(graph6, true, "Time", "MeanSize");
    break;
  case 7:
    printGraph1(graph7, true, "Time", "MeanMaturePoint");
    break;
  case 8:
    printGraph1(graph8, true, "Time", "MeanInfectionChance");
    break;
  }
}

float minCellSpeed() {
  float minSpeed = 1000;
  for (int i = 0; i < cells.size(); i++) {
    if (((cell)cells.get(i)).speed0 < minSpeed) {
      minSpeed = ((cell)cells.get(i)).speed0;
    }
  }
  return minSpeed;
}

float maxCellSpeed() {
  float maxSpeed = 0;
  for (int i = 0; i < cells.size(); i++) {
    if (((cell)cells.get(i)).speed0 > maxSpeed) {
      maxSpeed = ((cell)cells.get(i)).speed0;
    }
  }
  return maxSpeed;
}

float minPossibilityOfInfection() {
  float minPSI = 0;
  for (int i = 0; i < cells.size(); i++) {
    if (((cell)cells.get(i)).possibilityOfInfection < minPSI) {
      minPSI = ((cell)cells.get(i)).possibilityOfInfection;
    }
  }
  return minPSI;
}

float maxPossibilityOfInfection() {
  float maxPSI = 0;
  for (int i = 0; i < cells.size(); i++) {
    if (((cell)cells.get(i)).possibilityOfInfection > maxPSI) {
      maxPSI = ((cell)cells.get(i)).possibilityOfInfection;
    }
  }
  return maxPSI;
}

