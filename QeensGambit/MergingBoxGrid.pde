class MergingBoxGrid {
  int gridSize;
  PVector[] initPosition = new PVector[gridSize*gridSize];
  float[] targetRotation = new float[gridSize*gridSize];
  float[] targetScale = new float[gridSize*gridSize];
  int initGridGap, initBoxSize;
  float gridGap, boxSize;
  float deltaGap;
  int maxTick, tick;

  MergingBoxGrid(int size, int gap, int grid_count) {
    initGridGap = gap;
    initBoxSize = size;
    gridSize = grid_count;

    initPosition = new PVector[gridSize*gridSize];
    targetRotation = new float[gridSize*gridSize];
    targetScale = new float[gridSize*gridSize];

    init();
  }

  void init() {

    gridGap = initBoxSize + initGridGap;
    boxSize = initBoxSize;
    maxTick = 190;
    tick = maxTick;
    deltaGap = (initGridGap) / float(maxTick);

    int index = 0;
    for (int x=-floor(gridSize/2); x<=floor(gridSize/2); x++) {
      for (int y=-floor(gridSize/2); y<=floor(gridSize/2); y++) {
        initPosition[index] = new PVector(x*(boxSize+gridGap), y*(boxSize+gridGap));
        index ++;
      }
    }
    for (int i=0; i<gridSize*gridSize; i++) {
      targetRotation[i] = random(-PI/4, PI/4);
      targetScale[i] = random(0.3, 0.5);
    }
  }

  void update() {
    if (tick > 0) {
      gridGap -= deltaGap;
      for (int i=0; i<gridSize*gridSize; i++) {
        targetRotation[i] = lerp(targetRotation[i], 0, 0.025);
        targetScale[i] = lerp(targetScale[i], 1.01, 0.025);
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
    for (int x=-floor(gridSize/2); x<=floor(gridSize/2); x++) {
      for (int y=-floor(gridSize/2); y<=floor(gridSize/2); y++) {
        pushMatrix();
        translate(x*gridGap, y*gridGap);
        if (x!=0 || y!=0) {
          rotate(targetRotation[index]);
          scale(targetScale[index]);
        }
        rect(0, 0, boxSize, boxSize);
        popMatrix();
        index ++;
      }
    }
    popMatrix();
  }
}
