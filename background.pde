class Background{
  float i = 0;
  color[] colors = null;
  PGraphics spiral = null;
  PGraphics stars = null;
  PGraphics background = null;
  float spiralPhase;
  
  public Background(){
    colors = generateColors();
    newLocation();
  }
  
  /*
   * Generates a fresh background
   */
  public void newLocation(){
    spiralPhase = random(PI*2);
    stars = generateStars();

    updateBackground();
  }

  /*
   * Generates next frame of background animation
   */
  public void updateBackground(){
    spiralPhase += 0.1;
    spiral = generateSpiral(random(PI*2));

    background = createGraphics(width, height);
    background.beginDraw();
    background.image(spiral, 0, 0);
    background.image(stars, 0, 0);
    background.endDraw();
  }

  /*
   * Returns the current background.
   */
  public PGraphics getBackground(){
    return background;
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
      for(float i = 0; i < 2000; i += 0.2){
        int colorsUsed = (int) Math.floor((colors.length * i / 2000));
        if(colorIndex > colorsUsed){
          continue;
        }
        int diameter = colorsUsed - colorIndex+1;
        float xPixel = (i*cos(i/100 + phase))/5 + 300;
        float yPixel = (i*sin(i/100 + phase))/5 + 300;
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
