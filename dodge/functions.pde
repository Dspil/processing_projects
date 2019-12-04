float angleToHero(float x, float y) {
  if (x == babis.x) {
    if (y > babis.y) {
      return HALF_PI * 3;
    }
    else {
      return HALF_PI;
    }
  }
  else {
    float tangent = (babis.y - y) / (babis.x - x);
    float angle = atan(tangent);
    if (babis.x < x) {
      angle -= PI;
    }
    return angle;
  }
}

void displayLife() {
  rectMode(CORNERS);
  noFill();
  stroke(0);
  rect(0, 0, width, 20 * displayWidth / 1366);
  fill(200, 0, 0);
  rect(0, 0, width / float(babis.life0) * babis.life, 20 * displayWidth / 1366);
}

void displayBossLife() {
  rectMode(CORNERS);
  noFill();
  stroke(0);
  rect(width - 20 * displayWidth / 1366, 20 * displayWidth / 1366, width, height);
  fill(0, 150, 0, 200);
  rect(width - 20 * displayWidth / 1366, height - 20 * displayWidth / 1366 - (height - 20 * displayWidth / 1366) / 50 * ((bossenemy)bossenemies.get(0)).life, width, height);
}

void displayScore() {
  textFont(f4);
  fill(255);
  textAlign(LEFT);
  text("Score: " + str(Points), 5, height - (height / 120 + 5));
}
  

void bisect(enemy a) {
  if (a.age > a.reproducepoint && a.reproduceControl >= a.canReproduce) {
    enemies.add(new enemy(a.x, a.y, a.boltControl + int(random(-5, 5)), a.boltSpeed + constrain(random(-1, 1), 0.1, 1000), a.damage + random(-2, 2), a.maxSpeed + constrain(random(-0.5, 0.5), 2, 1000), a.diepoint + int(random(-10, 10)), a.reproducepoint + int(random(-10, 10)), a.r, a.g, a.b, a.speed0 + random(-2, 2), a.life0 + random(-5, 5), a.canReproduce + constrain(int(random(-1, 1)), 2, 1000)));
    enemies.add(new enemy(a.x, a.y, a.boltControl + int(random(-5, 5)), a.boltSpeed + constrain(random(-1, 1), 0.1, 1000), a.damage + random(-2, 2), a.maxSpeed + constrain(random(-0.5, 0.5), 2, 1000), a.diepoint + int(random(-10, 10)), a.reproducepoint + int(random(-10, 10)), a.r, a.g, a.b, a.speed0 + random(-2, 2), a.life0 + random(-5, 5), a.canReproduce + constrain(int(random(-1, 1)), 2, 1000)));
    a.existance = false;
    enemy b = ((enemy)enemies.get(enemies.size() - 1));
    enemy c = ((enemy)enemies.get(enemies.size() - 2));
    if (b.maxSpeed > babis.speed0 || c.maxSpeed > babis.speed0) {
      babis.speed00 = (b.maxSpeed > c.maxSpeed)? (b.maxSpeed + 0.2) : (c.maxSpeed + 0.2);
      babis.speed0 = babis.speed00;
      bossspeed = babis.speed00;
    }
    if (b.maxSpeed > maxBoltSpeed || c.maxSpeed > maxBoltSpeed) {
      maxBoltSpeed = b.maxSpeed > c.maxSpeed ? b.maxSpeed : c.maxSpeed;
    }
  }
}

void thrower(enemy a) {
  if (a.boltControl1 == a.boltControl) {
    bolts.add(new bolt(a.x, a.y, a.boltSpeed, a.damage, a.maxSpeed, a.diepoint, a));
    a.boltControl1 = 0;
  }
  else {
    a.boltControl1 += 1;
  }
}

void bthrower(bossenemy a) {
  if (a.boltControl1 == a.boltControl) {
    bbolts.add(new bbolt(a.boltSpeed, a.damage, a.maxSpeed, a.diepoint, a));
    a.boltControl1 = 0;
  }
  else {
    a.boltControl1 += 1;
  }
}

int pointsOf(enemy a) {
  int b = 0;
  b += a.boltControl + int(a.boltSpeed) + int(a.damage) + int(a.maxSpeed) + int(a.diepoint) + int(a.life0);
  return b;
}

void score() {
  textFont(f1);
  fill(configuration? 0 : 255);
  stroke(0);
  textAlign(CENTER);
  String[] scores = loadStrings("scores.dodge");
  if (Points > int(scores[4])) {
    text("HIGHSCORE!\n" + str(Points), width / 2, height / 2);
    int[] a = new int[6];
    for (int i = 0; i < 5; i++) {
      a[i] = int(scores[i]);
    }
    a[5] = Points;
    a = sort(a);
    for (int i = 0; i < 5; i++) {
      scores[i] = str(a[5 - i]);
    }
  }
  else {
    text("SCORE\n" + str(Points), width / 2, height / 2);
  }
  saveStrings("scores.dodge", scores);
  textFont(f2);
  fill(100);
  rectMode(CENTER);
  rect(width / 2, height - (width / 30), width / 5, width / 30 + 5);
  fill(0);
  textAlign(CENTER);
  text("Play again", width / 2, height - (width / 30) + width / 120);
}

void displayMenu() {
  inmenu = true;
  background(255);
  String a;
  textAlign(CENTER);
  rectMode(CENTER);
  if (paused) {
    textFont(f3);
    fill(0);
    text("P to continue", width - 6 * width / 40, height - width / 40);
  }
  switch(menuMode) {
  case 0:
    fill(100);
    rect(width / 2, height / 2 - width / 30, width / 10, width / 30 + 5);
    rect(width / 2, height / 2 + width / 30, width / 5, width / 30 + 5);
    rect(width / 2, height - (width / 30), width / 5, width / 30 + 5);
    fill(0);
    textFont(f1);
    text("Menu", width / 2, height / 2 - width / 30 * 4);
    textFont(f2);
    text("Help", width / 2, height / 2  - width / 60 - width / 120);
    text("High Scores", width / 2, height / 2 + width / 20 - width / 120);
    text("New game", width / 2, height - (width / 30) + width / 120);
    break;
  case 1:
    background(255);
    String[] scores = loadStrings("scores.dodge");
    a = "High scores:";
    textFont(f2);
    fill(100);
    rectMode(CENTER);
    rect(width / 2, height - (width / 30), width / 10, width / 30 + 5);
    fill(0);
    textAlign(CENTER);
    text(a, width / 2, height / 2 - width / 6);
    for (int i = 0; i < 5; i++) {
      text(scores[i], width / 2, height / 2 - width / 6 + (i + 2) * width / 25);
    }
    text("Back", width / 2, height - (width / 30) + width / 120);
    break;
  case 2:
    background(255);
    textFont(f5);
    textAlign(LEFT);
    fill(0);
    text("Welcome to dodge!\nThe objective of the game is to avoid the bullets,\nand kill your enemies with these bullets.\nYour health is viewed at the top of the screen.\nEvery now and then enemies appear if their number is less than 10.\nEnemies can bisect and evolve if they hit you a certain number of times.\nThis characteristic as some others can change when evolving.\nTo move around use the arrow keys.\nTo enter and exit the menu press 'p'.\nThe 'new game' button at the menu starts a new game.\nPress 'p' to continue the game or click 'back' to enter the menu.\nPress 'esc' to exit.\nEvery 25.000 points there is a boss with special abilities that appears\nbut some shield powerups appear too to help you.", 20, width / 30);
    fill(100);
    rectMode(CENTER);
    rect(width / 2, height - (width / 30), width / 10, width / 30 + 5);
    fill(0);
    textAlign(CENTER);
    text("Back", width / 2, height - (width / 30) + width / 120);
    break;
  }
}

void menu(float x, float y) {
  switch(menuMode) {
  case 0: //mainmenu
    if (x > width / 2 - width / 10 && x < width / 2 + width / 10 && y > height / 2 + width / 30 - (width / 30 + 5) / 2 && y < height / 2 + width / 30 + (width / 30 + 5) / 2) {
      menuMode = 1;
    }
    if (x > width / 2 - width / 20 && x < width / 2 + width / 20 && y > height / 2 - width / 30 - (width / 30 + 5) / 2 && y < height / 2 - width / 30 + (width / 30 + 5) / 2) {
      menuMode = 2;
    }
    if (x > width / 2 - width / 10 && x < width / 2 + width / 10 && y > height - (width / 30) - (width / 30 + 5) / 2 && y < height - (width / 30) + (width / 30 + 5) / 2) {
      finished = false;
      babis.life = babis.life0;
      babis.speed00 = 10.2;
      babis.speed0 = babis.speed00;
      lastpointsboss = 0;
      babis.freezed = false;
      babis.countfreezed = 0;
      babis.shield = false;
      babis.countshield = 0;
      enemies.clear();
      bolts.clear();
      bbolts.clear();
      bbolts.clear();
      powerups.clear();
      bossenemies.clear();
      babis.x = width / 2;
      babis.y = height / 2;
      Points = 0;
      lastAngle = 0;
      enemies.add(new enemy(random(30, width - 30), random(30, height - 30), 100, 0.5, 5, 10, 500, 250, int(random(0, 250)), int(random(0, 250)), int(random(0, 250)), random(2, 3), random(30, 50), int(random(3, 4))));
      loopControl = true;
      inmenu = false;
    }
    break;
  case 1:
    if (x > width / 2 - width / 20 && x < width / 2 + width / 20 && y > height - width / 30 - (width / 30 + 5) / 2 && y < height - width / 30 + (width / 30 + 5) / 2) {
      menuMode = 0;
    }
    break;
  case 2:
    if (x > width / 2 - width / 20 && x < width / 2 + width / 20 && y > height - width / 30 - (width / 30 + 5) / 2 && y < height - width / 30 + (width / 30 + 5) / 2) {
      menuMode = 0;
    }
    break;
  }
}