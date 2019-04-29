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
  Ufo myUfo;              // declare Ufo object
  Asteroid oneAsteroid;   // declare Asteroid object
  Collision myCollision;  // declare Collision object

  boolean startAsteroids, // boolean status flag to control the start of the asteroids
    shipExists,           // boolean status flag to track the existance of ship
    ufoExists,            // boolean status flag to track the existance of ufo.
    startGame,            // boolean status flag to control start game status 
    asteroidsExist;           // boolean status flag to monitor when asteroid arraylist equals zero

  ArrayList<Asteroid> myAsteroids = 
    new ArrayList<Asteroid>();      // declare Asteroid object ArrayList

  int level, // tracks the level of the game reached
    border;  // sets the border off screen to accomaodate shapes beyond edges

  /*
  AsteroidGame Constructor initialises objects, variables and loads media files.
   */
  AsteroidGame()
  {
    // initialise Ship object
    myShip = new Ship();

    // initialise Ufo object
    myUfo = new Ufo();
    
    // initialise Collision object
    myCollision = new Collision();

    // set integer variables

    border = 100;
    level = 1;

    // set boolean variables. 
    //NOTE WHEN EVENT HANDLING ADDED TO PROGRAM THESE WILL BE INITALISED TO FALSE

    startGame = true;
    startAsteroids = true;
    asteroidsExist = false;
    ufoExists = true;
  }
  
  /*
  Method to add Asteroid objects to the Asteroid object array list.
   */
  void addAsteroid()
  {
    if (startAsteroids && !asteroidsExist)
    {
      for (int i = 0; i < level; i ++)
      {
        myAsteroids.add(oneAsteroid = new Asteroid(new PVector(random(width), 0 - (2 * border)), 
          random(1, 1.5), 0));
      }                                            
      asteroidsExist = true;
    }
  }
  
  /*
  Method to update each Asteroid object in the Array list. 
   */
  void updateAsteroids()
  {
    if (startAsteroids && asteroidsExist)
    {
      // iterate through arraylist of current Asteroids
      for (int i = 0; i < myAsteroids.size(); i++)
      {
        // access each Asteroid objects methods to control movement
        myAsteroids.get(i).updateAsteroid();
        // add an image to the current location
        myAsteroids.get(i).displayAsteroid();
      }
    }
  } 
  
  /*
  Method to update the ufo 
  */
  void updateUfo()
  {
    if (startAsteroids)
    {
      myUfo.moveUfo(myShip.shipCoord);
      myUfo.ufoEdgeDetect();
      myUfo.displayUfo();
      myUfo.addShot(myShip.shipCoord);
      myUfo.updateShot();
    }
  }

  /*
  Method to update the ship
  */
  void updateShip()
  {
    if (startAsteroids)
    {
      myShip.moveShip();
      myShip.shipEdgeDetect();
      myShip.displayShip();
      myShip.addShot();
      myShip.updateShot();
    }
  }
  
  /*
  Method to update the collision
  */
  void updateCollision()
  {
    if (startAsteroids && asteroidsExist)
    {
      // collision detect between asteroids
      myCollision.collisionAsteroids(myAsteroids);
      // collision detect between player shots and asteroids
      myCollision.collisionShipShot_Asteroid(myAsteroids, myShip);
      // collision detect between
      myCollision.collisionShip_Asteroid(myAsteroids, myShip);
      if (myAsteroids.size() < 1)
      {
        asteroidsExist = false;
        // once all asteroids are destroyed more are deployed increasing by 1 asteriod for each level
        level += 1;
      }
    }

    if(startAsteroids && ufoExists)
    {
      myCollision.collisionShipShot_Ufo(myShip, myUfo);
      myCollision.collisionUfoShot_Ship(myUfo, myShip);
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
  background(0); // this will go in layout() method
  
  //asteroid
  myAsteroidGame.addAsteroid();
  myAsteroidGame.updateAsteroids();
  
  //ship
  myAsteroidGame.updateShip();

  //ufo
  myAsteroidGame.updateUfo();
  
  //collision
  myAsteroidGame.updateCollision();
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
