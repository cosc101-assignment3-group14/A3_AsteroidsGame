/**************************************************************
 * File: Ship.pde
 * Group: 14; {Tegan Lee Barnes, Alison Bryce, Josh Le Gresley}.
 * Date: 12/04/2018
 * Course: COSC101 - Software Development Studio 1
 ***************************************************************/

/*
The Ship class creates the ship object for the AsteroidsGame class.
 */
class Ship
{
  Shot oneShot; // declare a Shot object

  PVector shipCoord, // declare PVector object for ship's location
    shipDirection; // declare PVector object for ship's direction

  ArrayList<Shot> shipShots = 
    new ArrayList<Shot>(); // declare Shots object ArrayList

  PShape drawShip; // declare PShape object

  float speed, // the speed to increase by when ship moves
    maxSpeed, // maximum speed for the ship
    angle, // angle to rotate the image by
    direction; // direction the ship is heading

  int sWidth = 14, // ship width
    sLength = 18, // ship length
    lives = 3, // number of lives
    score = 0; // score accumulator

  boolean shotFired, // boolean flag to state if a shot has been fired or not
    shipHit, // boolean flag to state if the ship has been hit
    shipStatus, // boolean flag used to state if locations are equal to ufo
    shotReady; // boolean flag to control the status of the user input events

  String shotColour; // hexidecimal of shot colour

  /*
  Ship constructor 
   */
  Ship()
  {     
    // create PVectors for ship movement
    shipCoord = new PVector(width/2, height/2);
    shipDirection = new PVector(0, 0);

    // create PShape object
    generateShipShape();

    // set motion control variables 
    speed = 0.5;
    maxSpeed = 2;
    angle = radians(270);

    //set status flags
    shotFired = false;
    shipHit = true;
    shotReady = true;

    //shot colour
    shotColour = "FF006699";

    // The following code adds one shot to the array from the start, far off screen. 
    //  This fixed a bug of the initial shot occasionally causing all asteroids to 
    //  vanish at once.
    shipShots.add(oneShot = new Shot( new PVector(-200, -200), 
      new PVector(0, 0), 0, shotColour));
  }

  /*
  Method to set ship score.
   @PARAM liv: is an int to set score to
   */
  void setScore(int sc)
  {
    score = sc;
  }

  /*
  Overloaded setScore Method to update ship score in game play.
   @PARAM liv: is an int to increase score by
   @PARAM playing: is a boolean to state if in game play
   */
  void setScore(int sc, boolean playing)
  {
    if (playing)
    {
      score += sc;
    }
  }

  /*
  Method to set ship lives
   @PARAM liv: is an int to set lives to
   */
  void setLives(int liv)
  {
    lives = liv;
  }

  /*
  Overloaded set lives method to set ship lives in game play
   @PARAM liv: is an int to reduce lives by
   @PARAM playing: is a boolean to state if in game play
   */
  void setLives(int liv, boolean playing)
  {
    if (playing)
    {
      lives -= liv;
    }
  }

  /*
  Method to get ship lives
   */
  int getLives()
  {
    return lives;
  }

  /*
  Method the display the amount of lives left. A triangle is displayed for 
   every life left, translated two times the width of the triangle.
   */
  void shipLives()
  {
    if (lives != 0)
    {
      pushMatrix();
      for (int i = 0; i < lives; i ++)
      {   
        translate(sWidth*2, 0);
        stroke(255);
        strokeWeight(2);
        fill(0);
        triangle(-sWidth/2, sLength, 0, 0, sWidth/2, sLength);
      }
      popMatrix();
    }
  }

  /*
  Method to display score. Score is aligned below the displayed lives.
   */
  void gameScore()
  {
    fill(150);
    textSize(15);
    textAlign(LEFT, TOP);
    text("Score: " + score, sWidth, sLength*2, width, height);
  }  

  /*
  Method to update the movement of the ship relative to the player's ship current 
   location. The direction is added to the ship's coordinates.
   @PARAM keypress: boolean array storing a boolean at each keypressed event's
   corrosponding ASCII value.
   */
  void moveShip(boolean [] keypress)
  {
    if (keypress[UP])
    {
      shipDirection.add(new PVector(0, -speed));
    }
    if (keypress[DOWN])
    {
      shipDirection.add(new PVector(0, speed));
    }
    if (keypress[LEFT]) 
    {
      shipDirection.add(new PVector(-speed, 0));
    }
    if (keypress[RIGHT]) 
    {
      shipDirection.add(new PVector(speed, 0));
    }

    // The amount of speed added to direction is limited by maxSpeed.
    shipDirection.limit(maxSpeed);
    shipCoord.add(shipDirection);
  }

  /*
  Method to wrap the ship around the edges of the screen.
   */
  void shipEdgeDetect()
  {
    if (shipCoord.x > width)
    {
      shipCoord.x = 0;
    } else if (shipCoord.x < 0) 
    {
      shipCoord.x = width;
    }
    if (shipCoord.y > height)
    {
      shipCoord.y = 0;
    } else if (shipCoord.y < 0)
    {
      shipCoord.y = height;
    }
  }

  /*
  Method called from the constructor to generate the drawShip PShape object.
   */
  void generateShipShape()
  {
    // Our ship
    stroke(255);
    strokeWeight(2);
    fill(0);
    drawShip = createShape(TRIANGLE, -sWidth/2, sLength, 0, 0, sWidth/2, sLength);
  }

  /*
  Method to rotate the drawShip PShape object and display it to screen.
   */
  void displayShip()
  {
    pushMatrix();
    // translates and rotates the PShape detail
    translate(shipCoord.x, shipCoord.y);
    rotate(shipDirection.heading()-angle); 
    // draws the shape object to the current location
    shape(drawShip, 0, 0);
    popMatrix();
  }

  /*
  Method to fire shots at random intervals.
   @PARAM keypress: boolean array storing a boolean at each keypressed event's
   corrosponding ASCII value.
   */
  void addShot(boolean[] keypress)
  {
    if (keypress[' '] && shotReady) 
    {
      shipShots.add(oneShot = new Shot(shipCoord, shipDirection, 
        shipDirection.heading(), shotColour));
      shotFired = true;
      shotReady = false;
      // call audio object to play shot sound
      myAudio.playShot();
    } else if (!keypress[' '])
    {
      shotReady = true;
    }
  } 

  /*
  Method to update the shot trajectory once fired.
   */
  void updateShot()
  {
    if (shotFired)
    {
      for (int i = 0; i < shipShots.size(); i++)
      {
        shipShots.get(i).moveShot();
        shipShots.get(i).displayShot();
      }
    }
  }

  /*
  Method to check if asteroid locations are equal to ship shot location. 
   It does this by using a circular collision detection algorithm.
   @PARAMS: ast is an Asteroid object
   @Return: A boolean true if equal, false if not.  
   */
  boolean equalsAsteroid(Asteroid ast)
  {
    // First check shot locations
    for (int i = 0; i <  shipShots.size(); i++)
    {
      if ((abs(ast.asteroidLocation.x - shipShots.get(i).shotLocation.x) < 
        (ast.radius * ast.scale)) && 
        (abs(ast.asteroidLocation.y - shipShots.get(i).shotLocation.y)) < 
        (ast.radius * ast.scale))
      {
        shipStatus = true;
        // remove shot from array once used
        shipShots.remove(i);
        // score increases 10 points for hitting the asteroid
        score += 10;
      } else
      {
        shipStatus = false;
      }
    }
    return shipStatus;
  }

  /*
  Method to check if the ship's shot locations are equal to the ufo location. 
   It does this by using a circular collision detection algorithm.
   @PARAMS: myUfo is a ufo object
   @Return: A boolean true if equal, false if not.  
   */
  boolean equalsUfo(Ufo myUfo)
  {
    // First check shot locations
    for (int i = 0; i <  shipShots.size(); i++)
    {
      if ((abs(myUfo.ufoLocation.x - shipShots.get(i).shotLocation.x) < 30
        && (abs(myUfo.ufoLocation.y - shipShots.get(i).shotLocation.y)) < 30))
      {
        shipStatus = true;
        // remove shot from array once used
        shipShots.remove(i);
        // score increases 100 points for hitting the ufo
        score += 100;
      } else
      {
        shipStatus = false;
      }
    }
    return shipStatus;
  }
}
