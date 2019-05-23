/************************************************************** //<>//
 * File: MainMenu.pde
 * Group: 14; {Tegan Lee Barnes, Alison Bryce, Josh Le Gresley}.
 * Date: 12/04/2018
 * Course: COSC101 - Software Development Studio 1
 ***************************************************************/

/*
The MainMenu class creates the starting page interface for the Asteroids game. 
 */
class MainMenu
{
  PImage expl; // image variable to store the gameover page image

  String title, // String variable to store main page title
    newLabel, // String variable to store new game button label
    instructionsLabel, // String variable to store instruction button label
    exitLabel, // String variable to store exit button label
    easyLabel, //  String variable to store easy button label
    mediumLabel, // String variable to store medium button label
    chooseLabel, // String variable to store choose game title
    hardLabel, // String variable to storechoose game title
    returnLabel, // String variable to store return button label
    gameoverLabel, // String variable to store gameover title
    playAgainLabel, // String variable to store play again button label
    instructionsTitle, // String variable to store instructions title
    instructionsDetail;// String variable to store intstructions description

  Boolean gameOver, // boolean flag used to state if the game is over
    selected;  // boolean flag used to state the mouse was pressed

  int bright, // text opacity at its highest
    dim, // text opacity at half way
    headerY, // variable to store alignment y value for header
    txtH, // variable to store value of the height of the text
    txtL; // variable to store the lenght of the text

  int[] highlighting; // int array to store the alpha text opacity for each button

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
    instructionsTitle = "YOUR MISSION";
    instructionsDetail = "Mission: \n Destory all asteroids and alien spaceships.\n" 
      + "\nLives: \n Each player has 3 lives. Collision with an \n asteriod looses a " 
      + "life. But be careful!  Collision \n with an alien spaceship means game over!\n" 
      + "\nControls: \n Right Turn: Right arrow. \n Left Turn: Left arrow. \n" 
      + "Move Upwards: Up arrow. \n Move Downwards: Down arrow.";

    //initialise int variables
    bright = 255;
    dim = 120;
    headerY = 150;
    txtH = 100;
    txtL = 80;

    // game over image of an explosion
    expl = loadImage("pngkey.com-pixel-explosion-png-3017570.png");

    //initialise boolean variables
    gameOver = false;  // boolean flag used to state if the game is over

    // initialise an int array to the lenght of the number of buttons required
    highlighting = new int[10];
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

    // display new game button label
    textSize(35);
    fill(255, highlighting[0]);
    text(newLabel, width/2, height/2); 

    // display instructions button label
    fill(255, highlighting[1]);
    text(instructionsLabel, width/2, (height/2)+txtH);

    // display exit button label
    fill(255, highlighting[2]);
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

    //display choose game label
    text(chooseLabel, width/2, headerY);
    textSize(35);

    // display easy button label
    fill(255, highlighting[3]);
    text(easyLabel, width/2, (height/2)-txtH);

    // display medium button label
    fill(255, highlighting[4]);
    text(mediumLabel, width/2, height/2);

    // display hard button label
    fill(255, highlighting[5]);
    text(hardLabel, width/2, (height/2)+txtH);

    // display return button label
    fill(255, highlighting[9]);
    text(returnLabel, width/2, (height/2)+(3*txtH));
  }

  /*
  Method to display the instructions menu
   */
  void displayInstructions()
  {
    fill(0, 150, 0);
    // title and instrructions text
    textAlign(CENTER);    
    textSize(55);
    text(instructionsTitle, width/2, headerY);
    fill(255);
    textSize(25);
    text(instructionsDetail, width/2, (height/3));

    // display return button label
    fill(255, highlighting[9]);
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
    text("Your score:   " 
      + myAsteroidGame.myShip.score, 0, height/2.1, width, height);

    // display play again button label
    fill(0, 255, 0, highlighting[7]);
    textSize(35);
    textAlign(CENTER, CENTER);
    text(playAgainLabel, width/2, (height/2)+txtH);

    // display exit button label
    fill(255, highlighting[8]);
    textSize(40);
    text(exitLabel, width/2, (height/2)+(2*txtH));

    // display return button label
    fill(255, highlighting[9]);
    textSize(40);
    text(returnLabel, width/2, (height/2)+(3*txtH));
  }

  /*
  Method to set button detection retangular area for mouse click. Each array in the 
   2D array stores precise coordinates to give precise button detection around the word.
   @PARAM: button is 2D array storing coordinates for button collision
   @PARAM: index the array index that is storing the required cordinates
   @RETURN: true if area is clicked false if not.
   */
  boolean buttonDetect(int[][] button, int index)
  {
    if ((mouseX > button[index][0]) && (mouseX < button[index][1]) && 
      ( mouseY > button[index][2]) && ( mouseY < button[index][3])) 
    {
      return true;
    }
    return false;
  }

  /*
  Method to highlight text when mouse hovers over, using the buttonDetect method. The 
   for loop iterates though the arrays in the 2D array testing out each one using the
   buttonDetect method. If true the value at the corresponding index in the highlighting 
   array becomes bright else if remains dim.
   @PARAM: button is 2D array storing coordinates for button collision
   */
  void textHighlight(int[][] button)
  {
    for (int i = 0; i < button.length; i ++)
    {
      // new game button
      if (buttonDetect(button, i))
      {
        highlighting[i] = bright;
      } else
      {
        highlighting[i] = dim;
      }
    }
  }

  /*
  Method to call the built in exit function
   */
  void gameExit()
  {
    exit();
  }
}  
