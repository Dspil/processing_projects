int menuMode = 0;
boolean finished = false;
boolean configuration = false;
boolean loopControl = false;
PFont f1, f2, f3, f4, f5;
boolean up = false;
boolean down = false;
boolean right = false;
boolean left = false;
boolean paused = false;
boolean inmenu = false;
int Points = 0;
boolean lastxm = false;
boolean lastym = false;
int lastAngle = 0;
int enemiesControl = 0;
float maxBoltSpeed = 0.5;
float bossspeed = 10;
ArrayList bolts = new ArrayList();
ArrayList enemies = new ArrayList();
ArrayList deathEffects = new ArrayList();
ArrayList heroDeathEffects = new ArrayList();
ArrayList bossenemies = new ArrayList();
ArrayList bbolts = new ArrayList();
ArrayList powerups = new ArrayList();
int lastpointsboss = 0;
int powerupscontrol = 0;
hero babis;

void setup() {
  size(displayWidth, displayHeight);
  babis = new hero();
  f1 = createFont("CourierNewPS-BoldMT", width / 10, true);
  f2 = createFont("CourierNewPS-BoldMT", width / 30, true);
  f3 = createFont("CourierNewPS-BoldMT", width / 40, true);
  f4 = createFont("CourierNewPS-BoldMT", width / 60, true);
  f5 = createFont("CourierNewPS-BoldMT", width / 45, true);
  enemies.add(new enemy(random(30, width - 30), random(30, height - 30), 100, 0.5, 5, maxBoltSpeed, 500, 250, int(random(0, 250)), int(random(0, 250)), int(random(0, 250)), random(2, 3), random(30, 50), int(random(3, 4))));
  displayMenu();
}

void draw() {
  if (loopControl && !finished) {
    if (configuration) {
      background(0, 0, 255);
    }
    else {
      fill(0, 50);
      rectMode(CORNERS);
      rect(-1, -1, width+1, height+1);
      //background(0);
    }
    if (babis.life > 0) {
      displayLife();
      displayScore();
      if (bossenemies.size() > 0) {
        displayBossLife();
      }
      babis.move(up, down, left, right);
      babis.display(up, down, left, right, lastxm, lastym, lastAngle);
      enemiesControl += 1;
      if (enemiesControl == 500) {
        if (enemies.size() < 10) {
          enemies.add(new enemy(random(30, width - 30), random(30, height - 30), 100, 0.5, 5, random(8, 12), 500, 250, int(random(0, 250)), int(random(0, 250)), int(random(0, 250)), random(2, 3), random(30, 50), int(random(3, 4))));
          if (((enemy)enemies.get(enemies.size() - 1)).maxSpeed > babis.speed0) {
            babis.speed0 = ((enemy)enemies.get(enemies.size() - 1)).maxSpeed + 0.1;
          }
        }
        enemiesControl = 0;
      }
      for (int i = 0; i < bolts.size(); i++) {
        if (!((bolt)bolts.get(i)).existance) {
          bolts.remove(i);
        }
        else {
          ((bolt)bolts.get(i)).turnTo(angleToHero(((bolt)bolts.get(i)).x, ((bolt)bolts.get(i)).y));
          ((bolt)bolts.get(i)).move();
          ((bolt)bolts.get(i)).grow();
          ((bolt)bolts.get(i)).collide();
          ((bolt)bolts.get(i)).display();
        }
      }
      for (int i = 0; i < bbolts.size(); i++) {
        if (!((bbolt)bbolts.get(i)).existance) {
          bbolts.remove(i);
        }
        else {
          ((bbolt)bbolts.get(i)).turnTo(angleToHero(((bbolt)bbolts.get(i)).x, ((bbolt)bbolts.get(i)).y));
          ((bbolt)bbolts.get(i)).move();
          ((bbolt)bbolts.get(i)).grow();
          ((bbolt)bbolts.get(i)).collide();
          ((bbolt)bbolts.get(i)).display();
        }
      }
      if (Points - lastpointsboss > 25000 && bossenemies.size() < 1) {
        bossenemies.add(new bossenemy(50, 50));
      }
      if (bossenemies.size() > 0) {
        if (powerupscontrol > 500 && powerups.size() < 2) {
          powerups.add(new powerup(random(50, width - (50 * displayWidth / 1366)), random((50 * displayWidth / 1366), height - 50 * displayWidth / 1366), 15, 300, 0, 200, 250));
          powerupscontrol = 0;
        }
        powerupscontrol++;
      }
      for (int i = 0; i < powerups.size(); i++) {
        if (!((powerup)powerups.get(i)).existance) {
          powerups.remove(i);
        }
        else {
          ((powerup)powerups.get(i)).live();
        }
      }
      for (int i = 0; i < enemies.size(); i++) {
        if (!((enemy)enemies.get(i)).existance) {
          enemies.remove(i);
        }
        else {
          ((enemy)enemies.get(i)).grow();
          bisect(((enemy)enemies.get(i)));
          thrower(((enemy)enemies.get(i)));
          ((enemy)enemies.get(i)).move();
          ((enemy)enemies.get(i)).display();
        }
      }
      for (int i = 0; i < bossenemies.size(); i++) {
        if (!((bossenemy)bossenemies.get(i)).existance) {
          bossenemies.remove(i);
          lastpointsboss = Points;
        }
        else {
          bthrower(((bossenemy)bossenemies.get(i)));
          ((bossenemy)bossenemies.get(i)).decideDirection();
          ((bossenemy)bossenemies.get(i)).move();
          ((bossenemy)bossenemies.get(i)).display();
        }
      }
      for (int i = 0; i < deathEffects.size(); i++) {
        if (!((deathEffect)deathEffects.get(i)).existance) {
          deathEffects.remove(i);
        }
        else {
          ((deathEffect)deathEffects.get(i)).display();
        }
      }
    }
    if (babis.life <= 0) {
      if (heroDeathEffects.size() < 1) {
        heroDeathEffects.add(new heroDeathEffect(babis.r, babis.g, babis.b, babis.x, babis.y));
        for (int i = 0; i < enemies.size(); i++) {
          deathEffects.add(new deathEffect(((enemy)enemies.get(i)).r, ((enemy)enemies.get(i)).g, ((enemy)enemies.get(i)).b, ((enemy)enemies.get(i)).x, ((enemy)enemies.get(i)).y));
        }
      }
      else {
        if (!((heroDeathEffect)heroDeathEffects.get(0)).existance) {
          heroDeathEffects.remove(0);
          if (configuration) {
            background(0, 0, 255);
          }
          else {
            background(0);
          }
          score();
          finished = true;
        }
        else {
          for (int i = 0; i < deathEffects.size(); i++) {
            if (!((deathEffect)deathEffects.get(i)).existance) {
              deathEffects.remove(i);
            }
            else {
              ((deathEffect)deathEffects.get(i)).display();
            }
          }
          ((heroDeathEffect)heroDeathEffects.get(0)).display();
        }
      }
    }
  }
}

void keyPressed() {
  if (key == 'p' || key == 'P') {
    if (loopControl) {
      paused = true;
      loopControl = false;
      inmenu = true;
    }
    else {
      paused = false;
      loopControl = true;
      inmenu = false;
    }
    if (inmenu) {
      displayMenu();
    }
  }
  if (key == 'c' || key == 'C') {
    configuration = !configuration;
  }
  if (key == CODED) {
    if (keyCode == UP && !up) {
      up = true;
    }
    if (keyCode == DOWN && !down) {
      down = true;
    }
    if (keyCode == LEFT && !left) {
      left = true;
    }
    if (keyCode == RIGHT && !right) {
      right = true;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      up = false;
      lastym = false;
      lastAngle = 0;
    }
    if (keyCode == DOWN) {
      down = false;
      lastym = true;
      lastAngle = 1;
    }
    if (keyCode == LEFT) {
      left = false;
      lastxm = false;
      lastAngle = 2;
    }
    if (keyCode == RIGHT) {
      right = false;
      lastxm = true;
      lastAngle = 3;
    }
  }
}

void mouseClicked() {
  if (mouseButton == LEFT && !loopControl && !finished) {
    menu(mouseX, mouseY);
    displayMenu();
  }
  else if (finished && mouseButton == LEFT && mouseX > width / 2 - width / 10 && mouseX < width / 2 + width / 10 && mouseY > height - (width / 30) - (width / 30 + 5) / 2 && mouseY < height - (width / 30) + (width / 30 + 5) / 2) {
    finished = false;
    babis.life = babis.life0;
    babis.speed00 = 10.2;
    babis.speed0 = babis.speed00;
    babis.freezed = false;
    babis.countfreezed = 0;
    babis.shield = false;
    babis.countshield = 0;
    powerups.clear();
    enemies.clear();
    bolts.clear();
    bbolts.clear();
    bossenemies.clear();
    lastpointsboss = 0;
    babis.x = width / 2;
    babis.y = height / 2;
    Points = 0;
    lastAngle = 0;
    enemies.add(new enemy(random(30, width - 30), random(30, height - 30), 100, 0.5, 5, 10, 500, 250, int(random(0, 250)), int(random(0, 250)), int(random(0, 250)), random(2, 3), random(30, 50), int(random(3, 4))));
  }
}