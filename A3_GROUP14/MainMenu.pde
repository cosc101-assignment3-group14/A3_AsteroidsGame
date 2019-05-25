/**************************************************************  //<>//
 * File: MainMenu.pde
 * Group: 14; {Tegan Lee Barnes, Alison Bryce, Josh Le Gresley}.
 * Date: 12/05/2019
 * Course: COSC101 - Software Development Studio 1
 ***************************************************************/

/*
The MainMenu class creates the starting page interface for the Asteroids game. It aso
 creates a game over screen. This class accesses the button class to create an array 
 list of button objects.
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

  // declare Button ArrayList object ArrayList to hole the buttons for each menu page;  
  ArrayList<ArrayList<Button>> myButtons = 
    new ArrayList<ArrayList<Button>>(); 

  /*
  MainMenu constructor initialises varibles
   */
  MainMenu()
  {
    // initialise string 2D array with button labels for each menu page
    myLabels = new String[][]{{"NEW GAME", "HOW TO PLAY", "EXIT"}, // main menu
      {"EASY", "MEDIUM", "HARD", "MAIN MENU"}, // difficulty screen
      {"MAIN MENU"}, // instructions screen
      {"PLAY AGAIN?", "EXIT", "MAIN MENU"}}; // gameover screen

    //initialise string variables for titles
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

    //creates Button objects add adds them to the Button Arraylist
    createButtons();
  }

  /*
  Method to create Button objects
   */
  void createButtons()
  {
    // initialise a local Array list
    ArrayList<Button> menuButtons = new ArrayList<Button>(); 

    // loop through arrays in 2D  String array
    for (int i = 0; i < myLabels.length; i ++)
    {
      // for pages with three buttons
      if (myLabels[i].length == 3)
      {
        int offset = 120;
        for (int j = 0; j < myLabels[i].length; j ++)
        {
          Button newButton = 
            new Button(height/2, width/2, myLabels[i][j], offset, font);
          menuButtons.add(newButton);
          offset += txtH;
        }

        // add the ArrayList of buttons to the myButtons ArrayList
        myButtons.add(menuButtons);

        // create a new local ArrayList for the next iteration
        menuButtons = new ArrayList<Button>();
      } else if (myLabels[i].length == 4)
      {
        int offset = -txtH;
        for (int j = 0; j < myLabels[i].length; j ++)
        {
          Button newButton = 
            new Button(width/2, height/2, myLabels[i][j], offset, font);
          menuButtons.add(newButton);
          offset += txtH;
        }

        // add the ArrayList of buttons to the myButtons ArrayList
        myButtons.add(menuButtons);

        // create a new local ArrayList for the next iteration
        menuButtons = new ArrayList<Button>();
      } else if (myLabels[i].length == 1)
      {
        int offset = 3*txtH;
        Button newButton = new Button(height/2, width/2, myLabels[i][0], offset, font);
        menuButtons.add(newButton);

        // add the ArrayList of buttons to the myButtons ArrayList
        myButtons.add(menuButtons);
        // create a new local ArrayList for the next iteration
        menuButtons = new ArrayList<Button>();
      }
    }
  }

  /*
  Method to update Button objects Arraylist
   @PARAM menuMum: is an int to correspond to the current menu page
   */
  void updateButtons(int menuNum)
  {
    for (int i = 0; i < myButtons.get(menuNum).size(); i ++)
    {
      myButtons.get(menuNum).get(i).displayButton();
      myButtons.get(menuNum).get(i).textHighlight();
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

    // displays and updates button highlighting
    updateButtons(0);
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

    // displays and updates button highlighting
    updateButtons(1);
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

    // displays and updates button highlighting
    updateButtons(2);
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

    // displays and updates button highlighting
    updateButtons(3);
  }

  /*
  Method to call the built in exit function
   */
  void gameExit()
  {
    exit();
  }
}  
