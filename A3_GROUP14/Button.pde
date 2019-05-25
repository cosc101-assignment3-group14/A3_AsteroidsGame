/**************************************************************
 * File: Button.pde
 * Group: 14; {Tegan Lee Barnes, Alison Bryce, Josh Le Gresley}.
 * Date: 24/05/2019
 * Course: COSC101 - Software Development Studio 1
 ***************************************************************/

/*
Button class adds a selectable button with a label to the menu screens 
 */
class Button
{
  int xorigin, // variable for the x co-ordinate location
    yorigin, // variable for the y co-ordinate location
    fontsize, // variable for the size of the font for label text
    offset, // variable for the gap between buttons
    opacity, // variable for the brightness of the font
    bright, // variable for the text opacity at its highest
    dim; // variable for the text opacity at half way

  float labelWidth; //variable for the on screen displayed width of label

  String label; // variable for the title of the label

  /*
  Button constructor initialises variables and calls the calculateDisplayWidth()
   method to calculate the on screen displayed width of the label. This value is 
   dependant on font size and is used to create acturate text only button detect.
   @PARAM xorigin is an int value for the x cordinate location
   @PARAM yorigin is an int value for the y cordinate location
   @PARAM label is a String for the label text
   @PARAM offset is the gap between buttons
   @PARAM fontsize is the fontsize for buttons
   */
  Button(int xorigin, int yorigin, String label, int offset, int fontsize)
  {
    // initialise variables
    this.xorigin = xorigin;
    this.yorigin = yorigin;
    this.offset = offset;
    this.fontsize = fontsize;
    this.label = label;
    bright = 255;
    dim = 120;

    // calculate on screen display width of label
    labelWidth = calculateDisplayWidth();
  }

  /*
  Method to display to button text
   */
  void displayButton()
  {
    textAlign(CENTER);
    textSize(fontsize);
    fill(255, opacity);
    text(label, xorigin, yorigin + offset);
  }

  /*
  Method to set button detection retangular area for mouse click. 
   The algorithm use the labelWidth calculated in the constructor call.
   @RETURN: true if area is clicked false if not.
   */
  boolean buttonDetect()
  {
    if ((mouseX > xorigin - labelWidth) && (mouseX < xorigin + labelWidth) && 
      ( mouseY > yorigin + offset - fontsize) && ( mouseY < yorigin + offset)) 
    {
      return true;
    }
    return false;
  }

  /*
  Method to highlight text when mouse hovers over, using the buttonDetect method. 
   If true the value at the opacity of the text becomes bright else if goes dim.
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
  Method to calculate the on screen display width of the button
   text label
   @ RETURN float value for the width
   */
  float calculateDisplayWidth()
  {
    float strLen = label.length();
    float charWidth = 0.8 * fontsize;

    return (strLen * charWidth)/2;
  }
}
