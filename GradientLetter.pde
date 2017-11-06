class GradientLetter {
  String word;
  PImage img;
  int r = 5;
  GradientLetter(String _word) {
    word = _word;
    //initialize image
    img = createImage(40, 58, RGB);
    setChar(word);
  }
  void setChar(String s){
  grp = RG.getText(s, "SourceCodePro-ExtraLight.ttf", 40, CENTER);
  }
  PImage gradientletter() {
    RG.setPolygonizer(RG.ADAPTATIVE);
    //grp.draw();
    RG.setPolygonizer(RG.UNIFORMLENGTH);
    float numberOfPoints = 1;// map(mouseX, 0, width, 1, 200);
    RG.setPolygonizerLength(numberOfPoints);
    points = grp.getPoints();

    // If there are any points
    if (points != null) { 
      //here we turn the a char into a gradient
      img.loadPixels();
      fill(0);
      stroke(0);
      for (int y = 0; y < img.height; y++) {
        for (int x=0; x < img.width; x++) {
          int index = x + y * img.width;
          float sum = 0;
          //each point of the glyph is turned into a small radial gradient 
          //that sums up with the neighbouring point/radial gradients
          for (int i=0; i<points.length; i++) {
            float d = dist(x, y, img.width * 0.4 + points[i].x, img.height * 0.7 + points[i].y);
            if(d < 5)sum += 5 * r / pow(d, 2);
            img.pixels[index] = color(255 - sum);
          }
        }
      }
      img.updatePixels();
    }
    return img;
  }
}