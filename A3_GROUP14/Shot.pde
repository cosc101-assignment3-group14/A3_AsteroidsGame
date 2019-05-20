/************************************************************** //<>//
 * File: Shot.pde
 * Group: 14; {Tegan Lee Barnes, Alison Bryce, Josh Le Gresley}.
 * Date: 12/04/2018
 * Course: COSC101 - Software Development Studio 1
 ***************************************************************/
 
/*
This shot class creates a shot object. It is an overloaded class used by both the
 spaceShip class and the Ufo class.
 */
class Shot
{
  PVector shotLocation, // declare PVector object for shot's location
    shotVelocity; // declare PVector object for shot's velocity

  PShape drawShot; // PShape object

  float shotSpeed; // speed of the shot

  /*
  This Shot constructor can be used by the spaceShip. It takes in three parameters.
   Two PVector objects and a float. The initial shot location is set to be
   the current ship location. The shot velocity is set to be shot speed * cos/sin (x/y)
   of the direction + the velocity of the ship
   It also intitilises variables and creates the PShape object.
   @PARAM pos: A PVector object containing ship's location
   @PARAM vel:  A PVector object containing ship's velocity
   @PARAM direction: The direction of the ship
   @PARAM col: The colour of the shot.
   */
  Shot(PVector pos, PVector vel, float direction, String col)
  {
    //set speed
    shotSpeed = 5;

    // create PVectors for shot movement
    shotLocation = new PVector(pos.x, pos.y);
    shotVelocity = PVector.fromAngle(direction);
    shotVelocity.add(vel);
    shotVelocity.mult(shotSpeed);

    // create PShape object
    int colour = unhex(col);
    drawShot = createShape(POINT, 0, 0);
    drawShot.setStroke(colour);
    drawShot.setStrokeWeight(4);
  }

  /*
  This Shot constructor can be used by the Ufo class, it takes in three parameters. 
   Two PVector objects and a float. The initial shot location is set to be
   the current ship location. The shot velocity is set to be shot speed * cos/sin (x/y)
   of the direction + the velocity of the ship.
   It also intitilises variables and creates the PShape object.
   @PARAM pos: A PVector object containing ufo's location
   @PARAM vel:  A PVector object containing ufo's velocity
   @PARAM ship: A PVector object containing ship's location 
   @PARAM col: The colour of the shot.
   */
  Shot(PVector ufoPos, PVector vel, PVector ship, String col)
  {
    //set speed
    shotSpeed = 8;

    // create PVectors for shot movement
    shotLocation = new PVector(ufoPos.x, ufoPos.y);
    float angle = PVector.angleBetween(ship, ufoPos);
    shotVelocity = PVector.fromAngle(angle);
    shotVelocity.add(vel);
    shotVelocity.mult(shotSpeed);

    // create PShape object
    int colour = unhex(col);
    drawShot = createShape(POINT, 0, 0);
    drawShot.setStroke(colour);
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
