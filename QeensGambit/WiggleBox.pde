class WiggleBox {
  ArrayList<PVector> boxTail, box2Tail;
  int tailLen = 5;

  WiggleBox() {
    background(0);
    boxTail = new ArrayList<PVector>();
    box2Tail = new ArrayList<PVector>();
    for (int i=0; i<tailLen; i++) {
      boxTail.add(new PVector(0, 0));
      box2Tail.add(new PVector(0, 0));
    }
  }

  void update(PVector new_pos, PVector box2_new_pos) {
    for (int i=0; i<tailLen - 1; i++) {
      boxTail.get(i).x = boxTail.get(i+1).x;
      boxTail.get(i).y = boxTail.get(i+1).y;

      box2Tail.get(i).x = box2Tail.get(i+1).x;
      box2Tail.get(i).y = box2Tail.get(i+1).y;
    }
    boxTail.get(boxTail.size()-1).set(new_pos);
    box2Tail.get(box2Tail.size()-1).set(box2_new_pos);
  }
  void draw() {
    background(0);
    // box1 noise position
    float noise_pos = millis()*0.005;
    float noise_scale = 249;
    PVector newPos = new PVector((noise(noise_pos)-0.5)*noise_scale, (noise(noise_pos+100)-0.5)*noise_scale);
    newPos.add(new PVector(10, -31));

    // box2 noise position
    float box2_noise_pos = millis()*0.006;
    float box2_noise_scale = 157;
    PVector box2_newPos = new PVector((noise(box2_noise_pos)-0.5)*box2_noise_scale, (noise(box2_noise_pos+100)-0.5)*box2_noise_scale);
    box2_newPos.add(new PVector(-273, 134));

    update(newPos, box2_newPos);

    drawMotionBlur(boxTail, 200);
    drawMotionBlur(box2Tail, 100);
  }

  void drawMotionBlur(ArrayList<PVector> array, int boxSize) {
    for (int i=1; i<array.size(); i++) {
      PVector tailPos = array.get(i);
      PVector ptailPos = array.get(i-1);

      // Motion blur
      PVector relativeV = PVector.sub(tailPos, ptailPos);
      float dist = PVector.dist(tailPos, ptailPos);
      for (float j=0; j<=dist; j+=1) {
        PVector interpolate = PVector.add(tailPos, PVector.mult(relativeV, j/dist));
        fill(255, 10);
        rect(interpolate.x, interpolate.y, boxSize, boxSize);
      }
    }
  }
}
