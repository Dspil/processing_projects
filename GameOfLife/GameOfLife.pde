grid game;
boolean mouseState = false;
boolean playing = false;
IntList cells;
boolean help = false;
PFont f;

void setup(){
  //size(((displayWidth > displayHeight) ? displayHeight - 70 : displayWidth - 30), ((displayWidth > displayHeight)? displayHeight - 70 : displayWidth - 30));
  //size(((displayWidth > displayHeight) ? displayHeight : displayWidth), ((displayWidth > displayHeight)? displayHeight : displayWidth));
  size(displayHeight, displayHeight);
  f = createFont("Arial", 10, true);
  game = new grid(300);
  game.display();
  game.help();
  cells = new IntList();
}

void draw(){
  if (playing){
    game.nextGeneration();
  }
}

void mouseClicked(){
  if (!help){
    if (mouseX > game.gameWidth && mouseY > game.gameHeight){
      game.help();
    }
    else if (mouseX < game.gameWidth && mouseY < game.gameHeight){
      game.alter(mouseX,mouseY);
    }
  }
}

void keyPressed(){
  if (!help){
    if (key == 'n' || key == 'N'){
      game.nextGeneration();
    }
    if (key == 'c' || key == 'C'){
      game.erase();
      playing = false;
    }
    if (key == 's' || key == 'S'){
      playing = true;
    }
    if (key == 'p' || key == 'P'){
      playing = false;
    }
    if (key == 'r' || key == 'R'){
      game.randomCells();
    }
    if (key == 'i' || key == 'I'){
      game.zoomIn();
    }
    if (key == 'o' || key == 'O'){
      game.zoomOut();
    }
    if (key == 'f' || key == 'F'){
      game.fil();
    }
    if (key == CODED){
      if (keyCode == UP){
        game.goUp();
      }
      if (keyCode == DOWN){
        game.goDown();
      }
      if (keyCode == RIGHT){
        game.goRight();
      }
      if (keyCode == LEFT){
        game.goLeft();
      }
    }
  }
  else{
    help = false;
    game.display();
  }
}

void mousePressed(){
  if(!help){
    mouseState = true;
  }
}

void mouseReleased(){
  if (!help){
    mouseState = false;
    cells.clear();
  }
}

void mouseDragged(){
  if (!help){
    if (mouseX < game.gameWidth && mouseY < game.gameHeight && !cells.hasValue(game.cell(mouseX,mouseY))){
      cells.append(game.cell(mouseX,mouseY));
      game.alter(mouseX,mouseY);
    }
  }
}