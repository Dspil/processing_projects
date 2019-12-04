class cell{
  float size, age, dl, x, y, xspeed, yspeed, r, g, b, maturepoint, diepoint, maxsize, speed0, speed, angle, possibilityOfInfection;
  int identity;
  boolean existance, isInfected, Tcell;
  virus cellVirus;
  
  
  cell(float tempr,float tempg, float tempb, float tempsize,float tempx, float tempy,float tempspeed,float tempmaxsize, float temppossibilityOfInfection){
    age = 0;
    size = tempsize;
    diepoint = random(0.1,0.3);
    maturepoint = diepoint - 0.05;
    dl = 0.0001;
    x = tempx;
    y = tempy;
    angle = random(0,2) * PI;
    xspeed = tempspeed * cos(angle);
    yspeed = tempspeed * sin(angle);
    speed0 = tempspeed;
    speed = speed0 - size * 0.05;
    r = tempr;
    g = tempg;
    b = tempb;
    existance = true;
    maxsize = tempmaxsize;
    possibilityOfInfection = temppossibilityOfInfection;
    identity = newIdentity();
    isInfected = false;
    if (random(100) < 5){
      Tcell = true;
    }
    else{
      Tcell = false;
    }
  }
  
  
  void grow(){
    age += dl / speedControl;
    size -= (dl / speedControl) * 70;
    size = constrain(size,3,maxsize);
    speed = constrain((speed0 / speedControl) - size * 0.1,1,speed0 / speedControl);
  }
  
  
  void turn(float a){
    angle = a;
    xspeed = speed * cos(angle);
    yspeed = speed * sin(angle);
  }
  
  
  void display(){
    noStroke();
    fill(r,g,b);
    if (Tcell == true){
      ellipse(x,y,2*size,size);
    }
    else{
      ellipse(x,y,2*size,2*size);
    }
  }
  
  
  void move(){
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
}
