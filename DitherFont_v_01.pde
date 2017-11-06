import controlP5.*;
import geomerative.*;
import fontastic.*;

ControlP5 cp5;
Fontastic ff;
RFont f;
RShape grp;
RPoint[] points;
GradientLetter GL;
Dither d;

PImage DitherChar, letter;
PFont mono;
String press = "Press the spacebar\nto make the font";
PVector[]  FontPoints; 
int version = 7, xOffset = 270;
String[] unicodeString;
char[] unicode;
boolean init = false;
float fac = 0, pix1 = 0, pix2 = 0, pix3 = 0, pix4 = 0, prev1 = 0, prev2 = 0, prev3 = 0, prev4 = 0;
void setup() {
  size(1000, 580);//needs to be revised
  unicodeString = loadStrings("unicode.txt");
  println(unicodeString.length);
  unicode = new char[unicodeString.length];
  for (int i = 0; i < unicodeString.length; i++)unicode[i] = unicodeString[i].charAt(0);
  version = int(loadStrings(sketchPath()+"/version.txt")[0]);
  println(nf(version, 3));
  // VERY IMPORTANT: Allways initialize the geomerative library in the setup
  //do this before initializing the gradientletter class
  RG.init(this);
  GL = new GradientLetter("D");
  d = new Dither(GL.gradientletter());  
  letter = d.ditheredImageEnlarged();
  cp5 = new ControlP5(this);
  initControllers();
  mono = loadFont("SourceCodePro-Black-18.vlw");
}

void draw() {
  background(0, 0, 255);  
  //here we check if the value of the kernel has been changed if yes
  //the previous value is updated to the new value and we generate a new dither
  //with the new values
  if (prev1 != pix1 || prev2 != pix2 || prev3 != pix3 || prev4 != pix4) {
    //update the kernel
    d.kernel[1][2] = (float)pix1;
    d.kernel[2][0] = (float)pix2;
    d.kernel[2][1] = (float)pix3;
    d.kernel[2][2] = (float)pix4;
    //update the previous value
    prev1 = pix1;
    prev2 = pix2;
    prev3 = pix3;
    prev4 = pix4;
    d.generateDither();
  }
  d.displayDither(xOffset);
  textAlign(LEFT);
  textFont(mono);
  fill(0, 255, 0);
  text(press, 20, 300);
  if (init) {  
    PFont myFont = createFont(ff.getTTFfilename(), 80);
    textFont(myFont);
    String hello = "Hello\nDither\nFont";
    text(hello, xOffset + d.big.width + 50, 200);//, width/2, height/5);
  }
}

void keyPressed() {
  GL.setChar(str(key));
  d.setGradientImage(GL.gradientletter());
  if(key == ' ')createFont();
}

void createFont() {
  init = true;//we declare that the font has been initialized
  version++;
  //save the version in text file, so that every time you reopen the program
  //it will update the version from the last one
  String [] saveTxt = {str(version)};
  saveStrings("version.txt", saveTxt);
  String ditherDetail = fac +":"+ pix1 +":"+ pix2 +":"+ pix3 +":"+ pix4;
  ff = new Fontastic(this, "DitherFont_" + nf(version, 3));
  ff.setAdvanceWidth(600);
  ff.setAuthor("YANO");
  ff.setVersion("1.1");
  ff.setTypefaceLicense("SIL OPEN FONT LICENSE Version 1.1");
  //all the chars in the unicode, extend it to cyrillic etc
  //get it here as a txt file https://unicode-table.com/en/tools/generator/
  for (char c : unicode) {//unicode

    ff.addGlyph(c);
    //make a gradient letter
    GL.setChar(str(c));
    //turn it into a dither
    d.setGradientImage(GL.gradientletter());
    float scale = 20.0;//scaling the black dots of the image to enlarge it to turn it into a font
    DitherChar = d.ditheredImage();
    //the next 2 line of code mirror the letter vertically
    //apparently fontastic reads the dots in a different order and therefore it 
    //flips the letter vertically
    DitherChar = getReversePImage(DitherChar);
    DitherChar.pixels = reverse(DitherChar.pixels);
    for (int y = 0; y < DitherChar.height; y++) {
      for (int x = 0; x < DitherChar.width; x++) {
        int i = x + DitherChar.width * y;
        //if the pixel is black we draw a square of points
        FontPoints = new PVector[4];//change this to have any other polygon up to a circle
        if (brightness(DitherChar.pixels[i]) < 50) {
          for (int j = 0; j < FontPoints.length; j++) {
            float angle = map(j, 0, FontPoints.length, 0 - PI/4, TWO_PI - PI/4);
            float xx = (x * scale) + (cos(angle) * scale / 1.3);
            float yy = (y * scale) + (sin(angle) * scale / 1.3);
            FontPoints[j] = new PVector(xx, yy);
          }
          ff.getGlyph(c).addContour(FontPoints);
        }
      }
    }
  }
  ff.buildFont();

  ff.cleanup();
}

public PImage getReversePImage( PImage image ) {
  PImage reverse = new PImage( image.width, image.height );
  for ( int i=0; i < image.width; i++ ) {
    for (int j=0; j < image.height; j++) {
      reverse.set( image.width - 1 - i, j, image.get(i, j) );
    }
  }
  return reverse;
}

//cp5 control event to set factor and the color of the gradient
void controlEvent(ControlEvent theControlEvent) {
  if (theControlEvent.isFrom("FACTOR")) {
    fac = theControlEvent.getController().getValue();
    d.setFactor(fac);
  }
  if (theControlEvent.isFrom("DEFAULT")) {    
    setDefaultValues();
  }
}
//sets back the default values
void setDefaultValues() {
  cp5.getController("pix1").setValue(7.0);
  cp5.getController("pix2").setValue(3.0);
  cp5.getController("pix3").setValue(5.0);
  cp5.getController("pix4").setValue(1.0);
  cp5.getController("FACTOR").setValue(16.0);
}
//initialize the cp5 controllers
void initControllers() {
  int w = 40, h = 25, top = 100;
  float sensitivity = 0.02;
  color black = color(0), grey = color(150), green = color(0, 255, 0);

  //kernel controllers
  cp5.addNumberbox("pix1")
    .setPosition(120, top)
    .setSize(w, h)
    .setScrollSensitivity(sensitivity)
    .setValue(7)
    .setColorBackground(grey)
    .setColorCaptionLabel(green);

  cp5.addNumberbox("pix2")
    .setPosition(20, top + 50)
    .setSize(w, h)
    .setScrollSensitivity(sensitivity)
    .setValue(3)
    .setColorBackground(grey)
    .setColorCaptionLabel(green);

  cp5.addNumberbox("pix3")
    .setPosition(70, top + 50)
    .setSize(w, h)
    .setScrollSensitivity(sensitivity)
    .setValue(5)
    .setColorBackground(grey)
    .setColorCaptionLabel(green);

  cp5.addNumberbox("pix4")
    .setPosition(120, top + 50)
    .setSize(w, h)
    .setScrollSensitivity(sensitivity)
    .setValue(1)
    .setColorBackground(grey)
    .setColorCaptionLabel(green);

  //factor controller
  cp5.addSlider("FACTOR")
    .setPosition(20, top + 100)
    .setRange(-10, 50)
    .setSize(200, 30)
    .setColorCaptionLabel(green)
    .setValue(16)
    .setColorForeground(grey)
    .setColorBackground(black)
    .setColorCaptionLabel(green);
  // default settings
  cp5.addButton("DEFAULT")
    .setValue(0)
    .setPosition(20, top + 150)
    .setSize(200, 19)
    .setColorForeground(grey)
    .setColorBackground(black)
    .setColorCaptionLabel(green);
  // make the font
  //cp5.addButton("MAKE_FONT")
  //  .setValue(0)
  //  .setPosition(20, top + 200)
  //  .setSize(200, 19)
  //  .setColorForeground(grey)
  //  .setColorBackground(black)
  //  .setColorCaptionLabel(green);
}

//THANKS TO
/**
 * Fontastic
 * A font file writer for Processing.
 * http://code.andreaskoller.com/libraries/fontastic 
 * @author      Andreas Koller http://andreaskoller.com
 */