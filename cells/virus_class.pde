class virus{
  IntList identities;
  float age, dl, x, y, xspeed, yspeed, r, g, b, diepoint, reproducepoint, speed, angle, size, power;
  boolean existance, cellInfected;
  cell hoast;
  
  
  virus(float tempr,float tempg, float tempb,float tempx, float tempy,float tempspeed, float temppower){
    age = 0;
    diepoint = random(0.05,0.1);
    reproducepoint = random(0.1,0.3);
    dl = 0.0001;
    x = tempx;
    y = tempy;
    power = temppower;
    angle = random(0,2) * PI;
    xspeed = tempspeed * cos(angle);
    yspeed = tempspeed * sin(angle);
    speed = tempspeed;
    r = tempr;
    g = tempg;
    b = tempb;
    existance = true;
    size = 7;
    cellInfected = false;
    identities = new IntList();
  }
  
  
  void grow(){
    age += dl / speedControl;
    if (cellInfected == false){
      size = 7;
    }
  }
  
  
  void turn(float a){
    angle = a;
    xspeed = speed / speedControl * cos(angle);
    yspeed = speed / speedControl * sin(angle);
  }
  
  
  void display(){
    noStroke();
    fill(r,g,b);
    triangle(x,y - size,x + cos(PI / 6) * size,y + sin(PI / 6) * size,x - cos(PI / 6) * size,y + sin(PI / 6) * size);
  }
  
  
  void move(){
    if (cellInfected == false){
      x += xspeed / speedControl;
      y += yspeed / speedControl;
      if (x + size > width || x - size < 0){
        xspeed = -xspeed;
        if (x - size < 0){
          x = size;
        }
        else{
          x = width - size;
        }
      }
      if (y + size > height || y - size < 0){
        yspeed = -yspeed;
        if (y - size < 0){
          y = size;
        }
        else{
          y = height - size;
        }
      }
    }
    else{
      x = hoast.x;
      y = hoast.y;
      size = hoast.size / 1.7;
    }
  }
}
