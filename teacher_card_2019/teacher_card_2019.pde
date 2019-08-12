/*
 * Script per generare automaticamente le grafiche per i social di ALOUD 2019
 * by Federico Pepe
 * date: 09.08.2019
 * www.aloudverona.it
 */
color c;
color palette[] = {
  color(233, 83, 78), // Musica
  color(42, 178, 162), // Tech
  color(15, 167, 219), // Diplomi
  color(134, 110, 174), // Dizione
  color(252, 202, 51), // Progetti
};
// Creo un'IntList per creare le palette dei colori e per poterle riordinare
IntList colori = new IntList();

// File management
String path;
String[] filenames;

// Controls and positions
int avanzamento = 0;
int xPos = 0, yPos = 0;

void setup() {
  // BASIC SETUP
  background(255);
  size(600, 600);
  surface.setResizable(true);
  pixelDensity(2);
  // SET COLOR MODE
  colorMode(HSB, 360, 100, 100); 
  // SELECT THE INPUT FOLDER
  selectFolder("Select a folder to process:", "folderSelected");
  // DRAW INSTRUCTIONS
  fill(0);
  text("Istruzioni:\n\nR: Refresh\nN: Next\nP: Previous\nS: Save\nI: Formato Instagram (Verticale)\nF: Formato Facebook (Quadrato)\nFrecce: riposiziona l'immagine di sfonto\nColor: 1 Musica, 2 Tecnologia, 3 Diplomi, 4 Dizione, 5 Progetti\n\nOra premi R per cominciare", 50, 50);
  noFill(); 
  // CREATE THE FIRST COLOR PALETTE
  c = palette[0];
  changePalette();
}

void draw() {
}

void createImage() {
  if (filenames.length == 0 || avanzamento >= filenames.length) {
    exit();
  }
  println(width);
  println(height);
  background(255);
  PImage img;
  img = loadImage(path + filenames[avanzamento]);
  if (img.width > img.height) {
    img.resize(0, height + 200);
  } else {
    img.resize(width + 200, 0);
  }

  noStroke();
  image(img, xPos, yPos);
  fill(c);
  // IF WE HAVE A SQUARE IMAGE
  if (width == height) {
    // First rect
    rect(0, 0, width/2, height/2);
    // Second rect
    if (random(1) >= 0.5) {
      fill(getColor(random(colori.size())));
      rect(0, height/2, width/4, height/4);
      fill(getColor(random(colori.size())));
      rect(width/4, height/2 + height/4, width/4, height/4);
    } else {
      fill(getColor(random(colori.size())));
      rect(width/4, height/2, width/4, height/4);
      fill(getColor(random(colori.size())));
      rect(0, height/2 + height/4, width/4, height/4);
    }
    // Last rect
    for (int i = 0; i < 4; i++) {
      colori.shuffle();
      for (int j = 0; j < 4; j++) {
        if (random(1) > 0.5) {
          fill(colori.get(j));
          rect(width/2 + (width/8*j), height/2 + (height/8*i), width/8, height/8);
        }
      }
    }
  } else {
    for (int i = 0; i < 4; i++) {
      colori.shuffle();
      for (int j = 0; j < 4; j++) {
        if (random(1) > 0.5) {
          fill(colori.get(j));
          rect(0 + (width/4*j), height/2 + (height/8*i), width/4, height/8);
        }
      }
    }
  }
}

void keyPressed() {
  // Palette
  if (key == '1') {
    c = palette[0];
    changePalette();
  }
  if (key == '2') {
    c = palette[1];
    changePalette();
  }
  if (key == '3') {
    c = palette[2];
    changePalette();
  }
  if (key == '4') {
    c = palette[3];
    changePalette();
  }
  if (key == '5') {
    c = palette[4];
    changePalette();
  }
  // Refresh
  if (key == 'r') {
    createImage();
  }
  // Previous
  if (key == 'p') {
    if (avanzamento > 0) {
      avanzamento--;
      background(0);
      createImage();
    } else {
      exit();
    }
  }
  // Next
  if (key == 'n') {
    if (avanzamento < filenames.length) {
      avanzamento++;
      background(0);
      createImage();
      xPos = 0;
      yPos = 0;
    } else {
      exit();
    }
  }
  // Save
  if (key == 's') {
    saveFrame(sketchPath()+"/output/" + width*2 + "_" + height*2+"_"+ filenames[avanzamento]);
  }
  if (key == 'i') { 
    surface.setSize(270, 480);
  }
  if (key == 'f') {
    surface.setSize(600, 600);
  }
  // MOVE BACKGROUND IMAGE
  if (key == CODED) {
    if (keyCode == UP) {
      yPos -= 50;
      createImage();
    } else if (keyCode == DOWN) {
      yPos += 50;
      createImage();
    }
    if (keyCode == LEFT) {
      xPos -= 50;
      createImage();
    } else if (keyCode == RIGHT) {
      xPos += 50;
      createImage();
    }
  }
}

color getColor(float _i) {
  int i = round(_i);
  if (i >= colori.size()) {
    i = 0;
  }
  return colori.get(i);
}

void changePalette() {
  colori.clear();
  for (int i = 0; i < 4; i++) {
    color c1 = color(hue(c), saturation(c) - (10*i), brightness(c));
    colori.append(c1);
  }
}

// SELECT FOLDER
void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    path = selection.getAbsolutePath() + "/";
    filenames = listFileNames(path);
    if (filenames.length == 0) {
      exit();
    } else {
      createImage();
    }
  }
}
