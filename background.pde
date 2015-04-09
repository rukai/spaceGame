class Background extends Thread{
  float i = 0;
  color[] colors = null;
  PGraphics spiral = null;
  PGraphics stars = null;
  PGraphics background = null;
  PGraphics newBackground = null;
  int spiralPower;
  float spiralPhase = 0; 
  int spiralDirection = 1; // a multiplier (-1 or 1) to change the direction of the spiral
  int phaseDirection = 1; // a multiplier (-1 or 1) to change the direction of the spiral's phase
  boolean backgroundRendered = false;
  boolean renderNewBackground = true;
  
  public Background(){
    colors = generateColors();
  }

  /*
   * Code to be run from another thread
   */
  public void run(){
    while(true){
      try{
        Thread.sleep(10);
      }
      catch(InterruptedException e){
      }
      if(renderNewBackground){
        newLocation();
        renderNewBackground = false;
      }
    }
  }

  /*
   * Generates a fresh background
   */
  private void newLocation(){
    spiralPhase = random(PI*2);
    spiralDirection = (int(random(2)) == 0) ? 1 : -1;
    phaseDirection = (int(random(2)) == 0) ? 1 : -1;
    spiralPower = (int) random(70, 200);
    stars = generateStars();

    updateBackground();
  }

  /*
   * Generates next frame of background animation
   * The code worked well, but was unappealling visually so I'll leave it here for now.
   */
  private void updateBackground(){
    spiral = generateSpiral(spiralPhase);
    spiralPhase += 0.1 * phaseDirection;

    PGraphics tmpbg = createGraphics(width, height);
    tmpbg.beginDraw();
    tmpbg.image(spiral, 0, 0);
    tmpbg.image(stars, 0, 0);
    tmpbg.endDraw();
    background = tmpbg;
    backgroundRendered = true;
  }

  /*
   * Returns the current background.
   */
  public PImage getBackground(){
    try{
      while(!backgroundRendered){
        Thread.sleep(10);
      }
    }
    catch(InterruptedException e){
    }
    renderNewBackground = true;
    return background.get();
  }

  /*
   * Returns an array of colors with a transition from dark blue to white
   */
  public int[] generateColors(){
    final int MAX_COLOR = 160;
    color[] colors = new color[20];
    for(int i = 0; i < colors.length; i++){
      int val = (i * MAX_COLOR / colors.length);
      int blueVal = i * 190 / 6;
      colors[i] = color(val+20, val+20, blueVal+50);
    }
    return colors;
  }

  /*
   * Returns a spiral on a black background
   */
  public PGraphics generateSpiral(float phase){

    PGraphics spiral = createGraphics(width, height);
    spiral.beginDraw();
    spiral.background(10);

    for(int colorIndex = 0; colorIndex < colors.length; colorIndex++){
      for(float i = 0; i < 2000; i += 0.4){
        int colorsUsed = (int) Math.floor((colors.length * i / 2000));
        if(colorIndex > colorsUsed){
          continue;
        }
        int diameter = colorsUsed - colorIndex + 1;
        i *= spiralDirection;
        float xPixel = (i*cos((i+500)/spiralPower + phase))/5 + 300;
        float yPixel = (i*sin((i+500)/spiralPower + phase))/5 + 300;
        i *= spiralDirection;
        spiral.stroke(colors[colorIndex]);
        spiral.ellipse(xPixel, yPixel, diameter, diameter);
      }
    }
    spiral.endDraw();
    return spiral;
  }

  /*
   * Generate a new background of stars
   */
  public PGraphics generateStars(){
    PGraphics backgroundGraphic = createGraphics(width, height);

    backgroundGraphic.beginDraw();
    //Do we need to avoid stars being placed on the same pixel?
    //"You must use loops and arrays to get full marks for this part." - Do we really need arrays?
    for(int i = 0; i < 100; i++){
      backgroundGraphic.fill(#FFFFFF);
      backgroundGraphic.stroke(#FFFFFF);
      backgroundGraphic.point(random(width), random(height));
    }
    backgroundGraphic.endDraw();
    return backgroundGraphic;
  }
}
