import peasy.*;
PeasyCam cam;

PShader radialBlurGlobal, filmGrain, vignette;
ShatteredBox sbox;
MergingBoxGrid mgrid;
ShrinkBoxGrid sgrid;
CubeGrid cgrid;

void setup() {
  size(1280, 720, P3D);
  noStroke();
  rectMode(CENTER);
  cam = new PeasyCam(this, 400);
  float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
  perspective(PI/3.0, float(width)/float(height), cameraZ/100.0, cameraZ*10.0);

  radialBlurGlobal = loadShader("../RadialBlurGlobal/radialBlurGlobalFrag.glsl");
  radialBlurGlobal.set("resolution", float(width), float(height));

  filmGrain = loadShader("../FilmGrain/filmGrainFrag.glsl");
  filmGrain.set("resolution", float(width), float(height));

  vignette = loadShader("../Vignette/vignetteFrag.glsl");
  vignette.set("resolution", float(width), float(height));

  sbox = new ShatteredBox(80);
  mgrid = new MergingBoxGrid(50, 30, 7);
  sgrid = new ShrinkBoxGrid(50, 0, 9);
  cgrid = new CubeGrid(4, 50, 11);
}

void mousePressed() {
}
void keyPressed() {
  //sbox.init();
  //mgrid.init();
  //sgrid.init();
}

void draw() {
  background(0);

  cgrid.draw();
  radialBlurGlobal.set("mouse", float(width/4), float(height/3));
  radialBlurGlobal.set("NUM_SAMPLES", 99);
  radialBlurGlobal.set("rayLength", 0.14);
  radialBlurGlobal.set("intensity", 0.30);
  filter(radialBlurGlobal);

  //sgrid.draw();
  //radialBlurGlobal.set("mouse", float(width/2), float(height/2));
  //radialBlurGlobal.set("NUM_SAMPLES", 100);
  //radialBlurGlobal.set("rayLength", 0.15);
  //radialBlurGlobal.set("intensity", 0.25);
  //filter(radialBlurGlobal);

  //mgrid.draw();
  //radialBlurGlobal.set("mouse", float(width/2), float(height/2));
  //radialBlurGlobal.set("NUM_SAMPLES", 235);
  //radialBlurGlobal.set("rayLength", 0.88);
  //radialBlurGlobal.set("intensity", 0.68);
  //filter(radialBlurGlobal);

  //sbox.draw();
  //radialBlurGlobal.set("mouse", float(width/2), float(height/2));
  //radialBlurGlobal.set("NUM_SAMPLES", 100);
  //radialBlurGlobal.set("rayLength", 0.05);
  //radialBlurGlobal.set("intensity", 0.14);
  //filter(radialBlurGlobal);

  filmGrain.set("time", millis() * 0.01);
  filmGrain.set("strength", 50.0);
  filter(filmGrain);

  vignette.set("dist", 0.8 + noise(millis()*0.002) * 0.5);
  vignette.set("intensity", 1.0 );
  filter(vignette);
}
