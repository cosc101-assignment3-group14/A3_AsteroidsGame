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
  Minim minim; // Minim object to load sound file

  AudioPlayer shipHit, //Audioplayer object for ship destoyed
    astHit, //Audioplayer object for asteroid destroyed
    shot, //Audioplayer object for shot 
    ufoHit, //Audioplayer object for ufo hit
    ufo, //Audioplayer object for ufo
    levelUp; //Audioplayer object for next level




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
    ufo = minim.loadFile("ufo.mp3");
    astHit = minim.loadFile("asteroidexplode.wav");
    ufoHit = minim.loadFile("ufohit.wav");
    levelUp = minim.loadFile("levelup.wav");
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
  Method to play level up sound
   */
  void playLevelUp()
  {
    levelUp.rewind();
    levelUp.play();
  }

  /*
  Method to playufo hit sound
   */
  void playUfoHit()
  {
    ufoHit.rewind();
    ufoHit.play();
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
