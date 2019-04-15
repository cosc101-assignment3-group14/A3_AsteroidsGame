/**************************************************************
* File: a3.pde
* Group: Tegan Lee Barnes, Alison Bryce, Josh Le Gresley; 14.
* Date: 4/04/2018
* Course: COSC101 - Software Development Studio 1
**************************************************************/

/*
TODO: IMPLEMENT
          - improve PShape design
                       - maybe use vertexs method
                       - random sizes
                       
          - implement on first hit shape divides into two
         

The Astoids class creates the astoids in the Asteroids game. 
*/
class Asteroid
{
  PShape drawAsteroid;                   // declare PShape object for asteroid image
  
  boolean hit;                           // boolean to track if asteroid has been hit
  
  float topspeed;                        // set maximum speed 
        
  int delay = 100;                       // sets a delay of asteroids exiting and reentering the screen
        
       
  PVector asteroidLocation,              // declare PVector object to track current location
          asteroidVelocity,              // declare PVector object to track velocity
          asteroidAcceleration;          // declare PVector object to track acceleration
  /*
  Constructor sets the asteroids starting location and topspeed
  */     
  Asteroid()
  {
    // Set to start in random location
    asteroidLocation = new PVector(random(width), - delay);
    
    // Sets a static starting velocity
    asteroidVelocity = new PVector(0, 0);
    
    // Sets a random acceleration in the y and x directions 
    asteroidAcceleration = new PVector(random(-0.1, 0.1),random(-0.1, 0.1));
    
    // sets random top speed
    topspeed = random(2, 4); 
    
    // Sets the initial squashed status to false
    hit = false;
    
    //create PShape
    generateAsteroidShape();
  }
  
  /*
  This method controls the Asteroids motion. Firstly it monitors the 
  asteroids location and wraps the objects to re enter the opposite side
  of screen of the screen. Then adds the acceleration and velocity PVectors
  to the location.
  */
  void updateAsteroid()
  {
    if(asteroidLocation.x < - delay )
    {
      asteroidLocation.x = width + delay;
    }
    else if (asteroidLocation.x > width + delay)
    {
      asteroidLocation.x = 0 - delay;
    }
    if(asteroidLocation.y < - delay)
    {
      asteroidLocation.y = height + delay;
    }
    else if (asteroidLocation.y > height + delay)
    {
      asteroidLocation.y = 0 - delay;
    }
    
    // Velocity changes according to acceleration
    asteroidVelocity.add(asteroidAcceleration);
    // Limit the velocity by topspeed
    asteroidVelocity.limit(topspeed);
    // Location changes by velocity
    asteroidLocation.add(asteroidVelocity);
  }
  
  void generateAsteroidShape()
  {
    noFill();
    drawAsteroid = createShape();
    drawAsteroid.setStrokeWeight(2);
    drawAsteroid.setStroke(#24DE14);
    drawAsteroid.beginShape();
    drawAsteroid.vertex(random(0, 30), random(0, 30));
    drawAsteroid.vertex(random(0, 30), random(0, -30));
    drawAsteroid.vertex(random(0, -30), random(0, -30));
    drawAsteroid.vertex(random(0, -30), random(0, 30));
    drawAsteroid.endShape(CLOSE);
  }
  
  /*
  Method to dislay the asteroid image to screen
  */
  void displayAsteroid()
  {
    drawAsteroid.rotate(0.01);
    
    shape(drawAsteroid, asteroidLocation.x, asteroidLocation.y);
  }
}
