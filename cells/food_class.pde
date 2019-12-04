class food{
  float x,y,xspeed,yspeed,r,g,b,radius,mass,energy;
  boolean existance;
  
  food(float tempred,float tempgreen,float tempblue,float tempx, float tempy, float tempxspeed, float tempyspeed,float tempradius){
    r = tempred;
    g = tempgreen;
    b = tempblue;
    x = tempx;
    y = tempy;
    xspeed = tempxspeed;
    yspeed = tempyspeed;
    radius = tempradius;
    energy = map(tempradius,2,5,1000,5000);
    mass = radius;
    existance = true;
  }
  
  void move(){
    x += xspeed / speedControl;
    y += yspeed / speedControl;
    if (x + radius > width || x - radius < 0){
      xspeed = -xspeed;
      if (x - radius < 0){
        x = radius;
      }
      else{
        x = width - radius;
      }
    }
    if (y + radius > height || y - radius < 0){
      yspeed = -yspeed;
      if (y - radius < 0){
        y = radius;
      }
      else{
        y = height - radius;
      }
    }
  }
  
  void display(){
    rectMode(CENTER);
    fill(r,g,b);
    noStroke();
    rect(x,y,2*radius,2*radius);
  }
}
