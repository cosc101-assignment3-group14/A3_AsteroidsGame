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

  String newLabel, 
    instructionsLabel, 
    exitLabel, 
    easyLabel, 
    mediumLabel, 
    hardLabel, 
    chooseLabel, 
    returnLabel, 
    instructionsTitle, 
    instructionsBlurb;
  
  /*
  MainMenu constructor initialises varibles
  */
  MainMenu()
  {
    newLabel = "NEW GAME";
    instructionsLabel = "HOW TO PLAY";
    exitLabel = "EXIT";
    easyLabel = "EASY";
    mediumLabel = "MEDIUM";
    hardLabel = "HARD";
    chooseLabel = "CHOOSE YOUR DIFFICULTY";
    returnLabel = "RETURN TO MAIN MENU";
    instructionsBlurb = "WE WILL MAKE THIS ALL UP LATER";
    instructionsTitle = "THIS IS HOW YOU PLAY";
  }

  /*
  Method
  */
  void displayMenu()
  {
    background(0); 
    fill(255);
    textAlign(CENTER);
    textSize(35);
    text(newLabel, 400, 300); 
    text(instructionsLabel, 400, 400);
    text(exitLabel, 400, 500);
  }
  
  /*
  Method
  */
  boolean difficultyMenu()
  {
    if ((mouseX>350) && (mouseY<350) && (mouseX<450) && (mouseY>250))
    {
       return true;
    }
    return false;
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
  boolean difficultyEasy()
  {
    if ((mouseX>400) && (mouseY<350) && (mouseX<500) && (mouseY>250)) 
    {
      return true;    
    }
    return false;
  } 

  /*
  Method
  */
  boolean difficultyMedium()
  {
    if ((mouseX>400) && (mouseY<450) && (mouseX<500) && (mouseY>350)) 
    {
       return true;
    }
    return false;
  }

  /*
  Method
  */
  boolean difficultyHard()
  {
    if((mouseX>400) && (mouseY<450) && (mouseX<500) && (mouseY>550)) 
    {
      return true;
    }
    return false;
  }
  
  /*
  Method
  */
  boolean menuInstructions()
  {
    if((mouseX>350) && (mouseY<450) && (mouseX<450) && (mouseY>350)) 
    {
      return true;
    }
    return false;
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
  Method
  */
  boolean menuExit()
  {
    if((mouseX>350) && (mouseY<550) && (mouseX<450) && (mouseY>450)) 
    {
      return true;
    }
    return false;
  }
  
  /*
  Method
  */
  boolean menuReturn()
  {
    if((mouseX>350) && (mouseY<750) && (mouseX<450) && (mouseY>650)) 
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
}
