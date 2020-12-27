class ShrinkBoxGrid extends MergingBoxGrid {

  ShrinkBoxGrid(int box_size, int gap, int grid_count) {
    super(box_size, gap, grid_count);
    init();
  }

  void init() {
    gridGap = initBoxSize + initGridGap;
    boxSize = initBoxSize;
    maxTick = 200;
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
      targetRotation[i] = random(1)>0.5 ? PI/2 : -PI/2;
      targetScale[i] = 1;
    }
  }


  void update() {
    if (true) {
      gridGap -= deltaGap;

      int index = 0;
      for (int x=-floor(gridSize/2); x<=floor(gridSize/2); x++) {
        for (int y=-floor(gridSize/2); y<=floor(gridSize/2); y++) {
          if (dist(0, 0, x, y) > map((tick+0), maxTick*0.4, maxTick*0.7, 0, floor(gridSize/2))) {
            targetRotation[index] = lerp(targetRotation[index], 0, 0.04);
            targetScale[index] = lerp(targetScale[index], 0.50, 0.04);
          }
          index ++;
        }
      }
    }
    tick --;
  }

  void draw() {
    background(0);
    update();

    fill(100);
    pushMatrix();
    scale(1.0, 0.7);
    int index = 0;
    for (int x=-floor(gridSize/2); x<=floor(gridSize/2); x++) {
      for (int y=-floor(gridSize/2); y<=floor(gridSize/2); y++) {
        pushMatrix();
        translate(x*gridGap, y*gridGap);

        rotate(targetRotation[index]);
        scale(targetScale[index]);

        rect(0, 0, boxSize, boxSize);
        popMatrix();
        index ++;
      }
    }
    popMatrix();
  }
}
