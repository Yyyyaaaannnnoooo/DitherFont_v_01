<h1>HELLO DITHER FONT</h1>
A <a href="https://processing.org">processing</a> tool to develop dithered fonts, based on <a href="https://github.com/adobe-fonts/source-code-pro">Source Code Pro</a>.
<h2>How it works</h2>
The application relies on two classes: `GradientLetter` and `Dither`.
The `GradientLetter` class uses the `geomerative` to get all the anchor points of a single character. Those points are than used as center for a radial gradient:<br>
<code>PImage gradientletter() {</code><br>
<code>for (int i=0; i<points.length; i++) {</code><br>
<code>float d = dist(x, y, img.width * 0.4 + points[i].x, img.height * 0.7 + points[i].y);</code><br>
<code>if(d < 5)sum += 5 * r / pow(d, 2);</code><br>
<code>img.pixels[index] = color(255 - sum);</code><br>
<code>}</code><br>
  This image is than loaded in the `Dither` class
<h2>Dependencies</h2>
<li><a href="http://www.ricardmarxer.com/geomerative/">Geomerative</a></li>
<li><a href="http://code.andreaskoller.com/libraries/fontastic/">Fontastic</a></li>
<li><a href="http://www.sojamo.de/libraries/controlP5/">Controlp5</a></li>
