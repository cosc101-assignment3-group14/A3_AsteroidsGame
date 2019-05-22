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
    instructionsBlurb; //

  Boolean gameOver, // boolean flag used to state if the game is over
    selected;  // boolean flag used to state the mouse was pressed

  // the following are variables for alpha text opacity
  int bright, // text opacity at its highest
    dim,      // text opacity at half way
    aPA,      // for play again button
    aExit1,    
    aExit2,
    aRet1,
    aRet2,
    aNG,
    aInst,
    aEasy,
    aMed,
    aHard,
    
    labelX,
    headerY,
    txtH,
    txtL;
    
  int[][] button = { {291, 505, 371, 403},  // "NEW GAME"
                     {256, 536, 471, 501},  // "HOW TO PLAY"
                     {344, 447, 571, 602},  // "EXIT"
                     {341, 457, 271, 303},  // "EASY"
                     {314, 480, 372, 402},  // "MEDIUM"
                     {341, 455, 472, 501},  // "HARD"
                     {281, 450, 671, 700},  // "MAIN MENU"
                     {275, 524, 491, 517},  // "PLAY AGAIN?"
                     {337, 456, 590, 639},  // "EXIT"
                     {264, 531, 680, 739}}; // "MAIN MENU"
  

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
    instructionsBlurb = "WE WILL MAKE THIS ALL UP LATER";
    instructionsTitle = "THIS IS HOW YOU PLAY";
    
    bright = 255;
    dim = 120;
    //labelX = ;
    headerY = 150;
    txtH = 100;
    txtL = 80;
    
    // game over image of an explosion
    expl = loadImage("pngkey.com-pixel-explosion-png-3017570.png");

    //initialise boolean variables
    gameOver = false;  // boolean flag used to state if the game is over
  }

  /*
  Method to display the starting menu
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
    text(newLabel, width/2, height/2); 
    fill(255, aInst);
    text(instructionsLabel, width/2, (height/2)+txtH);
    fill(255, aExit1);
    text(exitLabel, width/2, (height/2)+(2*txtH));
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
    text(chooseLabel, width/2, headerY);
    textSize(35);
    fill(255, aEasy);
    text(easyLabel, width/2, (height/2)-txtH);
    fill(255, aMed);
    text(mediumLabel, width/2, height/2);
    fill(255, aHard);
    text(hardLabel, width/2, (height/2)+txtH);
    fill(255, aRet1);
    text(returnLabel, width/2, (height/2)+(3*txtH));
  }
  
  /*
  Method
   */
  void displayInstructions()
  {
    fill(0, 150, 0);
    textAlign(CENTER);
    text(instructionsTitle, width/2, headerY);
    fill(255);
    text(instructionsBlurb, width/2, (height/2)-txtH);
    fill(255, aRet1);
    text(returnLabel, width/2, (height/2)+(3*txtH));
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
    text(gameoverLabel, 0, txtH/2, width, height);

    // displays score
    fill(200);
    textSize(40);
    text("Your score:   " + myAsteroidGame.myShip.score, 0, height/2.1, width, height);

    // play again button
    fill(0, 255, 0, aPA);
    textSize(35);
    textAlign(CENTER, CENTER);
    text(playAgainLabel, width/2, (height/2)+txtH);
    
    // exit button
    fill(255, aExit2);
    textSize(40);
    text(exitLabel, width/2, (height/2)+(2*txtH));
    
    // return to menu button
    fill(255, aRet2);
    textSize(40);
    text(returnLabel, width/2, (height/2)+(3*txtH));
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
    if (buttonDetect(button[0][0], button[0][1], button[0][2], button[0][3]))
    {
      aNG = bright;
    } else {
        aNG = dim;
      }  
    // instructions button  
    if (buttonDetect(button[1][0], button[1][1], button[1][2], button[1][3]))
    {
      aInst = bright;
    } else {
        aInst = dim;
      }  
    // exit button from main menu
    if (buttonDetect(button[2][0], button[2][1], button[2][2], button[2][3]))
    {
      aExit1 = bright;
    } else {
        aExit1 = dim;
      }
    // easy option button
    if (buttonDetect(button[3][0], button[3][1], button[3][2], button[3][3]))
    { 
      aEasy = bright;
    } else {
        aEasy = dim;
      }
    // medium option button
    if (buttonDetect(button[4][0], button[4][1], button[4][2], button[4][3]))
    {
      aMed = bright;
    } else {
        aMed = dim;
      }
    // hard option button
    if (buttonDetect(button[5][0], button[5][1], button[5][2], button[5][3]))
    {
      aHard = bright;
    } else {
        aHard = dim;
      }
    // return button 
    if (buttonDetect(button[6][0], button[6][1], button[6][2], button[6][3])) 
    { 
      aRet1 = bright;
    } else { 
        aRet1 = dim;
      }
    // play again button
    if (buttonDetect(button[7][0], button[7][1], button[7][2], button[7][3]))
    { 
      aPA = bright;
    } else {
        aPA = dim;
      }
    // exit button from game over screen
    if (buttonDetect(button[8][0], button[8][1], button[8][2], button[8][3]))
    {
      aExit2 = bright;
    } else {
        aExit2 = dim;
      }  
    // return to main menu button
    if (buttonDetect(button[9][0], button[9][1], button[9][2], button[9][3])) 
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
