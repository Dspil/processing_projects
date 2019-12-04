class bossenemy {
  float x, y, size, speed0, angle, life, life0, boltSpeed, maxSpeed, damage;
  boolean existance;
  int boltControl1, boltControl, diepoint;

  bossenemy(float tempx, float tempy) {
    x = tempx;
    y = tempy;
    speed0 = 10.2;
    angle = random(0, 2 * PI);
    size = 15;
    life = 50;
    life0 = life;
    maxSpeed = babis.speed0 * 3 / 4.0;
    boltSpeed = 0.5;
    damage = 0;
    diepoint = 500;
    boltControl1 = 0;
    boltControl = 100;
    existance = true;
  } 
  
  void decideDirection() {
    float ifSafe = displayWidth > displayHeight ? displayWidth : displayHeight;
    float tempx = 0, tempy = 0;
    for (int i = 0; i < bolts.size(); i++) {
      if (dist(((bolt)bolts.get(i)).x, ((bolt)bolts.get(i)).y, x, y) < ifSafe) {//size / 2 + ((bolt)bolts.get(i)).size / 2 + 10) {
        ifSafe = dist(((bolt)bolts.get(i)).x, ((bolt)bolts.get(i)).y, x, y);
        tempx = ((bolt)bolts.get(i)).x;
        tempy = ((bolt)bolts.get(i)).y;
      }
    }
    if (ifSafe < size * 6) {
      float tempangle = 0;
      if (tempx == babis.x) {
        if (tempy > y) {
          tempangle = HALF_PI * 3;
        }
        else {
          tempangle = HALF_PI;
        }
      }
      else {
        float tangent = (y - tempy) / (x - tempx);
        tempangle = atan(tangent);
        if (x < tempx) {
          tempangle -= PI;
        }
      }
      angle = tempangle + random(-HALF_PI, HALF_PI);
    }
    else {
      angle += random(-QUARTER_PI, QUARTER_PI);
    }
  }

  void move() {
    x += speed0 * cos(angle);
    y += speed0 * sin(angle);
    if (x + size / 2.0 > width) {
      x = width - size / 2.0;
    }
    if (x - size / 2.0 < 0) {
      x = size / 2.0;
    }
    if (y + size / 2.0 > height) {
      y = height - size / 2.0;
    }
    if (y - size / 2.0 < 20) {
      y = size / 2.0 + 20;
    }
  }


  void display() {
    fill(0, 150, 255);
    ellipseMode(CENTER);
    noStroke();
    ellipse(x, y, size, size);
  }
}

class bbolt extends bolt {
  bossenemy bhoast;
  
  bbolt(float tempacceleration, float tempdamage, float tempmaxSpeed, int tempdiepoint, bossenemy temphoast) {
    super(0, 0, tempacceleration, tempdamage, tempmaxSpeed, tempdiepoint, null);
    diepoint = tempdiepoint;
    bhoast = temphoast;
    x = bhoast.x;
    y = bhoast.y;
    r = 0;
    g = 150;
    b = 255;
  }
  
  void collide() {
    if (dist(babis.x, babis.y, x, y) < size / 2.0 + ((configuration) ? babis.size : (babis.size / 2.0))) {
      existance = false;
      if (!babis.shield) {
        babis.life -= damage;
        babis.freezed = true;
      }
    }
    for (int i = 0; i < enemies.size(); i++) {
      if (dist(((enemy)enemies.get(i)).x, ((enemy)enemies.get(i)).y, x, y) < size / 2.0 + ((enemy)enemies.get(i)).size / 2.0 && fired) {
        existance = false;
        ((enemy)enemies.get(i)).life -= damage;
        if (((enemy)enemies.get(i)).life <= 0) {
          ((enemy)enemies.get(i)).existance = false;
          deathEffects.add(new deathEffect(((enemy)enemies.get(i)).r, ((enemy)enemies.get(i)).g, ((enemy)enemies.get(i)).b, ((enemy)enemies.get(i)).x, ((enemy)enemies.get(i)).y));
          Points += pointsOf((enemy)enemies.get(i));
        }
      }
    }
  }
}