/**************************************************************
 * File: Explosion.pde
 * Group: 14; {Tegan Lee Barnes, Alison Bryce, Josh Le Gresley}.
 * Date: 12/04/2018
 * Course: COSC101 - Software Development Studio 1
 ***************************************************************/

/*
Explosion class creates an explosion object to be used when the asteroids and 
 ufo get destroyed.
 */
 
class Explosion
{
  float stroke, // variable to store the stroke value
        angle; // variable to store a random angle from 0 to 2PI radians
        
  int trails; // number of explosion trails from centre

  PVector[] pointsVelocity; // PVector array to store the points velocities
  PVector[] pointsLocation; // PVector array to store the points locations
 
  boolean explosionExists; // boolean flag to monitor state of Explosion object

  /*
  The Explosion constructor initialises variables and sets the angles for 
   the PVector motion.
   @PARAM: location is a PVector of the location of the object that has been destroyed
   */
  Explosion(PVector location)
  {
    // set variables
    angle = random(TWO_PI);
    trails = 7;
    stroke = 3;

    //initialise PVector arrays
    pointsVelocity = new PVector[trails];
    pointsLocation = new PVector[trails];

    // set the angles for PVector motion
    for (int i = 0; i < trails; i ++)
    {
      // uses map function to generate the angle between PVectors
      float angle = map(i, 0, trails, 0, TWO_PI);
      pointsVelocity[i] = PVector.fromAngle(angle);
      pointsLocation[i] = new PVector(location.x, location.y);
    }

    // The explosions existence is set in the constructor and monitored 
    //  till the shape disappears.
    explosionExists = true;
  }

  /*
  Method to move the points along each PVector in the array. The stroke slowly 
   disappears until the stroke is < 1. At this point the explosionExists boolean 
   is changed to false.
   */
  void moveTrails()
  {
    if (stroke > 1)
    {
      for (int i = 0; i < trails; i ++)
      {
        pointsVelocity[i].mult(0.98);
        pointsLocation[i].add(pointsVelocity[i]);
        drawexplosion(pointsLocation[i].x, pointsLocation[i].y);
        stroke -= 0.009;
      }
    } else
    {
      explosionExists = false;
    }
  }

  /*
  Method to display the explosion to the screen.
  @PARAM: x and y are floats for the corresponding x and y loactions to draw points
   */
  void drawexplosion(float x, float y)
  {
    stroke(#24DE14);
    strokeWeight(stroke);
    point(x, y);
  }
}
