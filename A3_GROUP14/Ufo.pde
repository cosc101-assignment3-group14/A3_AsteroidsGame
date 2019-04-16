/**************************************************************
* File: A3_GROUP14.pde
* Group: 14; {Tegan Lee Barnes, Alison Bryce, Josh Le Gresley}.
* Date: 12/04/2018
* Course: COSC101 - Software Development Studio 1
***************************************************************/

class Ufo
{
  Shot oneShot;                  // declares a Shot object
  PVector ufoLocation,           // declare PVector object for ship's location
          ufoVelocity;           // declare PVector object for ship's velocity
  ArrayList<Shot> ufoShots = 
          new ArrayList<Shot>(); // declare Shots object ArrayList
          
  PShape drawUfo,                // declare PShape object
         base,
         detail1,
         detail2,
         top;
  
  float topspeed,                // the speed to increase by when ship moves
        resistance,              // the resistance to 
        direction,               // 
        torque,
        rotation,
        attackZone,
        retreatZone,
        mode;
        
  int startTime =0,              // stores the millisecond starting point of timer
      totalTime= 0,              // time accumulator
      delay = 100;               // sets a delay of the ship exiting and reentering the screen 
  
  boolean shotFired,             // boolean flag to state if a shot has been fired on not
          ufoHit;
          
   /*
  UFO constructor 
  */
  Ufo()
  {
     // create PVectors for ship movement
    ufoLocation = new PVector(width/2, height/2);
    ufoVelocity = new PVector();
    
    // create PShape object
    generateUfoShape();
    
    // set motion control variables 
    topspeed = 5;
    resistance = 0.99;
    direction = PI;
    mode = -1;
    
    //set status flags
    shotFired = false;
    ufoHit = true;
    
    // set variables
    attackZone = 300;
    retreatZone = 200;
  }
  
    /*
  Method to update the movement of the ship
  */
  void moveUfo(PVector ship)
  {
    // if the distance between ship location and ufo is greater then the attack zone 
    // the ufo moves towards the ship to attack
    if((abs(ship.x - ufoLocation.x) > attackZone) || (abs(ship.y - ufoLocation.y) > attackZone))
    {
       PVector acceleration = PVector.sub(ship, ufoLocation);
       acceleration.setMag(0.8);
       // Velocity changes according to acceleration
       ufoVelocity.add(acceleration);
       // Limit the velocity by topspeed
       ufoVelocity.limit(topspeed);
       // Location changes by velocity
       ufoLocation.add(ufoVelocity);
    }
    // if the distance between ship location and ufo is less then attack zone 
    // then the ufo moves away from ship
    else if((abs(ship.x - ufoLocation.x) < retreatZone) || (abs(ship.y - ufoLocation.y) < retreatZone))
    {
       PVector acceleration = PVector.sub(ship, ufoLocation);
      // Set magnitude of acceleration
      acceleration.setMag(-0.8);
      // Velocity changes according to acceleration
      ufoVelocity.add(acceleration);
      // Limit the velocity by topspeed
      ufoVelocity.limit(topspeed);
      // Location changes by velocity
      ufoLocation.add(ufoVelocity);
    }
  }
  
  /*
  
  */
  void ufoEdgeDetect()
  {
    if(ufoLocation.x < - delay )
    {
      ufoLocation.x = width + delay;
    }
    else if (ufoLocation.x > width + delay)
    {
      ufoLocation.x = 0 - delay;
    }
    if(ufoLocation.y < - delay)
    {
      ufoLocation.y = height + delay;
    }
    else if (ufoLocation.y > height + delay)
    {
      ufoLocation.y = 0 - delay;
    }
  }
  
  /*
  
  */
  void generateUfoShape()
  {
    //noFill();
    drawUfo = createShape(GROUP);
    
    ellipseMode(CORNER);
    top = createShape(ELLIPSE, -15, -15, 30, 30);
    top.setFill(#24DE14);
    
    noFill();
    base = createShape(ELLIPSE, -25, -25, 50, 50);
    base.setStroke(#24DE14);
    
    
    drawUfo.addChild(top);
    drawUfo.addChild(base);
    
    detail1 = createShape(LINE, -25, 0, 25, 0); 
    detail1.setStroke(#24DE14);
    detail2 = createShape(LINE, 0, -25, 0, 25); 
    detail2.setStroke(#24DE14);
  }
  
  /*
  
  */
  void displayUfo()
  {
    //drawUfo.resetMatrix(); // resets the current matrix of a shape with the identity matrix (0, 0)
    detail1.rotate(radians(direction)); // rotates the PShape to the current direction
    shape(detail1, ufoLocation.x, ufoLocation.y); // draws the shape object to the current location
    detail2.rotate(radians(direction)); // rotates the PShape to the current direction
    shape(detail2, ufoLocation.x, ufoLocation.y); // draws the shape object to the current location
    shape(drawUfo, ufoLocation.x, ufoLocation.y); // draws the shape object to the current location
    //shape(top, ufoLocation.x, ufoLocation.y); // draws the shape object to the current location
  } 
}
