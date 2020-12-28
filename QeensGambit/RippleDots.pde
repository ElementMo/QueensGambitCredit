class RippleDots {
  PGraphics pg;
  float rippleWidth;
  float rippleRange;
  int rippleCount;

  RippleDots(float _rippleWidth, float _rippleRange) {

    rippleWidth = _rippleWidth;
    rippleRange = _rippleRange;
    rippleCount = int(rippleRange / rippleWidth);

    pg = createGraphics((int)rippleRange, (int)rippleRange);
    pg.beginDraw();
    pg.noStroke();
    pg.endDraw();
  }

  void draw() {
    // Draw base image
    pg.beginDraw();
    pg.background(0);
    for (int i=rippleCount; i>0; i--) {
      float grayScale = sin(map(i + millis()*-0.02, 0, rippleCount, 0, PI*4))*0.6 + 0.5;
      pg.fill(grayScale * 255);
      pg.ellipse(rippleRange/2, rippleRange/2, i*rippleWidth, i*rippleWidth);
    }
    pg.endDraw();
    //image(pg, 0, 0);

    // Draw Dots
    PImage base_img = new PImage(pg.getImage());
    int gap = 4;
    for (int x=0; x<=rippleRange; x+=gap) {
      for (int y=0; y<=rippleRange; y+=gap) {
        if (random(255) < brightness(base_img.get(x, y))) {
          ellipse(x, y, 2.5, 2.5);
        }
      }
    }
  }
}
