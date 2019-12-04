class hero {
  int r, g, b, size, life, life0, freezedmax, countfreezed, shieldmax, countshield;
  float x, y, speed0, speed00;
  boolean freezed;
  boolean shield;

  hero() {
    x = width / 2;
    y = height / 2;
    r = 0;
    g = 255;
    b = 100;
    size = 15 * displayWidth / 1366;
    speed0 = 10.2;
    speed00 = speed0;
    shieldmax = 500;
    countshield = 0;
    shield = false;
    freezedmax = 100;
    countfreezed = 0;
    freezed = false;
    life = 500;
    life0 = life;
  }

  void move(boolean u, boolean d, boolean l, boolean r) {
    if (freezed) {
      this.r = 0;
      g = 150;
      b = 255;
      countfreezed ++;
      if (countfreezed >= freezedmax) {
        freezed = false;
        countfreezed = 0;
      }
      speed0 = speed00 / 2.0;
    }
    else{
      this.r = 0;
      g = 255;
      b = 100;
      speed0 = speed00;
    }
    if (shield) {
      countshield++;
      if (countshield >= shieldmax) {
        countshield = 0;
        shield = false;
      }
    }
    boolean ym = (u || d) && !(u && d);
    boolean xm = (l || r) && !(l && r);
    float speed = speed0;
    if (xm && ym) {
      speed = speed0 * cos(QUARTER_PI);
    }
    if (xm) {
      if (r) {
        x += speed;
        if (x + size > width) {
          x = width - size;
        }
      }
      else {
        x -= speed;
        if (x - size < 0) {
          x = size;
        }
      }
    }
    if (ym) {
      if (d) {
        y += speed;
        if (y + size > height) {
          y = height - size;
        }
      }
      else {
        y -= speed;
        if (y - size < 20) {
          y = size + 20;
        }
      }
    }
  }

  void display(boolean tempup, boolean tempdown, boolean templeft, boolean tempright, boolean lxm, boolean lym, int ld) {
    boolean ym = (tempup || tempdown) && !(tempup && tempdown);
    boolean xm = (templeft || tempright) && !(templeft && tempright);      
    if (configuration) {
      stroke(0);
      ellipseMode(CENTER);
      rectMode(CENTER);
      fill(100);
      rect(x, y - size * 5 / 6.0, size / 6.0, size / 2.0);
      if (xm) {
        rect(x + ((tempright)? size / 12.0 : -size / 12.0), y - size * 5 / 6.0 - size / 6.0,  size / 3.0, size / 6.0);
      }
      else {
        rect(x + ((lxm)? size / 12.0 : -size / 12.0), y - size * 5 / 6.0 - size / 6.0,  size / 3.0, size / 6.0);
      }
      ellipse(x, y, size * 2, size * 4 / 3.0);
      fill(0);
      ellipse(x, y, size / 3.0, size / 3.0);
      ellipse(x + size / 2.0, y, size / 3.0, size / 3.0);
      ellipse(x - size / 2.0, y, size / 3.0, size / 3.0);
    }
    else {
      noStroke();
      if (xm || ym) {
        if ((tempup && (templeft || tempright) && xm && ym) || (tempdown && !xm && ym)) {
          fill(r, g, b);
          triangle(x - (cos(PI / 6.0) * size), y - (sin(PI / 6.0) * size), x + cos(PI / 6.0) * size, y - sin(PI / 6.0) * size, x, y + size);
          fill(255, 0, 0);
          if (tempdown && !xm && ym) {
            triangle(x - size * cos(PI / 6.0) / 4.0, y + size / 4.0, x + size * cos(PI / 6.0) / 4.0, y + size / 4.0, x, y + size);
          }
          else {
            if (templeft) {
              triangle(x - (size * cos(PI / 6.0)) / 8.0, y - 5 * size / 16.0, x - 3 * (size * cos(PI / 6.0)) / 8, y + size / 16.0, x - (cos(PI / 6.0) * size), y - (sin(PI / 6.0) * size));
            }
            else {
              triangle(x + (size * cos(PI / 6.0)) / 8.0, y - 5 * size / 16.0, x + 3 * (size * cos(PI / 6.0)) / 8, y + size / 16.0, x + (cos(PI / 6.0) * size), y - (sin(PI / 6.0) * size));
            }
          }
        }
        else if ((tempdown && (templeft || tempright) && xm && ym) || (tempup && !xm && ym)) {
          fill(r, g, b);
          triangle(x - (cos(PI / 6.0) * size), y + (sin(PI / 6.0) * size), x + cos(PI / 6.0) * size, y + sin(PI / 6.0) * size, x, y - size);
          fill(255, 0, 0);
          if (tempup && !xm && ym) {
            triangle(x - size * cos(PI / 6.0) / 4.0, y - size / 4.0, x + size * cos(PI / 6.0) / 4.0, y - size / 4.0, x, y - size);
          }
          else {
            if (templeft) {
              triangle(x - (size * cos(PI / 6.0)) / 8.0, y + 5 * size / 16.0, x - 3 * (size * cos(PI / 6.0)) / 8, y - size / 16.0, x - (cos(PI / 6.0) * size), y + (sin(PI / 6.0) * size));
            }
            else {
              triangle(x + (size * cos(PI / 6.0)) / 8.0, y + 5 * size / 16.0, x + 3 * (size * cos(PI / 6.0)) / 8, y - size / 16.0, x + (cos(PI / 6.0) * size), y + (sin(PI / 6.0) * size));
            }
          }
        }
        else if (tempright) {
          fill(r, g, b);
          triangle(x - (cos(PI / 3.0) * size), y + (sin(PI / 3.0) * size), x - cos(PI / 3.0) * size, y - sin(PI / 3.0) * size, x + size, y);
          fill(255, 0, 0);
          triangle(x + size / 4.0, y - size * cos(PI / 6.0) / 4.0, x + size / 4.0, y + size * cos(PI / 6.0) / 4.0, x + size, y);
        }
        else {
          fill(r, g, b);
          triangle(x + (cos(PI / 3.0) * size), y + (sin(PI / 3.0) * size), x + cos(PI / 3.0) * size, y - sin(PI / 3.0) * size, x - size, y);
          fill(255, 0, 0);
          triangle(x - size / 4.0, y - size * cos(PI / 6.0) / 4.0, x - size / 4.0, y + size * cos(PI / 6.0) / 4.0, x - size, y);
        }
      }
      else {
        switch(ld) {
        case 0:
          fill(r, g, b);
          triangle(x - (cos(PI / 6.0) * size), y + (sin(PI / 6.0) * size), x + cos(PI / 6.0) * size, y + sin(PI / 6.0) * size, x, y - size);
          fill(255, 0, 0);
          triangle(x - size * cos(PI / 6.0) / 4.0, y - size / 4.0, x + size * cos(PI / 6.0) / 4.0, y - size / 4.0, x, y - size);
          break;
        case 1:
          fill(r, g, b);
          triangle(x - (cos(PI / 6.0) * size), y - (sin(PI / 6.0) * size), x + cos(PI / 6.0) * size, y - sin(PI / 6.0) * size, x, y + size);
          fill(255, 0, 0);
          triangle(x - size * cos(PI / 6.0) / 4.0, y + size / 4.0, x + size * cos(PI / 6.0) / 4.0, y + size / 4.0, x, y + size);
          break;
        case 2:
          fill(r, g, b);
          triangle(x + (cos(PI / 3.0) * size), y + (sin(PI / 3.0) * size), x + cos(PI / 3.0) * size, y - sin(PI / 3.0) * size, x - size, y);
          fill(255, 0, 0);
          triangle(x - size / 4.0, y - size * cos(PI / 6.0) / 4.0, x - size / 4.0, y + size * cos(PI / 6.0) / 4.0, x - size, y);
          break;
        case 3:
          fill(r, g, b);
          triangle(x - (cos(PI / 3.0) * size), y + (sin(PI / 3.0) * size), x - cos(PI / 3.0) * size, y - sin(PI / 3.0) * size, x + size, y);
          fill(255, 0, 0);
          triangle(x + size / 4.0, y - size * cos(PI / 6.0) / 4.0, x + size / 4.0, y + size * cos(PI / 6.0) / 4.0, x + size, y);
          break;
        }
      }
    }
    if (shield) {
      stroke(0, 200, 240);
      strokeWeight(3);
      noFill();
      ellipseMode(CENTER);
      ellipse(x, y, size * 2, size * 2);
      strokeWeight(1);
    }
  }
}

class enemy {
  int r, g, b, size, boltControl1, boltControl, reproducepoint, diepoint, age, canReproduce, reproduceControl;
  float x, y, speed0, boltSpeed, maxSpeed, angle, damage, life, life0;
  boolean existance;

  enemy(float tempx, float tempy, int tempBoltControl, float tempboltSpeed, float tempdamage, float tempmaxSpeed, int tempdiepoint, int tempreproducepoint, int tempr, int tempg, int tempb, float tempspeed0, float templife, int tempCanReproduce) {
    diepoint = tempdiepoint;
    reproducepoint = tempreproducepoint;
    canReproduce = tempCanReproduce;
    reproduceControl = 0;
    r = tempr;
    g = tempg;
    b = tempb;
    age = 0;
    size = 20 * displayWidth / 1366;
    x = tempx;
    y = tempy;
    life = templife;
    life0 = life;
    angle = random(0, 2 * PI);
    maxSpeed = tempmaxSpeed;
    boltControl = tempBoltControl;
    boltControl1 = 0;
    boltSpeed = tempboltSpeed;
    damage = tempdamage;
    existance = true;
    speed0 = tempspeed0;
  }

  void display() {
    fill(r, g, b);
    noStroke();
    rectMode(CENTER);
    ellipse(x, y, size, size);
  }

  void move() {
    angle += random(-QUARTER_PI / 2, QUARTER_PI / 2);
    x += speed0 * cos(angle);
    y += speed0 * sin(angle);
    if (x + size / 2.0 > width) {
      angle = PI - angle;
      x = width - size / 2.0;
    }
    if (x - size / 2.0 < 0) {
      angle = PI - angle;
      x = size / 2.0;
    }
    if (y + size / 2.0 > height) {
      angle = 2 * PI - angle;
      y = height - size / 2.0;
    }
    if (y - size / 2.0 < 20) {
      angle = 2 * PI - angle;
      y = size / 2.0 + 20;
    }
  }

  void grow() {
    age += 1;
  }
}

class bolt {
  int r, g, b, size, diepoint, age;
  float x, y, speedx, damage, speedy, speed, angle, acceleration0, acceleration, maxSpeed;
  boolean fired, existance;
  enemy hoast;

  bolt(float tempx, float tempy, float tempacceleration, float tempdamage, float tempmaxSpeed, int tempdiepoint, enemy temphoast) {
    diepoint = tempdiepoint;
    x = tempx;
    y = tempy;
    age = 0;
    acceleration0 = tempacceleration;
    acceleration = tempacceleration; // sqrt(dist(x,y,babis.x,babis.y));
    damage = tempdamage;
    maxSpeed = tempmaxSpeed;
    r = 255;
    g = 0;
    b = 0;
    angle = angleToHero(x, y);
    size = 8 * displayWidth / 1366;
    fired = false;
    existance = true;
    hoast = temphoast;
  }

  void display() {
    fill(configuration? 0 : r, configuration? 250 : g, configuration? 255 : b, configuration? 255 : 200);
    noStroke();
    ellipseMode(CENTER);
    ellipse(x, y, size, size);
  }

  void turnTo(float tempangle) {
    angle = tempangle;
  }

  void grow() {
    age += 1;
    if (age > diepoint) {
      existance = false;
    }
  }

  void move() {
    if (!fired) {
      boolean isFired = true;
      for (int i = 0; i < enemies.size(); i++) {
        if (dist(((enemy)enemies.get(i)).x, ((enemy)enemies.get(i)).y, x, y) < size / 2.0 + ((enemy)enemies.get(i)).size / 2.0) {
          isFired = false;
          break;
        }
      }
      for (int i = 0; i < bossenemies.size(); i++) {
        if (dist(((bossenemy)bossenemies.get(i)).x, ((bossenemy)bossenemies.get(i)).y, x, y) < size / 2.0 + ((bossenemy)bossenemies.get(i)).size / 1.5) {
          isFired = false;
          break;
        }
      }
      if (isFired) {
        fired = true;
      }
    }        
    acceleration = acceleration0;
    if (sqrt((speedx + acceleration * cos(angle)) * (speedx + acceleration * cos(angle)) + (speedy + acceleration * sin(angle)) * (speedy + acceleration * sin(angle))) < maxSpeed) {
      speedx += acceleration * cos(angle);
      speedy += acceleration * sin(angle);
    }
    speed = sqrt(speedx * speedx + speedy * speedy);
    x += speed * cos(angle);
    y += speed * sin(angle);
    if (x + size / 2.0 > width || x - size / 2.0 < 0 || y + size / 2.0 > height || y - size / 2.0 < 20) {
      existance = false;
    }
  }

  void collide() {
    if (dist(babis.x, babis.y, x, y) < size / 2.0 + ((configuration) ? babis.size : (babis.size / 2.0))) {
      existance = false;
      if (!babis.shield) {
        babis.life -= damage;
        hoast.reproduceControl += 1;
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
    for (int i = 0; i < bossenemies.size(); i++) {
      if (dist(((bossenemy)bossenemies.get(i)).x, ((bossenemy)bossenemies.get(i)).y, x, y) < size / 2.0 + ((bossenemy)bossenemies.get(i)).size / 2) {
        ((bossenemy)bossenemies.get(i)).life -= damage;
        if (((bossenemy)bossenemies.get(i)).life <= 0 && ((bossenemy)bossenemies.get(i)).existance) {
          ((bossenemy)bossenemies.get(i)).existance = false;
          Points += 100000;
        }
        existance = false;
      }
    }
  }
}

class deathEffect {
  int r, g, b, life0, life1;
  float x, y, radius;
  boolean existance;
  
  deathEffect(int tempr, int tempg, int tempb, float tempx, float tempy) {
    r = tempr;
    g = tempg;
    b = tempb;
    x = tempx;
    y = tempy;
    life0 = 0;
    life1 = 20;
    radius = 1 * displayWidth / 1366;
    existance = true;
  }
  
  void display(){
    life0++;
    if (life0 >= life1){
      existance = false;
    }
    fill(r,g,b);
    noStroke();
    for (int i = 0; i < 32; i++) {
      radius += 0.15 * displayWidth / 1366;
      float x1 = random(-radius, radius);
      float y1 = random(-sqrt((radius * radius) - (x1 * x1)), sqrt((radius * radius) - (x1 * x1)));
      ellipse(x + x1, y + y1, 5 * displayWidth / 1366, 5 * displayWidth / 1366);
    }
  }
}

class heroDeathEffect {
  int r, g, b, life0, life1, balls;
  float x, y, radius;
  boolean existance;
  
  heroDeathEffect(int tempr, int tempg, int tempb, float tempx, float tempy) {
    r = tempr;
    g = tempg;
    b = tempb;
    x = tempx;
    y = tempy;
    life0 = 0;
    life1 = 50;
    radius = 1 * displayWidth / 1366;
    balls = 20;
    existance = true;
  }
  
  void display(){
    life0++;
    if (life0 >= life1){
      existance = false;
    }
    fill(r,g,b);
    noStroke();
    balls *= 1.15;
    for (int i = 0; i < balls; i++) {
      radius += 0.08 * displayWidth / 1366;
      float x1 = random(-radius, radius);
      float y1 = random(-sqrt((radius * radius) - (x1 * x1)), sqrt((radius * radius) - (x1 * x1)));
      ellipse(x + x1, y + y1, 5 * displayWidth / 1366, 5 * displayWidth / 1366);
    }
  }
}

class powerup {
  int life, age, r, g, b;
  float x, y, size, angle;
  boolean existance;
  
  powerup(float tempx, float tempy, float tempsize, int templife, int tempr, int tempg, int tempb) {
    life = templife;
    x = tempx;
    y = tempy;
    size = tempsize * displayWidth / 1366;
    r = tempr;
    g = tempg;
    b = tempb;
    angle = 0;
    existance = true;
  }
  
  void live() {
    angle += PI / 100;
    this.display();
    this.collide();
    age += 1;
    if (age >= life) {
      existance = false;
    }
  }
  
  void display() {
    rectMode(CENTER);
    pushMatrix();
    translate(x - size / 2.0, y - size / 2.0);
    rotate(angle);
    stroke(r,g,b, abs((age * 5) % 510 / 255 * 255 - (age * 5) % 255));
    fill(r,g,b,abs((age * 5) % 510 / 255 * 255 - (age * 5)  % 255));
    rect(0, 0, size, size);
    popMatrix();
  }
  
  void collide() {
    if (dist(x, y, babis.x, babis.y) < babis.size + size / 2.0) {
      babis.shield = true;
      babis.countshield = 0;
      existance = false;
    }
  }
}