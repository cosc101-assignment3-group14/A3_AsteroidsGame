/**************************************************************
 * File: a3.pde
 * Group: Tegan Lee Barnes, Alison Bryce, Josh Le Gresley; 14.
 * Date: 4/04/2018
 * Course: COSC101 - Software Development Studio 1
 **************************************************************/

/*
The Astoids class creates the asteroids in the Asteroids game. 
*/
class Asteroid
{
  PShape drawAsteroid;       // declare PShape object for asteroid image

  float radius,              // radius of asteroid shape
        speed,               // speed of the asteroid
        angle,               // angle for the direction of the PVector velocity
        scale,               // scale of the asteroid PShape
        asteroidCreation;    // time stamp at the point of asteroid creation
       


  int delay,                 // sets a delay of asteroids exiting and reentering the screen
      hits;                  // int to track number of hits sustained by iterations of Asteroid

  PVector asteroidLocation,  // declare PVector object to track current location
          asteroidVelocity;  // declare PVector object to track velocity
    
  boolean collisionActive; // switches on collision status after creation

  /*
  Constructor sets the Asteroid objects initial values and generates a random PShape
  @PARAMS: location is a PVector for the starting point of the object
  @PARAMS: scal is a random float to define the size of the image drawn to screen
  @PARAMS: hit is an int to track number of hits each Asteroid object has sustained
  */
  Asteroid(PVector location, float scal, int hit)
  {
    //assign parameters to instance variables

    asteroidLocation = location; // Set the starting location
    scale = scal; // sets the scale of the PShape
    hits = hit; // Sets the initial hit status

    // Sets a random starting velocity

    speed = random(1, 2);
    angle = random(TWO_PI);
    asteroidVelocity = new PVector(cos(angle), sin(angle));
    asteroidVelocity.mult(speed);

    // spatial variables
    delay = 100;
    radius = 35;

    // time stamp for object creation
    asteroidCreation = millis();
    collisionActive = false;
    
    //creates PShape
    generateAsteroidShape();
  }


  /*
  This method controls the Asteroids motion. Firstly it monitors the 
  asteroids location and wraps the objects to re enter the opposite side
  of screen of the screen. Then adds the velocity PVector to the location.
  Finally the asteroids collision status is switched on after a short
  time period after the object creation.
  */
  void updateAsteroid()
  {
    if (asteroidLocation.x < - delay )
    {
      asteroidLocation.x = width + delay;
      asteroidVelocity.mult(0.95);
    } 
    else if (asteroidLocation.x > width + delay)
    {
      asteroidLocation.x = 0 - delay;
      asteroidVelocity.mult(0.95);
    }
    
    if (asteroidLocation.y < - delay)
    {
      asteroidLocation.y = height + delay;
      asteroidVelocity.mult(0.95);
    } 
    else if (asteroidLocation.y > height + delay)
    {
      asteroidLocation.y = 0 - delay;
      asteroidVelocity.mult(0.95);
    }

    asteroidLocation.add(asteroidVelocity);
    
    // switches asteroidCollision status to true after a short
    // time period after object creation this prevents asteroids 
    // all colliding upon creation at the same location
    if(millis() - asteroidCreation > 2500)
    {
      collisionActive = true;
    }
  }

  /*
  Method that is called from the constructor and generates a random
  PShape for each Asteroid object. Strategy to generate the random shape
  has been developed using the example: 
  https://processing.org/examples/polartocartesian.html 
  and from -The Coding Train: code challenge #46.1.
  */
  void generateAsteroidShape()
  {
    noFill(); 
    drawAsteroid = createShape();
    drawAsteroid.setStrokeWeight(1);
    drawAsteroid.setStroke(#24DE14);
    drawAsteroid.beginShape();

    float rand = random(5, 12); // random number used to determine number of vertices

    // for loop iterrates over a random number which corresponds to number of vertices
    for (int i = 0; i < rand; i++)
    {
      // random number used to determine a random offset to each vertices
      float offset = random(-12, 12); 
      // uses map function to generate the anle between vertices
      float angle = map(i, 0, rand, 0, TWO_PI);
      // use trigonometry to generate polar to catesian coordinates (x,y) 
      // and set to a vertex point of the PShape
      drawAsteroid.vertex((radius + offset) * cos(angle), (radius + offset) * sin(angle));
    }
    drawAsteroid.endShape(CLOSE);

    drawAsteroid.resetMatrix(); 
    drawAsteroid.scale(scale);
  }

  /*
  Method to dislay the asteroid image to screen
  */
  void displayAsteroid()
  {
    drawAsteroid.rotate(0.01);
    shape(drawAsteroid, asteroidLocation.x, asteroidLocation.y);
  }

  /*
  Method to update the velocity and change direction of two
  Asteroid objects on collision. The code has been sourced from
  https://forum.processing.org and updated to use PVectors.
  @PARAMS: An Asteroid object to compare the calling object to.
  */
  void collisionAsteroid(Asteroid ast)
  {
    if (collisionActive && ast.collisionActive)
    {
      float dx = ast.asteroidLocation.x - asteroidLocation.x;
      float dy = ast.asteroidLocation.y - asteroidLocation.y;
      float minDist = (radius * scale) + (ast.radius * ast.scale) ;
      float angle = atan2(dy, dx);
      float targetX = asteroidLocation.x + cos(angle) * minDist;
      float targetY = asteroidLocation.y + sin(angle) * minDist;
      float ax = (targetX - ast.asteroidLocation.x) * 0.05;
      float ay = (targetY - ast.asteroidLocation.y) * 0.05;
      asteroidVelocity.sub(new PVector(ax, ay));
      ast.asteroidVelocity.add(new PVector(ax, ay)); 
    }
  }

  /*
  Method to check if asteroid locations are equal. It does this by using
  a circular collision detection algorithm.
  @PARAMS: ast is an Asteroid object to compare against the object calling.
  @Return: A boolean true if equal false if not.  
  */
  boolean equals(Asteroid ast)
  {
    boolean status = false;
    if(collisionActive)
    {
      if (abs(asteroidLocation.x - ast.asteroidLocation.x) < (radius * scale + (ast.radius * ast.scale))
        && abs(asteroidLocation.y - ast.asteroidLocation.y) < (radius * scale + (ast.radius * ast.scale)))
      {
        status = true;
      } else
      {
        status = false;
      }
      return status;
    }
    return status;
  }
  
  /*
  Overloaded method to check if asteroid locations is equal to ship location. It does this by using
  a circular collision detection algorithm.
  @PARAMS: is the ship object to compare against the object calling.
  @Return: A boolean true if equal false if not.  
  */
  boolean equals(Ship myShip)
  {
    boolean status = false;
    if(collisionActive)
    {
      if (abs(asteroidLocation.x - myShip.shipCoord.x) < (radius * scale)
        && abs(asteroidLocation.y - myShip.shipCoord.y) < (radius * scale ))
      {
        status = true;
      } else
      {
        status = false;
      }
      return status;
    }
    return status;
  }

  /*
  Method to create a random number of smaller Asteroids upon each impact
  @Return: An Asteroid ArrayList containing the new Asteroid objects to replace
           the exising larger one.
  */
  ArrayList<Asteroid> splitAsteroid()
  {
    ArrayList<Asteroid> splitAsteroids = new ArrayList<Asteroid>();
    for (int i = 0; i < random(3, 5); i ++)
    {
      if (hits == 0)
      {
        Asteroid newAsteroid = new Asteroid(new PVector(asteroidLocation.x, asteroidLocation.y), 
          random(0.7, 1), 1);
        splitAsteroids.add(newAsteroid);
      } else if (hits == 1)
      {
        Asteroid newAsteroid = new Asteroid(new PVector(asteroidLocation.x, asteroidLocation.y), 
          random(0.2, 0.6), 2);
        splitAsteroids.add(newAsteroid);
      }
    }
    return splitAsteroids;
  }
}
