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
        sLEFT = false,
        shotReady = true;

class AsteroidGame
{
  Ship myShip;            // declare Ship object
  
  boolean startAsteroids, // boolean status flag to control the start of the asteroids
          shipExists,     // boolean status flag to track the existance of ship
          ufoExists,      // boolean status flag to track the existance of ufo.
          startGame,                // boolean status flag to control start game status 
          asteroidsExist;           // boolean status flag to monitor when asteroid arraylist equals zero
          

  Ufo myUfo;              // declare Ufo object
  
          

  Asteroid oneAsteroid;             // declare Asteroid object

  ArrayList<Asteroid> myAsteroids = 
    new ArrayList<Asteroid>();      // declare Asteroid object ArrayList

  int level,                        // tracks the level of the game reached
      border;                       // sets the border off screen to accomaodate shapes beyond edges

  /*
  AsteroidGame Constructor initialises objects, variables and loads media files.
   */
  AsteroidGame()
  {
    // initialise Ship object
    myShip = new Ship();

    // initialise Ufo object
    myUfo = new Ufo();
    
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
  
  void updateUfo()
  {
    if(startAsteroids)
    {
      myUfo.moveUfo(myShip.shipCoord);
      myUfo.ufoEdgeDetect();
      myUfo.displayUfo();
      myUfo.addShot(myShip.shipCoord);
      myUfo.updateShot();
    }
  }
  
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
  
  /*
  Method to collision detect ufo shots and space ship
  */
  void collisionShot_Ship()
  {
    if (startAsteroids && ufoExists)
    {
      // Iterate over ufoShots Array list
      for (int i = 0; i <  myUfo.ufoShots.size(); i++)
      {
        //TODO MOUSE LOCATION REPLACED BY SHIP LOCATION
        if(myUfo.equals(myShip.shipCoord.x, myShip.shipCoord.y))
        {
          // TODO PLAYER SHOULD LOSE A LIFE AT THIS POINT
          print("hit");
        }
      }
    }
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
  Method to collision detect between Asteriods in the game
   */
  void collisionAsteroids()
  {
    if (startAsteroids && asteroidsExist)
    {
      // outer loop iterates over all Asteroid objects except last one
      for (int i = 0; i < myAsteroids.size() - 1; i++)
      {
        // inner loop iterates over all Asteroid objects except first one (prevents checking against self)
        for (int j = i + 1; j < myAsteroids.size(); j++)
        {
          // equals method in Asteroid object called to see if locations are in a certain radius
          if (myAsteroids.get(i).equals(myAsteroids.get(j)))
          {
            // if equal collisionAsteroid() method called to change both asteroids motion
            myAsteroids.get(i).collisionAsteroid(myAsteroids.get(j));
          }
        }
      }
    }
  }


  /*
  Method to collision detect shots and the asteroids
   */
  void collisionShot_Asteroid()
  {
    if (startAsteroids && keyPressed && asteroidsExist)
    {
      // Iterate over asteroid list in reverse. This way if new asteroids are added to the 
      // list mid iterate they are not included in the current collision detect
      for (int i = myAsteroids.size()-1; i >= 0; i--)
      {
        // use circular collision detect algorithm
        if ((abs(mouseX - myAsteroids.get(i).asteroidLocation.x) < 10) 
          && (abs(mouseY - myAsteroids.get(i).asteroidLocation.y)) < 10)
        {
          // if a hit is detected the resulting action depends on the number of hits already sustained
          if (myAsteroids.get(i).hits < 2)
          {
            myAsteroids.addAll(myAsteroids.get(i).splitAsteroid());
            myAsteroids.remove(myAsteroids.get(i));
          } else
          {
            myAsteroids.remove(myAsteroids.get(i));
          }
        }
      }

      if (myAsteroids.size() < 1)
      {
        asteroidsExist = false;
        // once all asteroids are destroyed more are deployed increasing by 1 asteriod for each level
        level += 1; 

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
  background(0); // this will go in layout() method
  //ship
  myAsteroidGame.updateShip();
  myAsteroidGame.collisionShot_Ship();
  
  //ufo
  myAsteroidGame.updateUfo();
  
  //asteroid
  myAsteroidGame.addAsteroid();
  myAsteroidGame.updateAsteroids();
  myAsteroidGame.collisionAsteroids();
  myAsteroidGame.collisionShot_Asteroid();
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
  if (key == ' ') {
    shotReady = true;
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
