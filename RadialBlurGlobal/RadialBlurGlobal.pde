import peasy.*;

PeasyCam cam;
PShader radialBlurGlobal, filmGrain, vignette;

void setup() {
  size(800, 500, P3D);
  cam = new PeasyCam(this, 500);
  noStroke();
  rectMode(CENTER);
  radialBlurGlobal = loadShader("radialBlurGlobalFrag.glsl");
  radialBlurGlobal.set("resolution", float(width), float(height));

  filmGrain = loadShader("../FilmGrain/filmGrainFrag.glsl");
  filmGrain.set("resolution", float(width), float(height));

  vignette = loadShader("../Vignette/vignetteFrag.glsl");
  vignette.set("resolution", float(width), float(height));
}

void draw() {
  background(150);
  radialBlurGlobal.set("mouse", float(mouseX), float(height-mouseY));
  radialBlurGlobal.set("NUM_SAMPLES", 298);
  radialBlurGlobal.set("rayLength", 0.85);
  radialBlurGlobal.set("intensity", 0.3);

  fill(0);
  int gap = 76;
  int size = 70;
  pushMatrix();
  //translate(width/2, height/2);
  for (int x=-3; x<=3; x++) {
    for (int y=-3; y<=3; y++) {
      pushMatrix();
      translate(x*gap, y*gap);
      rotate(radians(x + y)*360);
      rect(0, 0, size, size);
      popMatrix();
    }
  }
  popMatrix();


  filter(radialBlurGlobal);

  filmGrain.set("time", millis() * 0.01);
  filmGrain.set("strength", 50.0);
  filter(filmGrain);

  vignette.set("dist", 1.4 + noise(millis()*0.002) * 0.5);
  vignette.set("intensity", 1.5 );
  filter(vignette);
}
