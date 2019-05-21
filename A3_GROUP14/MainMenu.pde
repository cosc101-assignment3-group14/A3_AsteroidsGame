/**************************************************************
 * File: MainMenu.pde
 * Group: 14; {Tegan Lee Barnes, Alison Bryce, Josh Le Gresley}.
 * Date: 12/04/2018
 * Course: COSC101 - Software Development Studio 1
 ***************************************************************/

/*
The MainMenu class creates starting page interface for the Asteroids game. 
 */
class MainMenu
{
  
  PImage expl;
  
  String title,
    newLabel, //
    instructionsLabel, //
    exitLabel, //
    easyLabel, // 
    mediumLabel, //
    hardLabel, //
    chooseLabel, //
    returnLabel, //
    gameoverLabel, //
    playAgainLabel, //   
    instructionsTitle, // 
    instructionsMission, //
    instructionsLives, // 
    instructionsControls;

  Boolean gameOver, // boolean flag used to state if the game is over
    selected;  // boolean flag used to state the mouse was pressed

  int score,
    bright,   // text opacity at its highest
    dim,      // text opacity at half way
    aPA,      // the following are variables for alpha (text opacity)
    aExit1,
    aExit2,
    aRet1,
    aRet2,
    aNG,
    aInst,
    aEasy,
    aMed,
    aHard;

  /*
  MainMenu constructor initialises varibles
   */
  MainMenu()
  {
    //initialise string variables
    title = "asteroids";
    newLabel = "NEW GAME";
    instructionsLabel = "HOW TO PLAY";
    exitLabel = "EXIT";
    easyLabel = "EASY";
    mediumLabel = "MEDIUM";
    hardLabel = "HARD";
    gameoverLabel = "GAME OVER";
    playAgainLabel ="PLAY AGAIN?";
    chooseLabel = "CHOOSE YOUR DIFFICULTY";
    returnLabel = "MAIN MENU";
    instructionsMission = "Mission:  Destory all asteroids and alien spaceships.";
    instructionsLives = " Lives:  Each player has 3 lives. Collision with an" +
    "asteriod looses a life. But be careful!  Collision with an alien" +
    "spaceship means game over!";
    instructionsControls = "Controls:  Right Turn: Right arrow. " +
    "Left Turn: Left arrow.  Move Upwards: Up arrow.  Move Downwards: Down arrow.";
    instructionsTitle = "YOUR MISSION";
    
    bright = 255;
    dim = 120;
    
    expl = loadImage("pngkey.com-pixel-explosion-png-3017570.png");

    //initialise boolean variables
    gameOver = false;  // boolean flag used to state if the game is over
  }

  /*
  Method
   */
  void displayMenu()
  {    
    // title with zooming out effect
    textAlign(CENTER);
    for (int x = 1; x < 111; x += 5)
    {
      fill(x);
      textSize(x);
      text(title, 0, height/7, width, height);
    }
    textSize(110);
    fill(255);
    text(title, 0, height/7, width, height);
    
    textSize(35);
    fill(255, aNG);
    text(newLabel, 400, 400); 
    fill(255, aInst);
    text(instructionsLabel, 400, 500);
    fill(255, aExit1);
    text(exitLabel, 400, 600);
  }

  /*
  Method to display the difficulty menu
   */
  void displayDifficultyMenu()
  {
    background(0);
    textAlign(CENTER);
    textSize(40);
    fill(0, 150, 0);
    text(chooseLabel, 400, 150);
    textSize(35);
    fill(255, aEasy);
    text(easyLabel, 400, 300);
    fill(255, aMed);
    text(mediumLabel, 400, 400);
    fill(255, aHard);
    text(hardLabel, 400, 500);
    fill(255, aRet1);
    text(returnLabel, 400, 700);
  }
  
  /*
  Method
   */
  void displayInstructions()
  {
    fill(0, 150, 0);
    textAlign(CENTER);    textSize(55);
    text(instructionsTitle, 400, 100);
    fill(255);
    textSize(25);
    text(instructionsMission, 50, 200,650, 600);
    text(instructionsLives, 50, 300, 650, 600);
    text(instructionsControls,50, 450, 650, 600);
    fill(255, aRet1);
    text(returnLabel, 400, 700);
  }
  
  /*
  Method to display the game over screen with options to play again or return to menu
   */
  void displayEndGame()
  { 
    // explosion image
    image(expl, 0, 0, width, height/2.5);  
    
    // game over text
    textAlign(CENTER, TOP);
    fill(130, 0, 0);
    textSize(115);
    text(gameoverLabel, 0, 50, width, height);

    // displays score
    fill(200);
    textSize(40);
    text("Your score:   " + myAsteroidGame.myShip.score, 0, height/2.1, width, height);

    // play again button
    fill(0, 255, 0, aPA);
    textSize(35);
    textAlign(CENTER, CENTER);
    text(playAgainLabel, 400, 500);
    
    // exit button
    fill(255, aExit2);
    textSize(40);
    text(exitLabel, 400, 600);
    
    // return to menu button
    fill(255, aRet2);
    textSize(40);
    text(returnLabel, 400, 700);
  }
  
  /*
  Method to set button detection retangular area for mouse click
  @PARAM: xmin is an int for the minimum x value
  @PARAM: xmax is an int for the maximum x value
  @PARAM: ymin is an int for the minimum y value
  @PARAM: ymax is an int for the maximum y value
  @RETURN: true if area is clicked false if not.
   */
  boolean buttonDetect(int xmin, int xmax, int ymin, int ymax)
  {
    if ((mouseX > xmin) && ( mouseY < ymax) && (mouseX < xmax) && ( mouseY > ymin)) 
    {
      return true;
    }
    return false;
  }

  /*
  Method to highlight text when mouse hovers over, using the buttonDetect method
  */
  void textHighlight()
  {
    // new game button
    if (buttonDetect(291, 505, 371, 403))
    {
      aNG = bright;
    } else
      {
        aNG = dim;
      }  
    // instructions button  
    if (buttonDetect(256, 536, 471, 501))
    {
      aInst = bright;
    } else
      {
        aInst = dim;
      }  
    // exit button from main menu
    if (buttonDetect(344, 447, 571, 602))
    {
      aExit1 = bright;
    } else
      {
        aExit1 = dim;
      }
    // easy option button
    if (buttonDetect(341, 457, 271, 303))
    { 
      aEasy = bright;
    } else
      {
        aEasy = dim;
      }
    // medium option button
    if (buttonDetect(314, 480, 372, 402))
    {
      aMed = bright;
    } else
      {
        aMed = dim;
      }
    // hard option button
    if (buttonDetect(341, 455, 472, 501))
    {
      aHard = bright;
    } else
      {
        aHard = dim;
      }
    // return button 
    if (buttonDetect(281, 450, 671, 700)) 
    { 
      aRet1 = bright;
    } else
      { 
        aRet1 = dim;
      }
    // play again button
    if (buttonDetect(275, 524, 491, 517))
    { 
      aPA = bright;
    } else
      {
        aPA = dim;
      }
    // exit button from game over screen
    if (buttonDetect(337, 456, 590, 639))
    {
      aExit2 = bright;
    } else
      {
        aExit2 = dim;
      }  
    // return to main menu button
    if (buttonDetect(264, 531, 680, 739)) 
    {
      aRet2 = bright;
    } else
      {
        aRet2 = dim;
      }
      
  }  
  
  /*
  Method
   */
  void gameExit()
  {
    exit();
  }

}
