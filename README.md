<h1>HELLO DITHER FONT</h1>
A <a href="https://processing.org">processing</a> tool to develop dithered fonts, based on <a href="https://github.com/adobe-fonts/source-code-pro">Source Code Pro</a>.
<h2>How it works</h2>
The application relies on two classes: `GradientLetter` and `Dither`.
The `GradientLetter` class uses the `geomerative` to get all the anchor points of a single character. Those points are than used as center for a radial gradient:<br>
<code>PImage gradientletter() {<br>
    RG.setPolygonizer(RG.ADAPTATIVE);<br>
    //grp.draw();<br>
    RG.setPolygonizer(RG.UNIFORMLENGTH);<br>
    float numberOfPoints = 1;// map(mouseX, 0, width, 1, 200);<br>
    RG.setPolygonizerLength(numberOfPoints);<br>
    points = grp.getPoints();<br>
	// If there are any points<br>
    if (points != null) { <br>
      //here we turn the a char into a gradient<br>
      img.loadPixels();<br>
      fill(0);<br>
      stroke(0);
      for (int y = 0; y < img.height; y++) {<br>
        for (int x=0; x < img.width; x++) {<br>
          int index = x + y * img.width;<br>
          float sum = 0;<br>
          //each point of the glyph is turned into a small radial gradient <br>
          //that sums up with the neighbouring point/radial gradients<br>
          for (int i=0; i<points.length; i++) {<br>
            float d = dist(x, y, img.width * 0.4 + points[i].x, img.height * 0.7 + points[i].y);<br>
            if(d < 5)sum += 5 * r / pow(d, 2);<br>
            img.pixels[index] = color(255 - sum);<br>
          }<br>
        }<br>
      }<br>
      img.updatePixels();<br>
    }<br>
    return img;<br>
  }</code><br>
  This image is than loaded in the `Dither` class
<h2>Dependencies</h2>
<li><a href="http://www.ricardmarxer.com/geomerative/">Geomerative</a></li>
<li><a href="http://code.andreaskoller.com/libraries/fontastic/">Fontastic</a></li>
<li><a href="http://www.sojamo.de/libraries/controlP5/">Controlp5</a></li>
