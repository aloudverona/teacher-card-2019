/*
 * Script per generare automaticamente le grafiche per i social di ALOUD 2019
 * by Federico Pepe
 * date: 09.08.2019
 * www.aloudverona.it
 */
PGraphics outputImage;

// MUSICA:
color c = color(233, 83, 78);
// TECH:
//color c = color(42, 178, 162);
// Creo un'IntList per creare le palette dei colori e per poterle riordinare
IntList colori = new IntList();

// File management
String path;
String[] filenames;

void setup() {
  background(255);
  size(1200, 1200);
  colorMode(HSB, 360, 100, 100);
  outputImage = createGraphics(width, height, JAVA2D);
  for (int i = 0; i < 4; i++) {
    color c1 = color(hue(c), saturation(c) - (10*i), brightness(c));
    colori.append(c1);
  }
  // READ FILES IN THE DIRECTORY
  path = sketchPath() + "/input/";
  filenames = listFileNames(path);
  printArray(filenames);
}

void draw() {
  if(filenames.length == 0) {
    exit();
  }
  //for (int inter = 0; inter <= interations; inter++) {
  for (int inter = 0; inter < filenames.length; inter++) {
    PImage img;
    img = loadImage(path + filenames[inter]);
    if(img.width > img.height) {
      img.resize(0, height);
    } else {
      img.resize(width, 0);
    }
    outputImage.beginDraw();
    outputImage.noStroke();
    outputImage.image(img, 0, 0);
    outputImage.fill(colori.get(0));
    // First rect
    outputImage.rect(0, 0, width/2, height/2);
    // Second rect
    if (random(1) >= 0.5) {
      outputImage.fill(getColor(random(colori.size())));
      outputImage.rect(0, height/2, width/4, height/4);
      outputImage.fill(getColor(random(colori.size())));
      outputImage.rect(width/4, height/2 + height/4, width/4, height/4);
    } else {
      outputImage.fill(getColor(random(colori.size())));
      outputImage.rect(width/4, height/2, width/4, height/4);
      outputImage.fill(getColor(random(colori.size())));
      outputImage.rect(0, height/2 + height/4, width/4, height/4);
    }
    // Last rect
    for (int i = 0; i < 4; i++) {
      colori.shuffle();
      for (int j = 0; j < 4; j++) {
        if (random(1) > 0.5) {
          outputImage.fill(colori.get(j));
          outputImage.rect(width/2 + (width/8*j), height/2 + (height/8*i), width/8, height/8);
        }
      }
    }
    outputImage.endDraw();
    image(outputImage, 0, 0);
    outputImage.save("output/"+ filenames[inter]);
    outputImage.clear();
  }
  exit();
}

color getColor(float _i) {
  int i = round(_i);
  if (i >= colori.size()) {
    i = 0;
  }
  return colori.get(i);
}
