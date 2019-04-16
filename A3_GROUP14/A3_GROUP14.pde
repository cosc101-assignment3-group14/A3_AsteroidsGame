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

class AsteroidGame
{
  Ufo myUfo;

  /*
  AsteroidGame Constructor initialises objects, variables and loads media files.
  */ 
  AsteroidGame()
  {
    myUfo = new Ufo();
  }
  
  void updateUfo()
  {
    myUfo.moveUfo(new PVector(mouseX, mouseY));
    myUfo.ufoEdgeDetect();
    myUfo.displayUfo();
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
  background(0);
  myAsteroidGame.updateUfo();
}

/*
Built in function.
*/ 
void keyPressed()
{

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
 
}
