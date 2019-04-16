/**************************************************************
* File: a3.pde
* Group: Tegan Lee Barnes, Alison Bryce, Josh Le Gresley; 14.
* Date: 4/04/2018
* Course: COSC101 - Software Development Studio 1
**************************************************************/
/*
This shot class creates a shot object.
*/
class Shot
{
  
  PVector shotLocation, // declare PVector object for shot's location
          shotVelocity; // declare PVector object for shot's velocity
          
  PShape drawShot;      // PShape object
  
  float shotSpeed;      // speed of the shot
  
  /*
  The Shot constructor takes in three parameters. Two PVector objects and a float. The initial shot location is set to be
  the current ship location. The shot velocity is set to be shot speed * cos/sin (x/y) of the direction + the velocity of the ship
  It also intitilises variables and creates the PShape object.
  @PARAMS pos: A PVector object containing ship's location
  @PARAMS vel:  A PVector object containing ship's velocity
  @PARAMS direction: The direction of the ship
  */
  Shot(PVector pos, PVector vel, float direction)
  {
    //set speed
    shotSpeed = 3;
    
    // create PVectors for shot movement
    shotLocation = new PVector(pos.x, pos.y);
    shotVelocity = new PVector(shotSpeed * cos(radians(direction)) + vel.x, shotSpeed * sin(radians(direction)) + vel.y);
    
    // create PShape object
    drawShot = createShape(POINT, 0, 0);
    drawShot.setStroke(#CB0E0E);
    drawShot.setStrokeWeight(4);
  }
  
  /*
  Method to update shot motion
  */
  void moveShot()
  { 
    // Location changes by velocity
    shotLocation.add(shotVelocity);
  }

  /*
  Method to draw shot to screen
  */
  void displayShot() 
  {
    shape(drawShot, shotLocation.x, shotLocation.y);
  }
}
