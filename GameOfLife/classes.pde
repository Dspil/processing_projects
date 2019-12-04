  class grid{
  boolean[][] board;
  int len, zoom, startx, starty, stopx, stopy, displaylen, colorr, colorg, colorb, stroker, strokeg, strokeb, gameWidth, gameHeight;
  IntList living;
  IntList dead;
  float density, toleration;
  
  //constructor
  grid(int templen){
    len = templen;
    board = new boolean[templen][templen];
    living = new IntList();
    dead = new IntList();
    gameWidth = width - 15;
    gameHeight = height - 15;
    zoom = 50;
    startx = 0;
    starty = 0;
    stopx = 50;
    stopy = 50;
    displaylen = 50;
    density = (gameWidth > gameHeight) ? gameHeight / float(displaylen) : gameWidth / float(displaylen);
    toleration = 4;
    colorr = 200;
    colorg = 0;
    colorb = 0;
    stroker = 0;
    strokeg = 0;
    strokeb = 100;
  }
  
  //display methods
  void display(){
    background(255);
    displayBars();
    stroke(stroker, strokeg, strokeb);
    if (density > toleration){
      for (int i = 1; i < displaylen + 1; i++){
        line(gameWidth / float(displaylen) * i, 0, gameWidth / float(displaylen) * i, gameHeight);
        line(0, gameHeight / float(displaylen) * i, gameWidth, gameHeight / float(displaylen) * i);
      }
    }
    rectMode(CORNERS);
    fill(colorr, colorg, colorb);
    if (density > toleration){
      stroke(stroker, strokeg, strokeb);
    }
    else{
      stroke(colorr, colorg, colorb);
    }
    for (int i = startx; i < stopx; i++){
      for (int j = starty; j < stopy; j++){
        if (board[i][j]){
          rect(gameWidth / float(displaylen) * (i - startx), gameHeight / float(displaylen) * (j - starty), gameWidth / float(displaylen) * (i - startx + 1), gameHeight / float(displaylen) * (j - starty + 1));
        }
      }
    }
  }
  
  void displayBars(){
    fill(200,255,200);
    stroke(stroker, strokeg, strokeb);
    rect(gameWidth,0, width, gameHeight);
    rect(0, gameHeight, gameWidth, height);
    fill(100,200,255);
    rect(gameWidth / float(len - displaylen + 1) * startx, gameHeight, gameWidth / float(len - displaylen + 1) * (startx + 1), height);
    rect(gameWidth, gameHeight / float(len - displaylen + 1) * starty, width, gameHeight / float(len - displaylen + 1) * (starty + 1));
    stroke(0);
    fill(0, 255, 0);
    rect(gameWidth, gameHeight, width, height);
    fill(0);
    rect(gameWidth + 7, gameHeight + 7, gameWidth + 8, height - 3);
    line(gameWidth + 5, gameHeight + 7, gameWidth + 7, gameHeight + 7);
    line(gameWidth + 5, height - 3, gameWidth + 10, height - 3);
    rect(gameWidth + 7, gameHeight + 3, gameWidth + 8, gameHeight + 4);
  }
  
  void zoomIn(){
    if (zoom > 2){
      playing = false;
      zoom -= 2;
      startx++;
      starty++;
      stopx--;
      stopy--;
      displaylen -= 2;
      density = (gameWidth > gameHeight) ? gameHeight / float(displaylen) : gameWidth / float(displaylen);
      refresh();
    }
  }
  
  void zoomOut(){
    if (zoom != len){
      playing = false;
      zoom += 2;
      if (startx == 0){
        stopx += 2;
      }
      else if (stopx == len){
        startx -= 2;
      }
      else{
        startx--;
        stopx++;
      }
      if (starty == 0){
        stopy += 2;
      }
      else if (stopy == len){
        starty -= 2;
      }
      else{
        starty--;
        stopy++;
      }
      displaylen += 2;
      density = (gameWidth > gameHeight) ? gameHeight / float(displaylen) : gameWidth / float(displaylen);
      refresh();
    }
  }
  
  void goUp(){
    if (starty != 0){
      playing = false;
      starty--;
      stopy--;
      refresh();
    }
  }
  
  void goDown(){
    if (stopy != len){
      playing = false;
      stopy++;
      starty++;
      refresh();
    }
  }
  
  void goRight(){
    if (stopx != len){
      playing = false;
      stopx++;
      startx++;
      refresh();
    }
  }
  
  void goLeft(){
    if (startx != 0){
      playing = false;
      startx--;
      stopx--;
      refresh();
    }
  }
  
  void refresh(){
    living.clear();
    dead.clear();
    for (int i = startx; i < stopx; i++){
      for (int j = starty; j < stopy; j++){
        if (board[i][j]){
          living.append(i * len + j);
        }
      }
    }
    for (int i = 0; i < living.size(); i++){
      int[] n = neighbours(living.get(i) / len, living.get(i) % len);
      for (int j = 0; j < n.length; j++){
        if (n[j] != -1 && !dead.hasValue(n[j]) && !board[n[j] / len][n[j] % len]){
          dead.append(n[j]);
        }
      }
    }
    display();
  }
  
  // generation methods
  void alter(float x, float y){
    int a = displaylen - 1;
    int b = displaylen - 1;
    for (int i = 1; i < displaylen + 1; i++){
      if (x < gameWidth / float(displaylen) * i){
        a = i - 1 + startx;
        break;
      }
    }
    for (int i = 1; i < displaylen + 1; i++){
      if (y < gameHeight / float(displaylen) * i){
        b = i - 1 + starty;
        break;
      }
    }
    altern(a,b);
  }
  
  void altern(int a, int b){
    if (board[a][b]){
      living.remove(indexOfCell(a * len + b));
      if (numberOfNeighbours(a * len + b) > 0){
        dead.append(a * len + b);
      }
      int[] n = neighbours(a,b);
      for (int i = 0; i < n.length; i++){
        if (n[i] != -1 && !board[n[i] / len][n[i] % len] && numberOfNeighbours(n[i]) == 1){
          dead.remove(indexOfDead(n[i]));
        }
      }
      rectMode(CORNERS);
      fill(255);
      if (density > toleration){
        stroke(stroker, strokeg, strokeb);
      }
      else{
        stroke(255);
      }
      rect(gameWidth / float(displaylen) * (a - startx), gameHeight / float(displaylen) * (b - starty), gameWidth / float(displaylen) * (a - startx + 1), gameHeight / float(displaylen) * (b - starty + 1));
    }
    else{
      rectMode(CORNERS);
      living.append(a * len + b);
      int[] n = neighbours(a,b);
      for (int i = 0; i < n.length; i++){
        if (n[i] != -1 && !board[n[i] / len][n[i] % len] && !dead.hasValue(n[i])){
          dead.append(n[i]);
        }
      }
      if (dead.hasValue(a * len + b)){
        dead.remove(indexOfDead(a * len + b));
      }
      fill(colorr, colorg, colorb);
      if (density > toleration){
        stroke(stroker, strokeg, strokeb);
      }
      else{
        stroke(colorr, colorg, colorb);
      }
      rect(gameWidth / float(displaylen) * (a - startx), gameHeight / float(displaylen) * (b - starty), gameWidth / float(displaylen) * (a - startx + 1), gameHeight / float(displaylen) * (b - starty + 1));
    }
    board[a][b] = !board[a][b];
  }
  
  int indexOfDead(int x){
    int a = 0;
    for (int i = 0; i < dead.size(); i++){
      if (dead.get(i) == x){
        a = i;
        break;
      }
    }
    return a;
  }
  
  int indexOfCell(int x){
    int a = 0;
    for (int i = 0; i < living.size(); i++){
      if (living.get(i) == x){
        a = i;
        break;
      }
    }
    return a;
  }
  
  int[] neighbours(int x, int y){
    int[] n = new int[8];
    n[0] = ((x - 1) < startx || (y - 1) < starty) ? -1 : (x - 1) * len + (y - 1);
    n[1] = ((x - 1) < startx) ? -1 : (x - 1) * len + y;
    n[2] = ((x - 1) < startx || (y + 1) == stopy) ? -1 : (x - 1) * len + (y + 1);
    n[3] = ((y - 1) < starty) ? -1 : (x) * len + (y - 1);
    n[4] = ((y + 1) == stopy) ? -1 : (x) * len + (y + 1);
    n[5] = ((x + 1) == stopx || (y - 1) < starty) ? -1 : (x + 1) * len + (y - 1);
    n[6] = ((x + 1) == stopx) ? -1 : (x + 1) * len + y;
    n[7] = ((x + 1) == stopx || (y + 1) == stopy) ? -1 : (x + 1) * len + (y + 1);
    return n;
  }
  
  int cell(float x, float y){
    int a = displaylen - 1;
    int b = displaylen - 1;
    for (int i = 1; i < displaylen + 1; i++){
      if (x < gameWidth / float(displaylen) * i){
        a = i - 1 + startx;
        break;
      }
    }
    for (int i = 1; i < displaylen + 1; i++){
      if (y < gameHeight / float(displaylen) * i){
        b = i - 1 + starty;
        break;
      }
    }
    return a * displaylen + b;
  }
  
  int numberOfNeighbours(int a){
    int b = 0;
    int[] n = neighbours(a / len, a % len);
    for (int i = 0; i < n.length; i++){
      if (n[i] != -1 && board[n[i] / len][n[i] % len]){
        b++;
      }
    }
    return b;
  }
  
  void nextGeneration(){
    IntList alterations = new IntList();
    for (int i = 0; i < dead.size(); i++){
      if (numberOfNeighbours(dead.get(i)) == 3){
        alterations.append(dead.get(i));
      }
    }
    for (int i = 0; i < living.size(); i++){
      if (numberOfNeighbours(living.get(i)) > 3 || numberOfNeighbours(living.get(i)) < 2){
        alterations.append(living.get(i));
      }
    }
    if (alterations.size() == 0){
      playing = false;
    }
    else{
      for (int i = 0; i < alterations.size(); i++){
        altern(alterations.get(i) / len, alterations.get(i) % len);
      }
      if (density < toleration){
        fill(colorr, colorg, colorb);
        rectMode(CORNERS);
        stroke(colorr, colorg, colorb);
        for (int i = 0; i < living.size(); i++){
          rect(gameWidth / float(displaylen) * ((living.get(i) / len) - startx), gameHeight / float(displaylen) * ((living.get(i) % len) - starty), gameWidth / float(displaylen) * ((living.get(i) / len) - startx + 1), gameHeight / float(displaylen) * ((living.get(i) % len) - starty + 1));
        }
      }
      displayBars();
    }
  }
  
  void erase(){
    int i = 0;
    while (i != living.size()){
      altern(living.get(i) / len, living.get(i) % len);
    }
    displayBars();
  }
  
  void randomCells(){
    erase();
    playing = false;
    for (int i = 0; i < constrain(displaylen * displaylen / 3,0, 2000); i++){
      altern(int(random(startx,stopx)),int(random(starty,stopy)));
    }
  }
  
  void help(){
    playing = false;
    help = true;
    background(255);
    text("Welcome to the Game Of Life! \n \n For altering the state of a cell just click on it. \n \n For altering many cells click and drug the mouse on the screen. \n \n For creating the next generation press 'n'. \n \n For auto generation press 's'. \n \n For pausing the auto generation press 'p'. \n \n For placing random cells on the viewed screen press 'r'. \n \n For clearing the screen press 'c'. \n \n For zooming in press 'i'. \n \n For zooming out press 'o'. For moving around use the arrow keys. \n \n To open this help message click on the down right bottom of the screen. \n \n Press any key to continue!", 20, 20);
  }
  
  void fil(){
    for (int i = startx; i < stopx; i++) {
      for (int j = starty; j < stopy; j++) {
         altern(i,j);
      }
    }
  }
         
}
