<h1>HELLO DITHER FONT</h1>
<img src="https://user-images.githubusercontent.com/17408277/32441002-dcba07ba-c2f5-11e7-85a9-105228cfc045.png"><br>
A <a href="https://processing.org">processing</a> tool to develop dithered fonts, based on <a href="https://github.com/adobe-fonts/source-code-pro">Source Code Pro</a>.
<h2>How it works</h2>
The application relies on two classes: <code>GradientLetter</code> and <code>Dither</code>.
The <code>GradientLetter</code> class uses the geomerative to get all the anchor points of a single character. Those points are than used as center for a radial gradient, and it generates such letterforms<br>
<img src="https://user-images.githubusercontent.com/17408277/32440985-c9deedea-c2f5-11e7-8b42-9c686258f337.png">
This image is than loaded in the <code>Dither</code> class that outputs a dithered letterform, like this:<br>
<img src="https://user-images.githubusercontent.com/17408277/32441258-1897921a-c2f7-11e7-9836-0f06eb04580b.png" style="height:100px; width: auto;"><br>
the menu on the left side lets you scramble with the dither.<br>
You can change how the four neighbouring pixels are recalculated, by changing the values in the four boxes. The bar at the bottom calculates by which amount the previous changed values need to be divided by.
<h2>References</h2>
<li><a href="https://en.wikipedia.org/wiki/Dither">Dither</a> @Wikipedia</li>
<li><a href="http://www.efg2.com/Lab/Library/ImageProcessing/DHALF.TXT">DITHER.TXT</a> by Lee Daniel Crooker. An interesting text about dithering and halftoning algorithms</li>
<li><a href="http://cv.ulichney.com/papers/1993-void-cluster.pdf">The Void-and-Cluster Method for Dither Array Generation</a> a paper about dither by Robert Ulichney</li>
<li><a href="http://danieltemkin.com/DitherStudies/About">Dither Studies</a> by Daniel Temkin. And his <a href="http://danieltemkin.com/DitherStudies/">Dither Web App</a></li>
<h2>Dependencies</h2>
<li><a href="http://www.ricardmarxer.com/geomerative/">Geomerative</a></li>
<li><a href="http://code.andreaskoller.com/libraries/fontastic/">Fontastic</a></li>
<li><a href="http://www.sojamo.de/libraries/controlP5/">Controlp5</a></li>
