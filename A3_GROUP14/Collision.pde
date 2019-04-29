/**************************************************************
 * File: a3.pde
 * Group: Tegan Lee Barnes, Alison Bryce, Josh Le Gresley; 14.
 * Date: 4/04/2018
 * Course: COSC101 - Software Development Studio 1
 **************************************************************/

/*
The collision class handles all collision checks in the game
*/
class Collision
{
  /*
  Method to collision detect between Asteriods 
  */
  void collisionAsteroids(ArrayList<Asteroid> myAst)
  {
    // outer loop iterates over all Asteroid objects except last one
    for (int i = 0; i < myAst.size() - 1; i++)
    {
      // inner loop iterates over all Asteroid objects except first one (prevents checking against self)
      for (int j = i + 1; j < myAst.size(); j++)
      {
        // equals method in Asteroid object called to see if locations are in a certain radius
        if (myAst.get(i).equals(myAst.get(j)))
        {
          // if equal collisionAsteroid() method called to change both asteroids motion
          myAst.get(i).collisionAsteroid(myAst.get(j));
        }
      }
    }
  }
  
  /*
  Method to collision detect between ufo shots and space ship
  */
  void collisionUfoShot_Ship(Ufo myUfo, Ship myShip)
  {
    // Iterate over ufoShots Array list
    for (int i = 0; i <  myUfo.ufoShots.size(); i++)
    {
      if (myUfo.equals(myShip))
      {
        // TODO PLAYER SHOULD LOSE A LIFE AT THIS POINT AND RESTART IN THE CENTRE
        print("You are hit");
      }
    }
  }

  /*
  Method to collision detect between player shots and the asteroids
  */
  void collisionShipShot_Asteroid(ArrayList<Asteroid> myAst, Ship myShip)
  {
    // Iterate over asteroid list in reverse. This way if new asteroids are added to the 
    // list mid iterate they are not included in the current collision detect
    for (int i = myAst.size()-1; i >= 0; i--)
    {
      if(myShip.equals(myAst.get(i)))
      {
        // if a hit is detected the resulting action depends on the number of hits already sustained
        if (myAst.get(i).hits < 2)
        {
          myAst.addAll(myAst.get(i).splitAsteroid());
          myAst.remove(myAst.get(i));
        } else
        {
          myAst.remove(myAst.get(i));
        }
      }
    }
  }
  
  /*
   Method to collision detect between player shots and ufo
   */
  void collisionShipShot_Ufo(Ship myShip, Ufo myUfo)
  {
    if (myShip.equals(myUfo))
    {
      // TODO PLAYER SHOULD LOSE A LIFE AT THIS POINT
      print("HIT UFO");
    }
  }
  
  
  /*
  Method to collision detect ship location and the asteroids
  */
  void collisionShip_Asteroid(ArrayList<Asteroid> myAst, Ship myShip)
  {
    for(int i = 0; i < myAst.size(); i ++)
    {
      if(myAst.equals(myShip))
      {
        // TODO here the ship can lose a life and restart in the centre
        print("Ship destroyed");
      }
    }
  }
}
