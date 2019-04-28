/**************************************************************
* File: A3_GROUP14.pde
* Group: 14; {Tegan Lee Barnes, Alison Bryce, Josh Le Gresley}.
* Date: 12/04/2018
* Course: COSC101 - Software Development Studio 1
*
* Description: 
Astroids is a classic multidirection shooter archade game. The player controls 
a space ship in an asteroid field, the aim being to survive as long as possible 
whilst shooting the asteroids to increase their score. UFO's will also attack 
the players space ship at random intervals.The game becomes harder as the number 
of asteroids and their velocity increases.
*
* Usage: 
To compile and run the .pde file, download the Processing editor from the 
processing website: https://processing.org/download/. The proceesing editor will 
compilethe processing language to Java and run the program.
*
* Notes: 
All audio samples sourced from https://freesound.org.
Font is sourced from https://www.fontspace.com.
Any Code Sampled from online sources is commented in method or class headings.
**************************************************************/

/*
AsteroidGame class accesses the clases required to build up the Asteroids
game implementation. User input events are monitored and passed to the relevent
classes requiring this information. Sound files are called at input events. Game 
play status is moitored with boolean flags and game flow is directed in the 
relevent direction. Collision detection is monitored.
*/

// Global key code variables
boolean sUP = false,
        sDOWN = false,
        sRIGHT = false,
        sLEFT = false;

class AsteroidGame
{
  Ship myShip;            // declare Ship object
  
  boolean startAsteroids, // boolean status flag to control the start of the asteroids
          shipExists;     // boolean status flag to track the existance of ship
          
  /*
  AsteroidGame Constructor initialises objects, variables and loads media files.
  */ 
  AsteroidGame()
  {
    // initialise Ship object
    myShip = new Ship();
    
    void updateShip()
    {
      if(startAsteroids)
      {
        myShip.moveShip();
        myShip.shipEdgeDetect();
        myShip.displayShip();
        myShip.addShot();
        myShip.updateShot();
      }
    }
  }
}

// Declare AsteroidGame object
AsteroidGame myAsteroidGame;

/*
Setup initialises the AsteroidGame and sets the screen size.
*/
void setup()
{
  // set screen size
  size(800, 800);
  
  // Initialise objects
  myAsteroidGame = new AsteroidGame();
}

/*
The draw loop controls the calls for Asteroid game play
*/
void draw()
{
  myAsteroidGame.updateShip();
}

/*
Built in function.
*/ 
void keyPressed()
{
  if (key == CODED) {
    if (keyCode == UP) {
      sUP = true;
    }
    if (keyCode == DOWN) {
      sDOWN = true;
    } 
    if (keyCode == RIGHT) {
      sRIGHT = true;
    }
    if (keyCode == LEFT) {
      sLEFT = true;
    }
  }
}

/*
Built in function.
*/
void mousePressed()
{
  
}

/*
Built in function.
*/
void keyReleased() 
{
  if (key == CODED) {
    if (keyCode == UP) {
      sUP = false;
    }
    if (keyCode == DOWN) {
      sDOWN = false;
    } 
    if (keyCode == RIGHT) {
      sRIGHT = false;
    }
    if (keyCode == LEFT) {
      sLEFT = false;
    }
  } 
}
