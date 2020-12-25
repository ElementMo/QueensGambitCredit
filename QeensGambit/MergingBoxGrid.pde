class MergingBoxGrid {

  PVector[] initPosition = new PVector[49];
  float[] seperatedRotation = new float[49];
  float[] seperatedScale = new float[49];
  float[] deltaRotation = new float[49];
  float[] deltaScale = new float[49];
  int initGridGap, initBoxSize;
  float gridGap, boxSize;
  float deltaGap;
  int maxTick, tick;

  MergingBoxGrid(int size, int gap) {
    initGridGap = gap;
    initBoxSize = size;

    init();
  }

  void init() {
    gridGap = initBoxSize + initGridGap;
    boxSize = initBoxSize;
    maxTick = 190;
    tick = maxTick;
    deltaGap = (gridGap - initGridGap) / float(maxTick);

    int index = 0;
    for (int x=-3; x<=3; x++) {
      for (int y=-3; y<=3; y++) {
        initPosition[index] = new PVector(x*gridGap, y*gridGap);
        index ++;
      }
    }
    for (int i=0; i<49; i++) {
      seperatedRotation[i] = random(-PI/4, PI/4);
      seperatedScale[i] = random(0.3, 0.7);
      deltaRotation[i] = seperatedRotation[i] / maxTick;
      deltaScale[i] = (1 - seperatedScale[i]) / maxTick;
    }
  }

  void update() {
    //println(gridGap);
    if (tick > 0) {
      gridGap -= deltaGap;
      for (int i=0; i<49; i++) {
        //seperatedRotation[i] -= deltaRotation[i];
        //seperatedScale[i] += deltaScale[i];
        seperatedRotation[i] = lerp(seperatedRotation[i], 0, 0.025);
        seperatedScale[i] = lerp(seperatedScale[i], 1.01, 0.025);
      }
    } else {
      //init();
    }
    tick --;
  }

  void draw() {
    background(150);
    update();

    fill(0);
    pushMatrix();
    int index = 0;
    for (int x=-3; x<=3; x++) {
      for (int y=-3; y<=3; y++) {
        pushMatrix();
        translate(x*gridGap, y*gridGap);
        if (x!=0 || y!=0) {
          rotate(seperatedRotation[index]);
          scale(seperatedScale[index]);
        }
        rect(0, 0, boxSize, boxSize);
        popMatrix();
        index ++;
      }
    }
    popMatrix();
  }
}
