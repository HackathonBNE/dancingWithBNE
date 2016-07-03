void consejo(PImage fondo, PImage personaje, PImage score) {
  background(fondo);
  tint(255, 255);
  image (personaje, .95 * width - personaje.width, height - personaje.height);
  image (score, .05 * width + personaje.width * .25, height * .65);
 
}
