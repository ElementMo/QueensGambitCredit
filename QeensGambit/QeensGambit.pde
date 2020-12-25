import peasy.*;
PeasyCam cam;
PShader radialBlurGlobal, filmGrain, vignette;
ShatteredBox sbox;
MergingBoxGrid mbox;

void setup() {
  size(1280, 720, P3D);
  noStroke();
  rectMode(CENTER);
  cam = new PeasyCam(this, 500);

  radialBlurGlobal = loadShader("../RadialBlurGlobal/radialBlurGlobalFrag.glsl");
  radialBlurGlobal.set("resolution", float(width), float(height));

  filmGrain = loadShader("../FilmGrain/filmGrainFrag.glsl");
  filmGrain.set("resolution", float(width), float(height));

  vignette = loadShader("../Vignette/vignetteFrag.glsl");
  vignette.set("resolution", float(width), float(height));

  sbox = new ShatteredBox(80);
  mbox = new MergingBoxGrid(50, 50);
}

void mousePressed() {
  //mbox.init();
}
void keyPressed() {
  mbox.init();
}

void draw() {
  background(0);

  //rect(mouseX, mouseY, 534, 162);

  mbox.draw();
  radialBlurGlobal.set("mouse", float(width/2), float(height/2));
  radialBlurGlobal.set("NUM_SAMPLES", 235);
  radialBlurGlobal.set("rayLength", 0.88);
  radialBlurGlobal.set("intensity", 0.68);
  filter(radialBlurGlobal);

  //sbox.draw();
  //radialBlurGlobal.set("mouse", float(width/2), float(height/2));
  //radialBlurGlobal.set("NUM_SAMPLES", 100);
  //radialBlurGlobal.set("rayLength", 0.05);
  //radialBlurGlobal.set("intensity", 0.14);
  //filter(radialBlurGlobal);

  filmGrain.set("time", millis() * 0.01);
  filmGrain.set("strength", 50.0);
  filter(filmGrain);

  vignette.set("dist", 1.4 + noise(millis()*0.002) * 0.5);
  vignette.set("intensity", 0.7 );
  filter(vignette);
}
