
PShader fragment;

void setup() {
  size(500, 500, P3D);
  rectMode(CENTER);
  noStroke();
  fragment = loadShader("filmGrainFrag.glsl");
  fragment.set("resolution", float(width), float(height));
}

void draw() {
  background(0);  
  fragment.set("time", millis() * 0.01);
  fragment.set("strength", 50.0);

  rect(mouseX, mouseY, 100, 100);

  filter(fragment);
}
