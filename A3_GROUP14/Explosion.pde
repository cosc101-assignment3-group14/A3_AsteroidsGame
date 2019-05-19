class Explosion
{
  float distance = random(20, 50);
  float angle = random(TWO_PI);
  int trails =7;

  PVector[] pointsVelocity = new PVector[7];
  PVector[] pointsLocation = new PVector[7];

  PVector line;
  float stroke = 3;
  
  boolean explosionExists;

  Explosion(PVector location)
  {
    for (int i = 0; i < trails; i ++)
    {
      // uses map function to generate the anle between vertices
      float angle = map(i, 0, trails, 0, TWO_PI);
      pointsVelocity[i] = PVector.fromAngle(angle);
      pointsLocation[i] = new PVector(location.x, location.y);
    }
    
    explosionExists = true;
  }
  
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
    }
    else
    {
      explosionExists = false;
    }
  }
    
    void drawexplosion(float x, float y)
    {
      // uses map function to generate the anle between vertices
      stroke(#24DE14);
      strokeWeight(stroke);
      point(x, y);
    }
}
