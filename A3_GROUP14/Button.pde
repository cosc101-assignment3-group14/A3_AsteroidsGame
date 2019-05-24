/**************************************************************
 * File: Button.pde
 * Group: 14; {Tegan Lee Barnes, Alison Bryce, Josh Le Gresley}.
 * Date: 12/04/2018
 * Course: COSC101 - Software Development Studio 1
 ***************************************************************/

/*
Button class adds a selectable button with a label to the menu screens 
 */
class Button
{
   int xorigin,
     yorigin,
     fontsize,
     offset,
     opacity,
     bright, // text opacity at its highest
     dim, // text opacity at half way
     labelWidth;
     
   String label;
  /*
  Button constructor
  */
  Button(int xorigin, int yorigin, String label, int offset, int fontsize)
  {
    this.xorigin = xorigin;
    this.yorigin = yorigin;
    this.offset = offset;
    this.fontsize = fontsize;
    this.label = label;
    bright = 255;
    dim = 120;
    
    //label text opacity initialises as dim
    opacity = dim;
    
    labelWidth = calculateDisplayWidth();
  }
  
  /*
  
  */
  void displayButton()
  {
    textSize(fontsize);
    fill(255, opacity);
    text(label, xorigin, yorigin + offset); 
  }
  
  /*
  Method to set button detection retangular area for mouse click.
   @RETURN: true if area is clicked false if not.
   */
  boolean buttonDetect()
  {
    labelWidth = calculateDisplayWidth();
    
    if ((mouseX > xorigin - labelWidth) && (mouseX < xorigin + labelWidth) && 
      ( mouseY > yorigin + fontsize) && ( mouseY < yorigin)) 
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
   */
  void textHighlight()
  {
    if (buttonDetect())
    {
      opacity = bright;
    } else
    {
      opacity = dim;
    }
  }
  
  /*
  
  */
  int calculateDisplayWidth()
  {
    int strLen = label.length();
    int charWidth = ;
    
    return (strLen * charWidth)/2;
  }
}
