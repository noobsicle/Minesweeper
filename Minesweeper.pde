import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); 
; //ArrayList of just the minesweeper buttons that are mined

private static int NUM_ROWS = 20;
private static int NUM_COLS = 20;
private int nBombs = 45;
private int bombN = 0;
private int marks = 398;
void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to declare and initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int y = 0; y<NUM_ROWS; y++) {
    for (int x = 0; x<NUM_COLS; x++) {
      buttons[y][x] = new MSButton(y, x);
    }
  }
  for (int b = 1; b<=nBombs; b++) {  
    setBombs();
  
  }
  bombN = nBombs;
}
public void setBombs()
{
  //your code
  int rNum = (int)(Math.random()*20);
  int cNum = (int)(Math.random()*20);

  if (!bombs.contains(buttons[rNum][cNum])) {
    bombs.add(buttons[rNum][cNum]);
  }
}
public void draw ()
{
  background( 0 );
  if (isWon())
    displayWinningMessage();
}
public boolean isWon()
{

  if(bombN==0&&marks==0){
   return true; 
  }
  return false;
}
public void displayLosingMessage()
{
  //your code here
  buttons[10][7].setLabel("Y");
  buttons[10][8].setLabel("O");
  buttons[10][9].setLabel("U");
  buttons[10][11].setLabel("L");
  buttons[10][12].setLabel("O");
  buttons[10][13].setLabel("S");
  buttons[10][14].setLabel("E");
  noLoop();
}
public void displayWinningMessage()
{
  //your code here
  buttons[10][7].setLabel("Y");
  buttons[10][8].setLabel("O");
  buttons[10][9].setLabel("U");
  buttons[10][11].setLabel("W");
  buttons[10][12].setLabel("I");
  buttons[10][13].setLabel("N");
  noLoop();
}

public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked, white;
  private String label;
  private int labelNum, markN;
  public MSButton ( int rr, int cc )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }
  // called by manager
  public void mousePressed () {

    clicked = true;
    //your code here
    if(mouseButton==LEFT&& marked==false){
    marks--;
    }
      
    if (mouseButton == RIGHT&&marked==false&&white==false) {
      marked = true;
      if(bombs.contains(this)){
       bombN--; 
      }
      
    }

      else if(bombs.contains(this)&&marked==false){
       for(int i = 0; i<NUM_ROWS; i++){
         for(int j = 0; j<NUM_COLS; j++){ 
         buttons[i][j].clicked=true;    
         } 
        }
        displayLosingMessage();
       } 
       else if (mouseButton == RIGHT&&marked==true) {
      marked=false;
      clicked=false;
      
      if(bombs.contains(this)){
      bombN++;
      }
    } 
    else if ((countBombs(r, c)>0)&&marked==false) { 
      setLabel(" " + countBombs(r, c));
      white = true;
    } else {
      if (isValid(r, c-1)&&(buttons[r][c-1].isClicked()==false)&&marked==false) {               
        buttons[r][c-1].mousePressed();
         white = true;
      }
      if (isValid(r-1, c)&&(buttons[r-1][c].isClicked()==false)&&marked==false) {    
        buttons[r-1][c].mousePressed();
        white = true;
      }
      if (isValid(r-1, c+1)&&(buttons[r-1][c+1].isClicked()==false)&&marked==false) {    
        buttons[r-1][c+1].mousePressed();
        white = true;
      }
      if (isValid(r-1, c-1)&&(buttons[r-1][c-1].isClicked()==false)&&marked==false) {     
        buttons[r-1][c-1].mousePressed();
        white = true;
      }
      if (isValid(r, c+1)&&(buttons[r][c+1].isClicked()==false)&&marked==false) {     
        buttons[r][c+1].mousePressed();
        white = true;
      }
      if (isValid(r+1, c-1)&&(buttons[r+1][c-1].isClicked()==false)&&marked==false) {
        buttons[r+1][c-1].mousePressed();
        white = true;
      }
      if (isValid(r+1, c)&&(buttons[r+1][c].isClicked()==false)&&marked==false) {
        buttons[r+1][c].mousePressed();
        white = true;
      }
      if (isValid(r+1, c+1)&&(buttons[r+1][c+1].isClicked()==false)&&marked==false) {      
        buttons[r+1][c+1].mousePressed();
        white = true;
      }
    }
  }

  public void draw () 
  {    
    if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
      fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    //your code here
    if (r<0||r>19||c<0||c>19)
      return false;
    else
      return true;
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;
    //your code here
    if (isValid(row-1, col-1)) {           
      if (bombs.contains(buttons[row-1][col-1])) {
        numBombs+=1;
      }
    }
    if (isValid(row-1, col)) {
      if (bombs.contains(buttons[row-1][col])) {
        numBombs+=1;
      }
    }
    if (isValid(row-1, col+1)) {
      if (bombs.contains(buttons[row-1][col+1])) {
        numBombs+=1;
      }
    }
    if (isValid(row, col-1)) {
      if (bombs.contains(buttons[row][col-1])) {
        numBombs+=1;
      }
    }
    if (isValid(row, col+1)) {
      if (bombs.contains(buttons[row][col+1])) {
        numBombs+=1;
      }
    }
    if (isValid(row+1, col-1)) {
      if (bombs.contains(buttons[row+1][col-1])) {
        numBombs+=1;
      }
    }
    if (isValid(row+1, col)) {
      if (bombs.contains(buttons[row+1][col])) {
        numBombs+=1;
      }
    }
    if (isValid(row+1, col+1)) {
      if (bombs.contains(buttons[row+1][col+1])) {
        numBombs+=1;
      }
    }
    return numBombs;
  }
}

