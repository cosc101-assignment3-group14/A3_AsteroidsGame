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
    chooseTitle, // String variable to store choose game title
    gameoverTitle, // String variable to store gameover title
    instructionsTitle, // String variable to store instructions title
    instructionsDetail;// String variable to store intstructions description
    
  String[][] myLabels; // 2D String array to store each pages button labels

  Boolean gameOver, // boolean flag used to state if the game is over
    selected;  // boolean flag used to state the mouse was pressed

  int headerY, // variable to store alignment y value for header
    txtH, // variable to store value of the height of the text
    txtL, // variable to store the lenght of the text
    font; // button font size
  
  ArrayList<Button> menuButtons = 
    new ArrayList<Button>(); // declare Button object ArrayList for current menu page
    
  /*
  MainMenu constructor initialises varibles
   */
  MainMenu()
  {
    // initialise string 2D array
    
    myLabels = new String[][]{{"NEW GAME", "HOW TO PLAY", "EXIT"},
                            {"EASY", "MEDIUM", "HARD", "MAIN MENU"},
                            {"MAIN MENU"},
                            {"PLAY AGAIN?", "EXIT", "MAIN MENU"}};
    
    //initialise string variables

    gameoverTitle = "GAME OVER";
    chooseTitle = "CHOOSE YOUR DIFFICULTY";
    title = "asteroids";
    instructionsTitle = "YOUR MISSION";
    instructionsDetail = "Mission: \n Destory all asteroids and alien spaceships.\n" 
      + "\nLives: \n Each player has 3 lives. Collision with an \n asteriod looses a " 
      + "life. But be careful!  Collision \n with an alien spaceship means game over!\n" 
      + "\nControls: \n Right Turn: Right arrow. \n Left Turn: Left arrow. \n" 
      + "Move Upwards: Up arrow. \n Move Downwards: Down arrow.";

    //initialise int variables
    headerY = 150;
    txtH = 100;
    txtL = 80;
    font = 35;

    // game over image of an explosion
    expl = loadImage("pngkey.com-pixel-explosion-png-3017570.png");

    //initialise boolean variables
    gameOver = false;  // boolean flag used to state if the game is over
  }
  
  /*
  Method to create Button objects
  @PARAM index the index value of the corresponing array in the 2D array of button labels
  @PARAM fonsize is the size of the button label font
  */
  void createButtons(int index, int fontsize )
  {
    int offset = 0;
    for(int i = 0; i < myLabels[index].length; i ++)
    {
      Button newButton = new Button(height/2, width/2, myLabels[index][i], offset, fontsize);
      
      menuButtons.add(newButton);
      
      offset += txtH;
    }
  }
    
    /*
  Method to update Button objects Arraylist
  */
  void updateButtons()
  {
    for(int i = 0; i < menuButtons.size(); i ++)
    {
      menuButtons.get(i).displayButton();
      menuButtons.get(i).textHighlight();
    }
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

    createButtons(0, font);
    
    updateButtons();
    
    // display new game button label
    //textSize(font);
    //fill(255, highlighting[0]);
    //text(newLabel, width/2, height/2); 

    //// display instructions button label
    //fill(255, highlighting[1]);
    //text(instructionsLabel, width/2, (height/2)+txtH);

    //// display exit button label
    //fill(255, highlighting[2]);
    //text(exitLabel, width/2, (height/2)+(2*txtH));
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
    text(chooseTitle, width/2, headerY);
    textSize(35);

    //// display easy button label
    //fill(255, highlighting[3]);
    //text(easyLabel, width/2, (height/2)-txtH);

    //// display medium button label
    //fill(255, highlighting[4]);
    //text(mediumLabel, width/2, height/2);

    //// display hard button label
    //fill(255, highlighting[5]);
    //text(hardLabel, width/2, (height/2)+txtH);

    //// display return button label
    //fill(255, highlighting[9]);
    //text(returnLabel, width/2, (height/2)+(3*txtH));
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

    //// display return button label
    //fill(255, highlighting[9]);
    //text(returnLabel, width/2, (height/2)+(3*txtH));
  }

  /*
  Method to display the game over screen with options to play again or return to menu
   */
  void displayEndGame(int score)
  { 
    // explosion image
    image(expl, 0, 0, width, height/2.5);  

    // game over text
    textAlign(CENTER, TOP);
    fill(130, 0, 0);
    textSize(115);
    text(gameoverTitle, 0, txtH/2, width, height);

    // displays score
    fill(200);
    textSize(40);
    text("Your score:   " 
      + score, 0, height/2.1, width, height);

    //// display play again button label
    //fill(0, 255, 0, highlighting[7]);
    //textSize(35);
    //textAlign(CENTER, CENTER);
    //text(playAgainLabel, width/2, (height/2)+txtH);

    //// display exit button label
    //fill(255, highlighting[8]);
    //textSize(40);
    //text(exitLabel, width/2, (height/2)+(2*txtH));

    //// display return button label
    //fill(255, highlighting[9]);
    //textSize(40);
    //text(returnLabel, width/2, (height/2)+(3*txtH));
  }

  /*
  Method to call the built in exit function
   */
  void gameExit()
  {
    exit();
  }
}  
