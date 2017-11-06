<h1>HELLO DITHER FONT</h1>
<img src="https://user-images.githubusercontent.com/17408277/32441002-dcba07ba-c2f5-11e7-85a9-105228cfc045.png"><br>
A <a href="https://processing.org">processing</a> tool to develop dithered fonts, based on <a href="https://github.com/adobe-fonts/source-code-pro">Source Code Pro</a>.
<h2>How it works</h2>
The application relies on two classes: `GradientLetter` and `Dither`.
The `GradientLetter` class uses the `geomerative` to get all the anchor points of a single character. Those points are than used as center for a radial gradient, and it generates such letterforms<br>
<img src="https://user-images.githubusercontent.com/17408277/32440985-c9deedea-c2f5-11e7-8b42-9c686258f337.png">
  This image is than loaded in the `Dither` class that outputs a dithered letterform, like this:<br>
  <img src="https://user-images.githubusercontent.com/17408277/32441258-1897921a-c2f7-11e7-9836-0f06eb04580b.png">
<h2>Dependencies</h2>
<li><a href="http://www.ricardmarxer.com/geomerative/">Geomerative</a></li>
<li><a href="http://code.andreaskoller.com/libraries/fontastic/">Fontastic</a></li>
<li><a href="http://www.sojamo.de/libraries/controlP5/">Controlp5</a></li>
