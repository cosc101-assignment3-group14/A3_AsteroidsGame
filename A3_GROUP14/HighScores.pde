/**************************************************************
 * File: Ship.pde
 * Group: 14; {Tegan Lee Barnes, Alison Bryce, Josh Le Gresley}.
 * Date: 12/04/2018
 * Course: COSC101 - Software Development Studio 1
 ***************************************************************/
 
/*
The HighScores class creates a record of the scores for the AsteroidsGame class.
 */

class HighScores
{
  PrintWriter output;
  BufferedReader reader;
  
  Boolean gameOver;  // boolean flag used to state if the game is over
  Boolean oneLetter;
  String txt;
  
  int score;
  int highscore;
  
  String letters = "";
  int back = 102;
  
  /*
  HighScores constructor 
  */
  HighScores()
  {

   // highScoresFile();
    gameOver = false;  // boolean flag used to state if the game is over
    oneLetter = false;
  //  String[] lines = loadStrings("highscores.txt");
   // txt = join(lines, "\n");
    
  }  
    
  void endOfGame()
    {
      // creates zooming in effect
      for (int x = 1; x < 101; x += 5)
      {
        fill(x);
        textSize(x);
        textAlign(CENTER, TOP);
        text("GAME OVER", 0, height/8, width, height);
      }
      // displays the game over message
      fill(255, 0, 0);
      textSize(100);
      textAlign(CENTER, TOP);
      text("GAME OVER", 0, height/8, width, height);
      
      // displays the high score and prompts user to enter name
      fill(255);
      textSize(40);
      textAlign(CENTER, TOP);
      text("HIGH SCORE", 0, height/3, width, height);
      fill(255);
      textSize(30);
      textAlign(CENTER, CENTER);
      text("Enter your name: ", 0, 0, width, height);
      enterName();
      oneLetter = false;
    }  
      
  void enterName()
  {
      if (keyPressed)
      {
        // If the key is alphanumeric, add it to the String
        if ((key > 31) && (key != CODED) && !oneLetter) 
        {
          oneLetter = true;
          letters = letters + key;
          letters = letters.toUpperCase();
          textSize(30);
          textAlign(CENTER, BOTTOM);
          text(letters, 0, 0, width, height* 2/3);   
        }
      }
      
      /*
        else if ((key == ENTER) || (key == RETURN)) 
        {
          String[] highscore = new String[letters];
          saveStrings("highscores.txt", highscore);
        }*/
     
    }
        
        

   //   writeHighScore();
    }
  
  /*
  void writeHighScore()
  {
    if (highscore < score)
    {
    if (keyPressed)
    {
      output = createWriter("highscores.txt");
      output.print(key);
      if (keyPressed && keyCode == ENTER)
      {
        output.println("\t" + myAsteroidGame.myShip.score);
        output.close();
      }
    }
    }
  }
  
  void highScoresFile()
  {
    reader = createReader("highscores.txt");
    if (reader == null) 
    {
      highscore = 0;
      return;
    }
    String line;
    try 
    { 
      line = reader.readLine();
    }
    catch (IOException e) 
    {
      e.printStackTrace();
      line = null;
    }
    if (line != null)
    {
      highscore = int(line);
    }
    try
    {
      reader.close();
    }
    catch (IOException e) 
    {
      e.printStackTrace();*/
    
  
  
