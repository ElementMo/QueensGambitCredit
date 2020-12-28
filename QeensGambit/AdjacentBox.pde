class AdjacentBox {
  int boxCount = 7;
  float boxSize = 150;
  PVector[] boxPos;
  PVector[] boxPosLerp;

  AdjacentBox () {
    boxPos = new PVector[boxCount];
    boxPosLerp = new PVector[boxCount];
    boxPos[0] = new PVector();

    init(1, -1, 1, 1);

    for (int i=0; i<boxCount; i++) {
      boxPosLerp[i] = boxPos[i].copy();
    }
  }

  void init(int signX, int signY, int zigzagX, int zigzagY) {

    float box_gap_x = 0, box_gap_y = 0;
    for (int i=1; i<boxCount; i++) {
      box_gap_x += pow(zigzagX, i-1) * ( boxSize / pow(2, i-1) / 2 + boxSize / pow(2, i) / 2 );
      box_gap_y += pow(zigzagY, i-1) * ( boxSize / pow(2, i-1) / 2 + boxSize / pow(2, i) / 2 );
      boxPos[i] = new PVector(signX * box_gap_x, signY * box_gap_y);
    }
  }

  void update() {
    int shiftTicks = 25;
    if (frameCount == shiftTicks * 1) {
      init(1, -1, 1, 1);
    }
    if (frameCount == shiftTicks * 2) {
      init(1, 1, 1, -1);
    } 
    if (frameCount == shiftTicks * 3) {
      init(1, 1, 1, 1);
    } 
    if (frameCount == shiftTicks * 4) {
      init(-1, 1, -1, 1);
    }  
    if (frameCount == shiftTicks * 5) {
      init(-1, 1, 1, 1);
    }  
    if (frameCount == shiftTicks * 6) {
      init(-1, -1, 1, -1);
    }  
    if (frameCount == shiftTicks * 7) {
      init(-1, -1, 1, 1);
    }  
    if (frameCount == shiftTicks * 8) {
      init(1, -1, -1, 1);
      frameCount = 0;
    } 

    for (int i=0; i<boxCount; i++) {
      boxPosLerp[i] = PVector.lerp(boxPosLerp[i], boxPos[i], 0.25);
    }
  }

  void draw() {
    background(0);
    noFill();
    stroke(255);

    update();

    for (int i=0; i<boxCount; i++) {
      rect(boxPosLerp[i].x, boxPosLerp[i].y, boxSize / pow(2, i), boxSize / pow(2, i));
    }
  }
}
