/**************************************************************
 * File: A3_Group14.pde
 * Group: 14; {Tegan Lee Barnes, Alison Bryce, Josh Le Gresley}.
 * Date: 12/04/2018
 * Course: COSC101 - Software Development Studio 1
 ***************************************************************/

//imoprt a java audio library
import ddf.minim.*;

/*
AsteroidGame class accesses the clases required to build up the Asteroids
 game implementation. User input events are monitored and passed to the relevent
 classes requiring this information. Sound files are called at input events. Game 
 play status is moitored with boolean flags and game flow is directed in the 
 relevent direction. Collision detection is monitored.
 */
 
class AsteroidGame
{

  Ship myShip; // declare Ship object
  Ufo myUfo; // declare Ufo object
  Asteroid oneAsteroid; // declare Asteroid object
  MainMenu myMenu; // declare MainMenu object

  boolean startAsteroids, // boolean status flag to control the start of the asteroids/game
    ufoExists, // boolean status flag to track the existance of ufo.
    asteroidsExist, // boolean status flag to monitor when asteroid arraylist equals zero
    ufoTiming, // boolean status flag to track when the timer between ufos has been set
    shipHit, // boolean status flag to track if the ship has been hit and is dead or alive
    textTiming, // boolean status flag to track display time of level message
    newLevel, // boolean status flag to show a new level has been reached
    menuLooping, // boolean status flag to control game menu audio
    menuMainVisible, // boolean status flag to set main menu screen visible
    menuDifficultyVisible, // boolean status flag to set difficulty screen visible
    menuInstructionsVisible, // boolean status flag to set instructions screen visible
    gameEnded, // boolean status flag to control game over audio
    launching, // boolean status flag to control launch audio
    gameOver; // boolean status flag to direct game flow to game over screen


  ArrayList<Asteroid> myAsteroids = 
    new ArrayList<Asteroid>(); // declare Asteroid object ArrayList
    
  ArrayList<Explosion> myExplosions = 
    new ArrayList<Explosion>(); // declare Explosion object ArrayList

  int level, // tracks the level of the game reached
    prevLevel, // stores the starting level of the current game
    ufoTimer, // stores the time starting at the point of when a ufo is destroyed till next ufo released
    textTimer, // stores starting tie to display level messege
    border;  // sets the border off screen to accomaodate shapes beyond edges

  float ufoInterval, // stores a random interval to time between ufo releases
    textInterval; // stores an interval to display the next level message

  boolean[] keyIsPressed; // boolean array to store a boolean corrosponding to keypress event.
  PVector[] starsBackground; // PVector array to store locations of stars for moving background.
  float[] starSpeed; // float array to set the speed of the star
  
  int[][] button; // 2D int array to store menu button detect coorinates

  String start; // Sting to store the game start messege

  PFont font; // declare a Pfont object

  /*
  AsteroidGame Constructor initialises objects, variables and loads media files.
   */
  AsteroidGame()
  {
    // initialise Ship object
    myShip = new Ship();
    
    // initialise menu object
    myMenu = new MainMenu();

    // set variables

    border = 15;
    textInterval = 2;

    // set game boolean variables. 

    startAsteroids = false;
    asteroidsExist = false;
    ufoExists = false;
    ufoTiming = false;
    shipHit = false;
    newLevel = false;
    gameOver = false;
    textTiming = false;
    newLevel = true;
    menuLooping = false;
    gameEnded = false;
    launching = true;

    // set menu boolean variables.

    menuMainVisible = true;
    menuDifficultyVisible = false;
    menuInstructionsVisible = false;

    // create a boolean array to monitor which keys are pressed. 256 corrosponds to the
    // number of ASCII characters
    keyIsPressed = new boolean[256];

    // load font
    font = createFont("Pixel-Miners.otf", 32);
    textFont(font);
    
    // 2D Array to store coordinates for menu button detect.
    // Each array has a x min, x max, y min y max. Using this stategy allows there to
    // be tight edge detection just surrounding the text.
    button = new int [][]{{291, 505, 371, 403}, // "NEW GAME"
                          {256, 536, 471, 501},  // "HOW TO PLAY"
                          {344, 447, 571, 602},  // "EXIT"
                          {341, 457, 271, 303},  // "EASY"
                          {314, 480, 372, 402},  // "MEDIUM"
                          {341, 455, 472, 501},  // "HARD"
                          {281, 450, 671, 700},  // "MAIN MENU"
                          {275, 524, 491, 517},  // "PLAY AGAIN?"
                          {337, 456, 590, 639},  // "EXIT"
                          {264, 531, 680, 739}}; // "MAIN MENU"

    // CREATE A MOVING BACKGROUND

    // create a PVector array to store locations of stars in game background
    starsBackground = new PVector[100];
    // create a float array with corrosponding speed values for each star
    starSpeed = new float[100] ;

    // use a for loop to construct the stars Background and starsSpeed arrays
    for (int i = 0; i < starsBackground.length; i++)
    {
      starsBackground[i] = new PVector(random(0, width), random(0, height));
      starSpeed[i] = random(1, 5);
    }
  }

  /*
  Method to set up game screen.
   */
  void layout()
  {
    background(0);
    stroke(255);
    // set to start on main menu
    if (!startAsteroids && !gameOver)
    {
      // activate text highlighting
       myMenu.textHighlight(button);
       
      // loop audio on menu
      if(!menuLooping)
      {
        myAudio.loopMenuSound();
        menuLooping = true;
      }
      
      if (menuMainVisible)
      {
        myMenu.displayMenu();
      }
      else if (menuDifficultyVisible)
      {
        myMenu.displayDifficultyMenu();
      }
      else if (menuInstructionsVisible)
      {
        myMenu.displayInstructions();
      }
    } 
    else if (!startAsteroids && gameOver)
    {
      // activate text highlighting
      myMenu.textHighlight(button);
       
      myMenu.displayEndGame();
    }
    // enter game 
    else
    {
      // pause menu audio
      myAudio.pauseLoopMenuSound();
      
      //Draw moving background
      for (int i = 0; i < starsBackground.length; i++)
      {
        if (starsBackground[i].x < 0)
        {
          starsBackground[i].x = width;
        }
        starsBackground[i].sub(new PVector(starSpeed[i] / 2, 0));
        strokeWeight(starSpeed[i]);
        point(starsBackground[i].x, starsBackground[i].y);
      }
      
      if(launching)
      {
        // play launching audio
        myAudio.playLaunch();
        launching = false;
      
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
  Method to add Ufo object at random intervals.
   */
  void addUfo()
  {
    if (startAsteroids && !ufoExists)
    {
      if (!ufoTiming)
      {
        // start a timer to time interval between ufo attacks
        ufoTimer = millis();
        ufoInterval = random(30, 40);
        ufoTiming = true;
      } else if ((millis() - ufoTimer) / 1000  > ufoInterval)
      {
        // initialise Ufo object
        myUfo = new Ufo();
        ufoExists = true;
        // call audio object to play ufo sound
        myAudio.loopUfoSound();
      }
    }
  }

  /*
  Method to update the ufo 
   */
  void updateUfo()
  {
    if (startAsteroids && ufoExists)
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
      myShip.moveShip(keyIsPressed);
      myShip.shipEdgeDetect();
      myShip.displayShip();
      myShip.addShot(keyIsPressed);
      myShip.updateShot();
    }
  }

  /*
  Method to check there are lives left and display that the game is over 
   when all lives are lost.
   */
  void checkLives()
  {
    if (startAsteroids)
    {
      myShip.shipLives();
    }
    if (myShip.lives == 0 && !gameEnded)
    {
      // call audio object to play game over sound
      myAudio.playGameOver();
      // pause ufo audio if playing
      if (ufoExists)
      {
        myAudio.pauseLoopUfoSound();
      }
      gameEnded = true;
      startAsteroids = false;
      gameOver = true;
    }
  }

  /*
  Method to update the display the score
   */
  void displayScore()
  {
    if (startAsteroids)
    {
      myShip.gameScore();
    }
  }  

  /*
  Method to display the next level change.
   The text is in this location to counter the effect of translation
   in the shipLives function.
   */
  void nextLevel()
  {
    if (startAsteroids && asteroidsExist)
    {
      if (newLevel && !textTiming)
      {
        // start a timer to display a message for a specific interval
        textTimer = millis();
        textTiming = true;
      } else if ((millis() - textTimer) / 1000  < textInterval)
      {
        fill(#24DE14);
        textSize(55);
        textAlign(CENTER, CENTER);
        text("LEVEL: " + level, 0, 0, width, height);
      } else
      {
        newLevel = false;
        textTiming = false;
      }
    }
  }

  /*
  Method to collision detect between Asteriods 
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
  Method to collision detect between ufo/ ufo shots and space ship
   */
  void collisionUfoShot_Ship()
  {
    if (startAsteroids && ufoExists)
    {
      if (myUfo.equals(myShip))
      {
        // the ship loses a life and restarts in the center
        myShip.lives -= 1;
        myShip.shipCoord.x = width/2;
        myShip.shipCoord.y = height/2;
        // call audio object to ship hit sound
        myAudio.playShipHit();
      }
    }
  }

  /*
  Method to collision detect between player shots and the asteroids
   */
  void collisionShipShot_Asteroid()
  {
    if (startAsteroids && asteroidsExist)
    {
      // Iterate over asteroid list in reverse. This way if new asteroids are added to the 
      // list mid iterate they are not included in the current collision detect
      for (int i = myAsteroids.size()-1; i >= 0; i--)
      {
        if (myShip.equalsAsteroid(myAsteroids.get(i)))
        {
          // if a hit is detected the resulting action depends on the number of hits already sustained
          if (myAsteroids.get(i).hits < 2)
          {
            myAsteroids.addAll(myAsteroids.get(i).splitAsteroid());
            
            myAsteroids.remove(myAsteroids.get(i));

            // call audio object to ship hit sound
            myAudio.playAstHit();
          } else
          {
            // add explosion object to creat explosion 
            myExplosions.add(new Explosion(myAsteroids.get(i).asteroidLocation));
            
            myAsteroids.remove(myAsteroids.get(i));
   
            // call audio object to ship hit sound
            myAudio.playAstHit();
          }
        }
      }
      if (myAsteroids.size() < 1)
      {
        asteroidsExist = false;

        // once all asteroids are destroyed more are deployed increasing by 1 asteriod for each level
        level += 1;
        // call audio object to play next level sound
        myAudio.playLevelUp();
        
        // ship restarts in the center
        myShip.shipCoord.x = width/2;
        myShip.shipCoord.y = height/2;
        
        // level up points added to score
        myShip.score += 500;
        newLevel = true;
        myShip.setLives(3);
      }
    }
  }

  /*
   Method to collision detect between player shots and ufo
   */
  void collisionShipShot_Ufo()
  {
    if (startAsteroids && ufoExists)
    {
      if (myShip.equalsUfo(myUfo))
      {
        // add explosion object to creat explosion 
        myExplosions.add(new Explosion(myUfo.ufoLocation));
            
        myUfo = null;
        ufoExists = false;
        ufoTiming = false;
        // call audio object to pause ufo sound and sound explosion
        myAudio.pauseLoopUfoSound();
        myAudio.playUfoHit();
      }
    }
  }

  /*
  Method to collision detect ship location and the asteroids
   */
  void collisionShip_Asteroid()
  {
    if (startAsteroids && asteroidsExist)
    {
      for (int i = 0; i < myAsteroids.size(); i ++)
      {
        if (myAsteroids.get(i).equals(myShip))
        {
          // call audio object to ship hit sound
          myAudio.playShipHit();
          shipHit = true;
          // the ship loses a life and restarts in the center
          myShip.lives -= 1;
          myShip.shipCoord.x = width/2;
          myShip.shipCoord.y = height/2;
        }
      }
    }
  }
  
  /*
  Method to update the Explosion objects created in the myExplosions ArrayList
  */
  void updateExplosion()
  {
    if (startAsteroids && asteroidsExist)
    {
      if(myExplosions.size() >= 1)
      {
         for (int i = 0; i < myExplosions.size(); i ++)
         {
           if(myExplosions.get(i).explosionExists)
           {
             myExplosions.get(i).moveTrails();
           }
           else
           {
             myExplosions.remove(i);
           }
         }
      }
    }
  }

  /*
  Method called from the built-in keyPressed() method. This method works along side the
   keyRelease() method below to handle key press and key release events. The concept used
   was sourced from code on https://forum.processing.org. It was including because it
   provides a concise way to store all key input events (press or release) in an array.
   They can then be passed to classes that require access to them. The array keyIsPressed
   can hold 256 boolean values, corrosponding to each ASCII value. The values are set to
   true on key press events and false on key release events.
   */
  void keyPress() 
  {
    keyIsPressed[keyCode] = true;
  }

  /*
  Method called from the built-in keyReleased() method. See keyPress method (above)
   for description of functionality.
   */
  void keyRelease() 
  {
    keyIsPressed[keyCode] = false;
  }

  /*
  Method to create cursor image and hide the cursor during game play
  */  
  void hideCursor()
  {
    noCursor();
    if (!startAsteroids)
      {
        pushMatrix();
        translate(mouseX, mouseY);
        rotate(-PI/4);
        shape(myShip.drawShip, 0, 0);
        popMatrix();
    }
  }
  /*
  Method called from the built-in mousePressed() method. Monitors mouse clicks on 
   the menu page
   */
  void mousePress() 
  {
    // Controls flow of mouse clicks through the main menu
    if (!startAsteroids && !gameOver)
    {
      // Main menu mouse handling
      if (menuMainVisible)
      {
        // detect difficulty options
        if (myMenu.buttonDetect(button, 0))
        {
          myAudio.playMenuClick();
          menuMainVisible = false;
          menuDifficultyVisible = true;
          menuInstructionsVisible = false;
        }

        // detect instructions option
        else if (myMenu.buttonDetect(button, 1))
        {
          myAudio.playMenuClick();
          menuMainVisible = false;
          menuDifficultyVisible = false;
          menuInstructionsVisible = true;
        } 
        // detect exit option
        else if (myMenu.buttonDetect(button, 2))
        {
          myMenu.gameExit();
        }
        // Difficulty screen mouse handling
      } else if (menuDifficultyVisible)
      {
        // easy level selection
        if (myMenu.buttonDetect(button, 3))
        {
          myAudio.playMenuClick();
          level = 1;
          prevLevel = level;
          startAsteroids = true;
        } 
        // medium level selection
        else if (myMenu.buttonDetect(button, 4))
        {
          myAudio.playMenuClick();
          level = 3;
          prevLevel = level;
          startAsteroids = true;
        } 
        // hard level selection
        else if (myMenu.buttonDetect(button, 5))
        {
          myAudio.playMenuClick();
          level = 5;
          prevLevel = level;
          startAsteroids = true;
        } 
        // return to main menu selection
        else if (myMenu.buttonDetect(button, 6))
        {
          myAudio.playMenuClick();
          menuMainVisible = true;
          menuDifficultyVisible = false;
          menuInstructionsVisible = false;
        }
        // Instructions screen mouse handling
      } else if (menuInstructionsVisible)
      {
        // return to main menu selection
        if (myMenu.buttonDetect(button, 6))
        {
          myAudio.playMenuClick();
          menuMainVisible = true;
          menuDifficultyVisible = false;
          menuInstructionsVisible = false;
        }
      }
    }
    // Controls flow of mouse clicks on the gameover screen
    else if (!startAsteroids && gameOver)
    {
      // detect play again option
      if (myMenu.buttonDetect(button, 7))
      {
        myAudio.playMenuClick();
        reset(prevLevel, true);
      }
      // detect exit option
      else if (myMenu.buttonDetect(button, 8))
      {
        myMenu.gameExit();
      }
      // return to main menu selection
      else if (myMenu.buttonDetect(button, 9))
      {
        myAudio.playMenuClick();
        menuMainVisible = true;
        menuDifficultyVisible = false;
        menuInstructionsVisible = false;
        reset(1, false);
      }
    }
  }
  
  /*
  Method to reset the game again at a selected dificulty level. Game will either
  restart at the selected level or return to menu screen depending on boolean start
  parameter.
  @PARAM: level is an int of the previously choosen level
  @PARAM: start is a boolean to tell the game to start playing or not 
  */
  void reset(int storedLevel, boolean start)
  {
    level = storedLevel;
    myAsteroids = new ArrayList<Asteroid>();
    startAsteroids = start;
    asteroidsExist = false;
    ufoExists = false;
    ufoTiming = false;
    shipHit = false;
    gameOver = false;
    textTiming = false;
    newLevel = true;
    menuLooping = false;
    gameEnded = false;
    launching = true;
    
    // reset ship
    myShip.setLives(3);
    myShip.setScore(0);
    myShip.shipDirection.x = 0;
    myShip.shipDirection.y = 0;
    keyIsPressed = new boolean[256];
  }
}

// Declare AsteroidGame object
AsteroidGame myAsteroidGame;
Audio myAudio;

/*
Setup initialises the AsteroidGame and sets the screen size.
 */
void setup()
{
  // set screen size
  size(800, 800);

  // Initialise objects
  myAsteroidGame = new AsteroidGame();
  myAudio = new Audio(this);
}

/*
The draw loop controls the calls for Asteroid game play
 */
void draw()
{
  // layout and menu
  myAsteroidGame.layout();
  myAsteroidGame.hideCursor();  

  //asteroid
  myAsteroidGame.addAsteroid();
  myAsteroidGame.updateAsteroids();
  myAsteroidGame.collisionAsteroids();
  myAsteroidGame.collisionShip_Asteroid();
  myAsteroidGame.updateExplosion();

  //ship
  myAsteroidGame.updateShip();
  myAsteroidGame.collisionShipShot_Asteroid();
  myAsteroidGame.collisionShipShot_Ufo();
  myAsteroidGame.checkLives();
  myAsteroidGame.displayScore();
  myAsteroidGame.nextLevel();

  //ufo
  myAsteroidGame.addUfo();
  myAsteroidGame.updateUfo();
  myAsteroidGame.collisionUfoShot_Ship();
  
}

/*
Built in function KeyPressed() initially has no functionality, until the player mouse
 clicks to select play game. This action sets the startGame flag to true and sets the
 game screen to 'ready to play'. Now the game waits for the player to input any click to
 commence play (which starts the asteroids). Once in 'game play' mode any clicks invoke
 the keyPress() method which updates the keyIsPressed boolean array.
 */
void keyPressed()
{
  if (myAsteroidGame.asteroidsExist)
  {
    {
      myAsteroidGame.keyPress();
    }
  }
}

/*
  Initially mousedPressed() is the players only way to interact with the game. Options
 on the main menu can be selected by clicking on the selectable areas. As options are
 selected the boolean flags are updated to relevant position in the menu.
 */
void mousePressed()
{
  if (!myAsteroidGame.startAsteroids)
  {
    myAsteroidGame.mousePress();
  }
}

/*
Like keyPressed(), keyReleased() has no functionality until 'play game' mode. Once at 
 this point any clicks invoke the keyRelease() method which updates the keyIsPressed 
 boolean array.
 */
void keyReleased() 
{
  if (myAsteroidGame.startAsteroids)
  {
    myAsteroidGame.keyRelease();
  }
}
