/**************************************************************
* File: A3_GROUP14.pde
* Group: 14; {Tegan Lee Barnes, Alison Bryce, Josh Le Gresley}.
* Date: 29/04/2019
* Course: COSC101 - Software Development Studio 1
***************************************************************/

/*
The Ship class is creates the ship object for the AsteroidsGame class.
*/

class Ship
{
  Shot oneShot;                // declares a Shot object
  
  PVector shipCoord,           // declare PVector object for ship's location
          shipDirection;       // declare PVector object for ship's direction
          
  ArrayList<Shot> shipShots = 
          new ArrayList<Shot>(); // declare Shots object ArrayList
          
  PShape drawShip;       // declare PShape object
  
  float speed,           // the speed to increase by when ship moves
        maxSpeed,        // maximum speed for the ship
        angle,           // angle to rotate the image by
        direction;       // direction that ship is heading
        
  int sWidth = 14,       // ship width
      sLength = 18;      // ship length
        
  boolean shotFired,     // boolean flag to state if a shot has been fired on not
          shipHit,       // boolean flag to state if the ship has been hit
          shipStatus;    // boolean flag used to state if locations are equal to ufo
          
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
    
  }
  
  /*
  Method to update the movement of the ship relative to the players ship current location
  @PARAMS: ship is a PVector with the ships location
  */
  void moveShip()
  {

  //this function should update if keys are pressed down 
     // - this creates smooth movement
  //update rotation,speed and update current location

    if(sUP){
      shipDirection.add(new PVector(0, -speed));
    }
    if(sDOWN){
      shipDirection.add(new PVector(0, speed)); 
    }
    if(sRIGHT){
      shipDirection.add(new PVector(speed, 0));
    }
    if(sLEFT){
      shipDirection.add(new PVector(-speed, 0));
    }
  
    shipDirection.limit(maxSpeed);
    shipCoord.add(shipDirection);
    
}
  
  /*
  Method to wrap the ufo around the edges of the screen
  */
  void shipEdgeDetect()
  {
  // Make sure the ship is not outside of the window; Check edges
  if (shipCoord.x > width) {
    shipCoord.x = 0;
  } else if (shipCoord.x < 0) {
    shipCoord.x = width;
  }
  
  if (shipCoord.y > height) {
    shipCoord.y = 0;
  } else if (shipCoord.y < 0) {
    shipCoord.y = height;
  }
}
  
  /*
  Method called from the constructor to generate the drawUfo PShape object group
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
  Method to rotate the drawUfo PShape object and display it to screen
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
  Method to fire shots at random intervals
  @PARAMS: PVector containing players ship location
  */
  void addShot()
  {
    if (key == ' ' && shotReady) 
    {
      shipShots.add(oneShot = new Shot(shipCoord, shipDirection, shipDirection.heading()));
      shotFired = true;
      shotReady = false;
    }
  } 
  
  /*
  Method to update the shot trajectory once fired
  */
  void updateShot()
  {
    if(shotFired)
    {
      for(int i = 0; i < shipShots.size(); i++)
      {
        shipShots.get(i).moveShot();
        shipShots.get(i).displayShot();
      }
    }
  }
  
  /*
  Method to check if ufoShot locations or the ufo location itself are equal to ship location. 
  It does this by using a circular collision detection algorithm.
  @PARAMS: x and y are locations
  @Return: A boolean true if equal false if not.  
  */
  boolean equals(float x, float y)
  {
    // First check shot locations
    for (int i = 0; i <  shipShots.size(); i++)
    {
      if ((abs(x - shipShots.get(i).shotLocation.x) < 10) 
          && (abs(y - shipShots.get(i).shotLocation.y)) < 10)
      {
        shipStatus = true;
        // remove shot from array once used
        shipShots.remove(i);
      }   
      else
      {
        shipStatus = false;
      }
    }
    // then check ufo location
    if((abs(x - shipCoord.x)) < 10 && (abs(y - shipCoord.y)) < 10)
    {
      shipStatus = true;
    }
    return shipStatus;
    
  }
}
