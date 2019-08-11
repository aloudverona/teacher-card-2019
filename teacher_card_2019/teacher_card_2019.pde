/*
 * Script per generare automaticamente le grafiche per i social di ALOUD 2019
 * by Federico Pepe
 * date: 09.08.2019
 * www.aloudverona.it
*/
PGraphics alphaG;

int interations = 0;
// MUSICA:
// color c = color(233, 83, 78);
// TECH:
color c = color(42, 178, 162);
// COLOR
IntList colori = new IntList();

void setup() {
  background(255);
  size(600, 600);
  colorMode(HSB, 360, 100, 100);
  alphaG = createGraphics(width, height, JAVA2D);
  for (int i = 0; i < 4; i++) {
    color c1 = color(hue(c), saturation(c) - (10*i), brightness(c));
    colori.append(c1);
  }
}

void draw() {
  for (int inter = 0; inter <= interations; inter++) {
    alphaG.beginDraw();
    alphaG.noStroke();
    alphaG.fill(colori.get(0));
    // First rect
    alphaG.rect(0, 0, width/2, height/2);
    // Second rect
    if (random(1) >= 0.5) {
      alphaG.fill(getColor(random(colori.size())));
      alphaG.rect(0, height/2, width/4, height/4);
      alphaG.fill(getColor(random(colori.size())));
      alphaG.rect(width/4, height/2 + height/4, width/4, height/4);
    } else {
      alphaG.fill(getColor(random(colori.size())));
      alphaG.rect(width/4, height/2, width/4, height/4);
      alphaG.fill(getColor(random(colori.size())));
      alphaG.rect(0, height/2 + height/4, width/4, height/4);
    }
    // Last rect
    for (int i = 0; i < 4; i++) {
      colori.shuffle();
      for (int j = 0; j < 4; j++) {
        if (random(1) > 0.5) {
          alphaG.fill(colori.get(j));
          alphaG.rect(width/2 + (width/8*j), height/2 + (height/8*i), width/8, height/8);
        }
      }
    }
    alphaG.endDraw();
    image(alphaG, 0, 0);
    alphaG.save("images/"+inter + ".png");
    alphaG.clear();
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
