PShader vignette;

void setup() {
  size(800, 500, P3D);
  vignette = loadShader("vignetteFrag.glsl");
  vignette.set("resolution", float(width), float(height));
}

void draw() {
  background(255);
  vignette.set("dist", 1.3);
  vignette.set("intensity", 1.5);

  filter(vignette);
}
