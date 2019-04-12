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
  Asteroid oneAsteroid;              // declare Asteroid object
  
  boolean startGame,                 // boolean status flag to control start game status 
          startAsteroids;            // boolean status flag to control the start of the asteroids
          
  ArrayList<Asteroid> myAsteroids = 
          new ArrayList<Asteroid>(); // declare Asteroid object ArrayList
          
  int totalAsteroids,                // total number of asteroid objects to create.
      startTime,                     // stores the millisecond starting point of timer
      totalTime,                     // time accumulator
      timeGap;                       // sets an asteroid every 5 secs

  /*
  AsteroidGame Constructor initialises objects, variables and loads media files.
  */ 
  AsteroidGame()
  {
    // set integer variables
                      
    totalAsteroids = 10;   
    startTime = 0;
    totalTime = 0;            
    timeGap = 500; 
    
    // set boolean variables. 
    //NOTE WHEN EVENT HANDLING ADDED TO PROGRAM THESE WILL BE INITALISED TO FALSE
    
    startGame = true;
    startAsteroids = true;
  
  }
  
   /*
  Method to add Asteroid objects to the Asteroid object array list.
  */
  void addAsteroid()
  {
    if(startAsteroids)
    {
      // at start of game first asteroid gets created
      if(myAsteroids.size() < 1)
      {
         myAsteroids.add(oneAsteroid = new Asteroid());
         startTime = millis();
      }
      // after the first the objects are created by the timeGap interval
      else
      {
        int split = (millis() - startTime)/1000;
        totalTime += split;
        if(myAsteroids.size() < totalAsteroids && totalTime > timeGap)
        {
          myAsteroids.add(oneAsteroid = new Asteroid());
          totalTime = 0;
          startTime = millis();
        }
      }
    }
  }
  
  /*
  Method to update each Asteroid object in the Array list. 
  */
  void updateAsteroids()
  {
    if(startAsteroids)
    // iterate through arraylist of current Asteroids
    for(int i = 0; i < myAsteroids.size(); i++)
    {
      // condition to check if asteroid is not hit
      if(!myAsteroids.get(i).hit)
      {
        // access each Asteroid objects methods to control movement
        myAsteroids.get(i).updateAsteroid();
        // add an image to the current location
        myAsteroids.get(i).displayAsteroid();
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
  myAsteroidGame.addAsteroid();
  myAsteroidGame.updateAsteroids();
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
