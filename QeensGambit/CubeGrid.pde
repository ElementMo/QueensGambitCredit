class CubeGrid {

  int cubeSize, gridGap, gridCount;

  CubeGrid(int cube_size, int grid_gap, int grid_count) {
    cubeSize = cube_size;
    gridGap = grid_gap; 
    gridCount = grid_count;
    init();
  }
  void init() {
  }

  void draw() {
    fill(100);
    for (int x=-floor(gridCount/2); x<=floor(gridCount/2); x++) {
      for (int y=-floor(gridCount/2); y<=floor(gridCount/2); y++) {
        for (int z=-floor(gridCount/2); z<=floor(gridCount/2); z++) {
          pushMatrix();
          translate(x * gridGap, y * gridGap, z * gridGap);
          box(cubeSize);
          popMatrix();
        }
      }
    }
  }
}
