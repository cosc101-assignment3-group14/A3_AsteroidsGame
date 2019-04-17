/**************************************************************
* File: A3_GROUP14.pde
* Group: 14; {Tegan Lee Barnes, Alison Bryce, Josh Le Gresley}.
* Date: 12/04/2018
* Course: COSC101 - Software Development Studio 1
***************************************************************/

/*
The Ufo class is used to add a ufo object that attacks the space ship in the 
AsteroidsGame class
*/
class Ufo
{
  Shot oneShot;                  // declares a Shot object
  
  PVector ufoLocation,           // declare PVector object for ship's location
          ufoVelocity;           // declare PVector object for ship's velocity
          
  ArrayList<Shot> ufoShots = 
          new ArrayList<Shot>(); // declare Shots object ArrayList
          
  PShape drawUfo,                // declare PShape object (for group)
         base,                   // declare PShape object to hold detail in group
         detail1,                // declare PShape object to hold detail in group
         detail2,                // declare PShape object to hold detail in group
         detail3,                // declare PShape object to hold detail in group
         detail4,                // declare PShape object to hold detail in group
         top;                    // declare PShape object to hold detail in group
  
  float topspeed,                // the speed to increase by when ship moves
        resistance,              // the resistance to 
        direction,               // 
        torque,                  //
        rotation,                //
        attackZone,              //
        retreatZone,             //
        shotInterval;            //
        
        
  int startTime,                 // stores the millisecond starting point of timer
      totalTime,                 // time accumulator
      delay;                     // sets a delay of the ship exiting and reentering the screen 
       
  
  boolean ufoDeployed,           // boolean flag to state if the ufo has been deployed to attack 
          shotFired,             // boolean flag to state if a shot has been fired on not
          ufoHit,                // boolean flag to state if the ufo has been hit
          timing;                // boolean flag to state if the shot timer has started
          
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
    topspeed = 2;
    resistance = 0.99;
    direction = PI;
    
    //set status flags
    shotFired = false;
    ufoHit = true;
    ufoDeployed = true;
    timing = false;
    
    // set spacial variables
    attackZone = 500;
    retreatZone = 100;
    delay = 100;
    
    // time control
    startTime = 0;
    totalTime = 0;
    
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
       acceleration.setMag(-0.4);
       // Velocity changes according to acceleration
       ufoVelocity.add(acceleration);
       // Limit the velocity by topspeed
       ufoVelocity.limit(topspeed);
       // Location changes by velocity
       ufoLocation.add(ufoVelocity);
    }
    // if the distance between ship location and ufo is less then attack zone 
    // then the ufo moves away from ship
    else
    {
      PVector acceleration = PVector.sub(ship, ufoLocation);
      // Set magnitude of acceleration
      acceleration.setMag(0.4);
      // Velocity changes according to acceleration
      ufoVelocity.add(acceleration);
      // Limit the velocity by topspeed
      ufoVelocity.limit(topspeed);
      // Location changes by velocity
      ufoLocation.add(ufoVelocity);
      if((abs(ship.x - ufoLocation.x) < retreatZone) || (abs(ship.y - ufoLocation.y) < retreatZone))
      {
        acceleration.setMag(-0.4);
        // Velocity changes according to acceleration
        ufoVelocity.add(acceleration);
        // Limit the velocity by topspeed
        ufoVelocity.limit(topspeed);
        // Location changes by velocity
        ufoLocation.add(ufoVelocity);
    }
    }
  }
  
  /*
  Method to wrap the ufo around the edges of the screen
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
  Method called from the constructor to generate the drawUfo PShape object group
  */
  void generateUfoShape()
  {
    drawUfo = createShape(GROUP);
    ellipseMode(CORNER);
    top = createShape(ELLIPSE, -15, -15, 30, 30);
    top.setFill(#24DE14);
    noFill();
    base = createShape(ELLIPSE, -25, -25, 50, 50);
    base.setStroke(#24DE14);
    detail1 = createShape(LINE, -25, 0, 25, 0); 
    detail1.setStroke(#24DE14);
    detail2 = createShape(LINE, 0, -25, 0, 25); 
    detail2.setStroke(#24DE14);
    detail3 = createShape(LINE, 0, -25, 0, 25); 
    detail3.setStroke(#24DE14);
    detail4 = createShape(LINE, 0, -25, 0, 25); 
    detail4.setStroke(#24DE14);
    
    drawUfo.addChild(top);
    drawUfo.addChild(base);
    drawUfo.addChild(detail1);
    drawUfo.addChild(detail2);
    drawUfo.addChild(detail3);
    drawUfo.addChild(detail4);
  }
  
  /*
  Method to rotate the drawUfo PShape object and display it to screen
  */
  void displayUfo()
  {
    //pushMatrix();
    drawUfo.rotate(radians(direction)); // rotates the PShape detail
    shape(drawUfo, ufoLocation.x, ufoLocation.y); // draws the shape object to the current location
    //popMatrix();
  }
  
  /*
  Method to fire shots at random intervals
  */
  void addShot(PVector ship)
  {
    if(ufoDeployed && !timing)
    {
      shotInterval = random(100, 500);
      startTime = millis();
      timing = true;
    }
    else
    {
      int split = (millis() - startTime)/1000;
      totalTime += split;
      if(totalTime > shotInterval)
      {
        ufoShots.add(oneShot = new Shot(ufoLocation, ufoVelocity, ship));
        shotFired = true; 
        shotInterval = random(1, 100);
        startTime = millis();
        totalTime = 0;
      }
    }
  
  }
  
  /*
  Method to update the shot trajectory once fired
  */
  void updateShot()
  {
    if(shotFired)
    {
      for(int i = 0; i < ufoShots.size(); i++)
      {
        ufoShots.get(i).moveShot();
        ufoShots.get(i).displayShot();
      }
    }
  }
}
