//declare pacman variables
int xDir = 1;//x direction for pac man
int yDir = -1;//y direction for pac man
int xPos;//the pacman x position
int yPos;//the pacman y position
int direction = 0;//the direction for the button
int chomp = 1;//to make the pacman chomp
int mouth = 1;//to make the pacman close or open

//declare pac man direction variables
int LEFTDIR = 1;
int UPDIR = 2;
int RIGHTDIR = 3;
int DOWNDIR = 4;

//declare main ghost variables
int[] gXPos = new int[4];//blue ghost x position
int[] gYPos = new int[4];//blue ghost y position
int[] ghostSpeed = new int[4];//different ghost speed

//declare red ghost variable
int moreRedGhost = 0;//to show up more red ghost
int[] redGhostXPos = new int[9+999+999];//red ghost x position
int[] redGhostYPos = new int[9+999+999];//red ghost y position

//declare points variables
int[] xP = new int[2];//the x points variable
int[] yP = new int[2];//the y points variable
int spin = 0;//to make the points spin

//Snake
int xSnake;//the starting x tail position
int ySnake;//the starting y tail position
float[] xSnakeTail = new float[20];//the number of extension
float[] ySnakeTail = new float[20];//the number of extension
float segLength = 1;//the length of the tail

//decalre distance variables
int[] distance = new int[3];//the distance between the points and the pacman
int[] distanceGhost = new int[9999];//distance between the blue ghost and the pacman
int[] distanceRedGhost = new int[9999];//distance of red ghost and the pacman

//Other variables
PFont font;//to create font
int count = 0;//var to make the ghost reset just in case
int wave = 0;//variable to record how many times pacmane has eaten the food points
int health = 0;//variable for pacman's health
boolean dead = false;

void setup() {
  //screen size
  size(1400, 700);
  //backgournd
  fill(0, 0, 0);//black background
  rect(0, 0, 1400, 700);
  frameRate(30);//framerate of the screen
  //set the startin pacman position
  xPos = 1000;
  yPos = 350;
  //set the starting ghost position
  gXPos[0] = -200;
  gYPos[0] = -200;
  gXPos[1] = 1600;
  gYPos[1] = -200;
  gXPos[2] = -200;
  gYPos[2] = 900;
  gXPos[3] = 1600;
  gYPos[3] = 900;
  //set the starting point for the tail of the pacman
  xSnake = 1000;
  ySnake = 350;
  //set the starting food position
  for (int i = 0; i < 2; i++) {
    xP[i] = int(random(100, 1300));
    yP[i] = int(random(100, 600));
  }//end for
}//end setup

boolean start;
void draw() {

  ////////////// Background Image
  background(0);

  ///////////////// Food Points and Collision
  for (int i = 0; i < 2; i++) {
    foodPoints(xP[i], yP[i]);//draw the points and the position
    distance[i] = int(sqrt(pow((xPos-xP[i]), 2) + pow((yPos-yP[i]), 2)));//find the distance
    if (distance[i] < 50) {//if the distance is smaller than 50 then
      //set a new food points position
      xP[i] = int(random(100, 1300));
      yP[i] = int(random(100, 600));
      moreRedGhost = moreRedGhost + 1;//add red ghost
      segLength = segLength + 1;// add the length of the tail longer
      wave = wave + 1;//add 1 everytime pacman eats the food
    }//end if
  }//end for

  ///////////////////////// Pacman's Snake Tail
  strokeWeight(9);
  stroke(255, 100);
  dragSegment(0, xSnake, ySnake);//draw the tail
  for (int i=0; i<xSnakeTail.length-1; i++) {
    dragSegment(i+1, xSnakeTail[i], ySnakeTail[i]);
  }//end for

  //make the tail on the pacman
  if (xSnake <= xPos) {
    xSnake = xSnake + 10;
  }//end if
  if (xSnake >= xPos) {
    xSnake = xSnake - 10;
  }//end if
  if (ySnake >= yPos) {
    ySnake = ySnake - 10;
  }//end if
  if (ySnake <= yPos) {
    ySnake = ySnake + 10;
  }//end if

  ////////////////// PacMan 
  fill(250, 250, 0);// colour the pacman to yellow
  for (int i = 0; i < 4; i++) {//loop 5 of the blue ghost
    //find the distance of all five blue ghost
    distanceGhost[i] = int(sqrt(pow((xPos-gXPos[i]), 2) + pow((yPos-gYPos[i]), 2)));
    if (distanceGhost[i] < 50) {//if the distance is smaller than 50 
      //indicate hit marker
      size(1400, 700);
      fill(200, 200, 200);
      rect(0, 0, 1400, 700);
      fill(0, 200, 0);
      health = health + 1;//loose one health
    }//end if
  }//end for

  for (int i = 0; i < moreRedGhost; i++) {//loop all the red ghost
    //find all the red ghost distance
    distanceRedGhost[i] = int(sqrt(pow((xPos-redGhostXPos[i]), 2) + pow((yPos-redGhostYPos[i]), 2)));
    if (distanceRedGhost[i] < 50) {//if the red ghost distance is smaller than 50
      //indicate hit marker
      size(1400, 700);
      fill(200, 200, 200);
      rect(0, 0, 1400, 700);
      fill(0, 200, 0);
      health = health + 1;//loose one health
    }//end if
  }//end for

  if (keyCode == LEFT) {//if left button is clicked
    direction = LEFTDIR;//turn left
  } //end if
  if (keyCode == UP) {//if up button is clicked
    direction = UPDIR;//turn up
  } //end if
  if (keyCode == RIGHT) {//if right button is clicked
    direction = RIGHTDIR;//turn right
  } //end if
  if (keyCode == DOWN) {//if down button is clicked
    direction = DOWNDIR;//turn down
  }//end if

  //a counter to make the pacman moves
  chomp = chomp + mouth;

  //use if statement to make the pacman direction to change
  if (direction == RIGHTDIR) {
    xPos = xPos + 10;//make the pacman moves by 10 pixel
    arc(xPos, yPos, 50, 50, radians(30-chomp), radians(330+chomp)); //draw pacman right picture
  } //end if
  else if (direction == LEFTDIR) {
    xPos = xPos - 10;//make the pacman moves by 10 pixel
    arc(xPos, yPos, 50, 50, radians(210-chomp), radians(510+chomp)); //draw pacman left picture
  } //end if
  else if (direction == UPDIR) {
    yPos = yPos - 10;//make the pacman moves by 10 pixel
    arc(xPos, yPos, 50, 50, radians(300-chomp), radians(600+chomp)); //draw pacman up picture
  } //end if
  else if (direction == DOWNDIR) {
    yPos = yPos + 10;//make the pacman moves by 10 pixel
    arc(xPos, yPos, 50, 50, radians(120-chomp), radians(420+chomp)); //draw pacman down picture
  }//end if

  //make the pacman mouth open and close
  if (chomp == 30) {//if the counter is 30 
    mouth = -5;//change the direction of the mouth
  }//end if
  if (chomp == 0) {//if the counter becomes 0
    mouth = 5;//change the direction of the mouth
  }//end if

  //////////////////// Red Ghost 
  for (int i = 0; i < 2; i++) {
    if (distance[i] < 50) {//if the distance is smaller than 50
      int redGhostLocation = int(random(1, 8));//create random red ghost location
      if (redGhostLocation == 1) {//top left location
        redGhostXPos[moreRedGhost-1] = -200;//spawn the x position of the red ghost
        redGhostYPos[moreRedGhost-1] = -200;//spawn the y position of the red ghost
      }//end if
      else if (redGhostLocation == 2) {//top location
        redGhostXPos[moreRedGhost-1] = 700;//spawn the x position of the red ghost
        redGhostYPos[moreRedGhost-1] = -200;//spawn the y position of the red ghost
      }//end if
      else if (redGhostLocation == 3) {//top right location
        redGhostXPos[moreRedGhost-1] = 1600;//spawn the x position of the red ghost
        redGhostYPos[moreRedGhost-1] = -200;//spawn the y position of the red ghost
      }//end if
      else if (redGhostLocation == 4) {//right middle location
        redGhostXPos[moreRedGhost-1] = 1600;//spawn the x position of the red ghost
        redGhostYPos[moreRedGhost-1] = 700;//spawn the y position of the red ghost
      }//end if
      else if (redGhostLocation == 5) {//right bottom location
        redGhostXPos[moreRedGhost-1] = 1600;//spawn the x position of the red ghost
        redGhostYPos[moreRedGhost-1] = 900;//spawn the y position of the red ghost
      }//end if
      else if (redGhostLocation == 6) {//bottom middle location
        redGhostXPos[moreRedGhost-1] = 700;//spawn the x position of the red ghost
        redGhostYPos[moreRedGhost-1] = 900;//spawn the y position of the red ghost
      }//end if
      else if (redGhostLocation == 7) {//bottom left location
        redGhostXPos[moreRedGhost-1] = -200;//spawn the x position of the red ghost
        redGhostYPos[moreRedGhost-1] = 900;//spawn the y position of the red ghost
      }//end if
      else if (redGhostLocation == 8) {//left middle location
        redGhostXPos[moreRedGhost-1] = -200;//spawn the x position of the red ghost
        redGhostYPos[moreRedGhost-1] = 700;//spawn the y position of the red ghost
      }//end if
    }//end if
  }//end loop

  //loop all the red ghost to make them moves
  for (int i = 0; i < moreRedGhost; i++) {
    //set the ghost starting position
    redGhost(redGhostXPos[i]-50, redGhostYPos[i]-50);//draw the red ghost with the pos
    //use if statement to make the ghost catch the pacman
    if (redGhostXPos[i] <= xPos) {
      redGhostXPos[i] = redGhostXPos[i] + 1;//move by 1 pixel
    }//end if
    if (redGhostXPos[i] >= xPos) {
      redGhostXPos[i] = redGhostXPos[i] - 1;//move by 1 pixel
    }//end if
    if (redGhostYPos[i] >= yPos) {
      redGhostYPos[i] = redGhostYPos[i] - 1;//move by 1 pixel
    }//end if
    if (redGhostYPos[i] <= yPos) {
      redGhostYPos[i] = redGhostYPos[i] + 1;//move by 1 pixel
    }//end if
  }//end for loop

  ////////////////////////////////////////// Main Ghost
  if (wave > 30) {//if wave is greater than 30 show up the main ghost
    ghostSpeed[0] = 2;//the speed of the ghost
    ghostSpeed[1] = 3;//the speed of the ghost
    ghostSpeed[2] = 4;//the speed of the ghost
    ghostSpeed[3] = 5;//the speed of the ghost
    //use for loop to run all blue ghosts
    for (int i = 0; i < 4; i++) {
      //draw and set the blue ghosts starting position
      ghost(gXPos[i]-50, gYPos[i]-50);
      //use if statement to make the ghost catch the pacman
      if (gXPos[i] <= xPos) {
        gXPos[i] = gXPos[i] + ghostSpeed[i];//move the ghost with their individual speed type
      }//end if
      if (gXPos[i] >= xPos) {
        gXPos[i] = gXPos[i] - ghostSpeed[i];//move the ghost with their individual speed type
      }//end if
      if (gYPos[i] >= yPos) {
        gYPos[i] = gYPos[i] - ghostSpeed[i];//move the ghost with their individual speed type
      }//end if
      if (gYPos[i] <= yPos) {
        gYPos[i] = gYPos[i] + ghostSpeed[i];//move the ghost with their individual speed type
      }//end if
    }//end for loop

    count = count + 1;//counter for extra, just in case
    //set a new ghost position
    /*if (count == 500) {
     gXPos[0] = -100;
     gYPos[0] = -100;
     }//end if
     if (count == 1000) {
     gXPos[1] = 1500;
     gYPos[1] = -100;
     }//end if
     if (count == 1500) {
     gXPos[2] = -100;
     gYPos[2] = 800;
     }//end if
     if (count == 2000) {
     gXPos[3] = 1500;
     gYPos[3] = 800;
     }//end if
     if (count == 2500) {
     gXPos[4] = 700;
     gYPos[4] = -100;
     count = 0;
     }//end if*/
  }//end if
  if (health >= 3) {
    dead = true;
    while (dead == true) {
      size(1400, 700);
      fill(200, 200, 200);
      rect(0, 0, 1400, 700);
    }//end while
  }//end if
}//end draw

void ghost(int x, int y) {//create the blue ghost method
  pushMatrix();
  translate(x, y);//original position
  noStroke();//no line
  fill(10, 200, 250);//blue colour ghost
  ellipse(50, 50, 50, 50);//head
  rect(25, 50, 50, 25);//body
  ellipse(35, 75, 20, 20);//left leg
  ellipse(50, 75, 20, 20);//midle leg
  ellipse(65, 75, 20, 20);//right leg
  fill(250, 250, 250);//white eye colour 
  ellipse(40, 50, 10, 10);//left eye
  ellipse(60, 50, 10, 10);//right eye
  popMatrix();
}//end ghost

void redGhost(int x, int y) {//create the red ghost method
  pushMatrix();
  translate(x, y);//original position
  noStroke();//no line
  fill(200, 0, 0);//red colour ghost
  ellipse(50, 50, 50, 50);//head
  rect(25, 50, 50, 25);//body
  ellipse(35, 75, 20, 20);//left leg
  ellipse(50, 75, 20, 20);//midle leg
  ellipse(65, 75, 20, 20);//right leg
  fill(250, 250, 250);//white eye colour 
  ellipse(40, 50, 10, 10);//left eye
  ellipse(60, 50, 10, 10);//right eye
  popMatrix();
}//end ghost

void foodPoints(int x, int y) {//creathe th food points method
  int ranColour1;//create random colour variable
  int ranColour2;//create random colour variable
  int ranColour3;//create random colour variable
  ranColour1 = int(random(0, 255));//make the random from 0 to 255
  ranColour2 = int(random(0, 255));//make the random from 0 to 255
  ranColour3 = int(random(0, 255));//make the random from 0 to 255
  pushMatrix();
  fill(ranColour1, ranColour2, ranColour3);//foods colour
  spin = spin + 100;//make the food spin
  arc(x, y, 25, 25, radians(0 + spin), radians(90 + spin)); //draw the food
  popMatrix();
}//end powerUps

void dragSegment(int i, float xin, float yin) {//create the tail
  float dx = xin - xSnakeTail[i];//find the x distance
  float dy = yin - ySnakeTail[i];//find the y distance
  float angle = atan2(dy, dx);//make angle variable 
  xSnakeTail[i] = xin - cos(angle) * segLength;//the x angle position
  ySnakeTail[i] = yin - sin(angle) * segLength;//the y angle position
  segment(xSnakeTail[i], ySnakeTail[i], angle);//a method that draws the extension of the tail
}//end segment

void segment(float x, float y, float a) {//tail extension method
  pushMatrix();
  translate(x, y);//position of tail
  rotate(a);//rotate
  line(0, 0, segLength, 0);//draw line
  popMatrix();
}//end segment
