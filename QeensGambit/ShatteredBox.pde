class ShatteredBox {

  int tick = 0;
  int baseTicks = 30;
  float flySpeed = 2.0;
  float[] waitingTime = new float[9];
  PVector[] boxPosition = new PVector[9];

  int boxScale, boxInitScale;
  float unitScale = 1.0;
  float deltaScale;
  float k;

  ShatteredBox(int scale) {
    boxInitScale = scale;
    boxScale = boxInitScale;
    // Exponential Scale
    k = log(3.0/1.0) / 240.0; // t = time - t1; T = t2-t1; k=Math.log(v2/v1) / T; scale = v1*Math.exp(k*t);
    init();
  }

  void update() {

    for (int i=0; i<9; i++) {
      waitingTime[i] -= 1;
    }

    for (int i=0; i<8; i++) {
      if (waitingTime[i] < 0) {
        PVector relativeVector = PVector.sub(boxPosition[i], boxPosition[8]);
        relativeVector.normalize();
        boxPosition[i].add(PVector.mult(relativeVector, flySpeed));
      }
    }
  }

  void draw() {
    background(0);

    update();
    //println(tick + "  " + unitScale);
    pushMatrix();
    if (waitingTime[8] > 0) {
      tick ++;
      // Exponential Scale
      unitScale = 1.0 * exp(k * tick);
    } else {
      init();
    }
    scale(unitScale);
    rotate(radians(millis()*0.01));
    for (int i=0; i<9; i++) {
      fill(150, waitingTime[i] > 0 ? 255 : (255 + waitingTime[i]*10));
      rect(boxPosition[i].x, boxPosition[i].y, boxScale, boxScale);
    }
    popMatrix();
  }

  void init() {
    tick = 0;
    unitScale = 1.0;

    for (int i=0; i<9; i++) {
      waitingTime[i] = baseTicks*(i);
    }

    boxPosition[0] = new PVector(-1.0 * boxInitScale, -1.0 * boxInitScale);
    boxPosition[1] = new PVector(0, -1.0 * boxInitScale);
    boxPosition[2] = new PVector(1.0 * boxInitScale, -1.0 * boxInitScale);
    boxPosition[3] = new PVector(1.0 * boxInitScale, 0);
    boxPosition[4] = new PVector(1.0 * boxInitScale, 1.0 * boxInitScale);
    boxPosition[5] = new PVector(0, 1.0 * boxInitScale);
    boxPosition[6] = new PVector(-1.0 * boxInitScale, 1.0 * boxInitScale);
    boxPosition[7] = new PVector(-1.0 * boxInitScale, 0);
    boxPosition[8] = new PVector(0, 0);
  }
}
