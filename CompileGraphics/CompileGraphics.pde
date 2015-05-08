import java.io.*;
//should I move submit.sh into this program?

/*
 * Compiles images in ../graphics/ folder into *.pde files, said files contain ready to use PGraphics objects.
 * Images are put into variables named "fooGraphic" where foo is the name of the image
 */

PImage image;
String result = ""; //contains the loadGraphics function
String variableDeclarations = "\n"; //contains the member variables required for loadGraphics

void setup(){
  //start function
  result += "/*\n";
  result += " * Loads all the required graphics.\n";
  result += " */\n";
  result += "void loadGraphics(){\n";

  for(File f : new File("../graphics/").listFiles()){

    //get file ext & name 
    int extIndex = f.getName().lastIndexOf(".");
    String name = f.getName().substring(0, extIndex);
    String ext = f.getName().substring(extIndex+1);

    if(ext.equals("png")){
      System.out.println("image: " + f.getName());

      //declare variablse
      variableDeclarations += "PGraphics " + name + "Graphic;\n";

      //grab file
      image = loadImage(f.getPath());
      image.loadPixels();

      result += "  color[] " + name + "GraphicArray = {\n  ";

      //iterate over image.pixels
      for(int i = 0; i < image.pixels.length; i++){
        result += "color(0x" + hex(image.pixels[i]) + "),";

        //adds a \n at new lines of the image for clarity
        int widthCount = (i + 1) % image.width;
        int lineCount = (i + 1) / image.width;
        if(widthCount == 0){
          result += "\n  ";
          System.out.println("Line: " + lineCount);
        }
      }
      result += "};\n\n";

      //load graphic into an image
      result += "  " + name + "Graphic = createGraphics(" + image.width + ", " + image.height + ");\n";
      result += "  " + name + "Graphic.pixels = " + name + "GraphicArray;\n";
      result += "  " + name + "Graphic.updatePixels();\n";
    }
  }

  //end function
  result += "}";

  writeResult();
  exit();
}

/*
 * Write result into ../compiledGraphics.pde
 */
void writeResult(){
  String outputLocation = "../compiledGraphics.pde";
  String[] output = {variableDeclarations, result};
  saveStrings(outputLocation, output);
}
