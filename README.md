<h1>HELLO DITHER FONT</h1>
A <a href="https://processing.org">processing</a> tool to develop dithered fonts, based on <a href="https://github.com/adobe-fonts/source-code-pro">Source Code Pro</a>.
<h2>How it works</h2>
The application relies on two classes: `GradientLetter` and `Dither`.
The `GradientLetter` class uses the `geomerative` to get all the anchor points of a single character. Those points are than used as center for a radial gradient:<br>
<code>PImage gradientletter() {</code><br>
  <code>  RG.setPolygonizer(RG.ADAPTATIVE);</code><br>
  <code>  //grp.draw();</code><br>
  <code>  RG.setPolygonizer(RG.UNIFORMLENGTH);</code><br>
  <code>  float numberOfPoints = 1;// map(mouseX, 0, width, 1, 200);</code><br>
  <code>  RG.setPolygonizerLength(numberOfPoints);</code><br>
  <code>  points = grp.getPoints();</code><br>
<code>	// If there are any points</code><br>
 <code>   if (points != null) { </code><br>
 <code>     //here we turn the a char into a gradient</code><br>
 <code>     img.loadPixels();</code><br>
 <code>     fill(0);</code><br>
   <code>   stroke(0);</code><br>
   <code>   for (int y = 0; y < img.height; y++) {</code><br>
  <code>      for (int x=0; x < img.width; x++) {</code><br>
  <code>        int index = x + y * img.width;</code><br>
   <code>       float sum = 0;</code><br>
    <code>      //each point of the glyph is turned into a small radial gradient</code> <br>
  <code>        //that sums up with the neighbouring point/radial gradients</code><br>
 <code>         for (int i=0; i<points.length; i++) {</code><br>
  <code>          float d = dist(x, y, img.width * 0.4 + points[i].x, img.height * 0.7 + points[i].y);</code><br>
 <code>           if(d < 5)sum += 5 * r / pow(d, 2);</code><br>
 <code>           img.pixels[index] = color(255 - sum);</code><br>
   <code>       }</code><br>
   <code>     }</code><br>
  <code>    }</code><br>
  <code>    img.updatePixels();</code><br>
<code>    }</code><br>
 <code>   return img;</code><br>
 <code> }</code><br>
  This image is than loaded in the `Dither` class
<h2>Dependencies</h2>
<li><a href="http://www.ricardmarxer.com/geomerative/">Geomerative</a></li>
<li><a href="http://code.andreaskoller.com/libraries/fontastic/">Fontastic</a></li>
<li><a href="http://www.sojamo.de/libraries/controlP5/">Controlp5</a></li>
