/**************************************************************
 * File: a3.pde
 * Group: Tegan Lee Barnes, Alison Bryce, Josh Le Gresley; 14.
 * Date: 4/04/2018
 * Course: COSC101 - Software Development Studio 1
 **************************************************************/

/*
Audio class handles loading sound files and gives access to play
and/or loop sounds dependent on requirements.
*/
class Audio
{
  Minim minim;                // Minim object to load sound file
  
  AudioPlayer shipHit,            //Audioplayer object for hit 
              astHit,
              shot,
              ufo,
              asteroids;
  
  
  /*
  Constructor takes in PApplet argument to get minim class to load 
  files within this class. Code sourced from https://forum.processing.org
  */            
  Audio(PApplet p)
  {
    //SOUND:
    // new minim class instance
    minim = new Minim(p);
    
    //load sound
    shipHit = minim.loadFile("shiphit1.wav");
    shot = minim.loadFile("shot.wav");
    ufo = minim.loadFile("ufo.wav");
    //asteroids = minim.loadFile("asteroidscollide.wav");
    astHit = minim.loadFile("asteroidexplode.wav");
  }
  
  /*
  Method to play shot sound 
  */
  void playShot() 
  {
    shot.rewind();
    shot.play();
  }
  
  /*
  Method to play ship hit sound
  */
  void playShipHit()
  {
    shipHit.rewind();
    shipHit.play();
  }
  
  /*
  Method to play asteroid hit sound
  */
  void playAstHit()
  {
    astHit.rewind();
    astHit.play();
  }
  
  /*
  Method to play sound
  */
  void playAsteroids()
  {
    asteroids.rewind();
    asteroids.play();
  }
  
  /*
  Method to loop ufo sound
  */
  void loopUfoSound()
  {
    ufo.loop();
  }
  
  /*
  Method to pause looping sound
  */
  void pauseLoopUfoSound()
  {
    ufo.pause();
  }
}
