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

  String newLabel, //
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

  int score; //

  /*
  MainMenu constructor initialises varibles
   */
  MainMenu()
  {
    //initialise string variables
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

    //initialise boolean variables
    gameOver = false;  // boolean flag used to state if the game is over
  }

  /*
  Method
   */
  void displayMenu()
  {
    fill(255);
    textAlign(CENTER);
    textSize(35);
    text(newLabel, 400, 400); 
    text(instructionsLabel, 400, 500);
    text(exitLabel, 400, 600);
  }

  /*
  Method to display the difficulty menu
   */
  void displayDifficultyMenu()
  {
    background(0);
    fill(255);
    textSize(40);
    textAlign(CENTER);
    text(chooseLabel, 400, 150);
    textSize(35);
    text(easyLabel, 400, 300);
    text(mediumLabel, 400, 400);
    text(hardLabel, 400, 500);
    text(returnLabel, 400, 700);
  }
  
  /*
  Method
   */
  void displayInstructions()
  {
    fill(225);
    textAlign(CENTER);
    text(instructionsTitle, 400, 150);
    text(instructionsBlurb, 400, 300);
    text(returnLabel, 400, 700);
  }
  
  /*
  Method to display the game over screen with options to play again or return to menu
   */
  void displayEndGame()
  {
    // creates zooming in effect
    for (int x = 1; x < 101; x += 5)
    {
      fill(x);
      textSize(x);
      textAlign(CENTER, TOP);
      text(gameoverLabel, 0, height/8, width, height);
    }
    
    // displays the 'game over' message
    fill(255, 0, 0);
    textSize(100);
    textAlign(CENTER, TOP);
    text(gameoverLabel, 0, height/8, width, height);
    
    // play again button
    fill(0, 255, 0, 100);
    textSize(30);
    textAlign(CENTER, CENTER);
    text(playAgainLabel, 400, 500);
    
    // exit button
    fill(180);
    textSize(40);
    textAlign(CENTER, TOP);
    text(exitLabel, 400, 600);
    
    // return to menu button
    fill(180);
    textSize(40);
    textAlign(CENTER, TOP);
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
  Method
   */
  void gameExit()
  {
    exit();
  }

  ///*
  //Method to display the menu message and if selected takes user to the menu
  // */
  //boolean backToMenu()
  //{
  // if ((mouseX>350) && (mouseY<550) && (mouseX<450) && (mouseY>450)) 
  //  {
  //    // text highlights
  //    fill(240);
  //    textSize(40);
  //    textAlign(CENTER, TOP);
  //    text("MENU", 0, height*3/4, width, height);

  //    // go back to main menu
  //    if (mousePressed)
  //    {
  //      // TODO boolean for the main menu screen?
  //    }
  //  }
  //}   

  ///*
  //Method to display the 'play again' message and if selected restarts the game
  // */
  //boolean PlayAgain()
  //{    
  //  if ((mouseX>400) && (mouseY<450) && (mouseX<500) && (mouseY>550)) 
  //  {
  //    // text highlights
  //    fill(0, 255, 0);
  //    textSize(30);
  //    textAlign(CENTER, CENTER);
  //    text("Play again?", 0, 0, width, height);

  //    // restart game
  //    if (mousePressed)
  //    {
  //      // TODO restart game
  //    }
  //  }
  //}
}
