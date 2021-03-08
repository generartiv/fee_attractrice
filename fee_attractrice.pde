

ParticuleSystem PS;

void setup() {
  size(1280, 720);
  PS = new ParticuleSystem();
  background(0);
}


void draw() {
  PS.run();
}

int getNumPixel(int x, int y) {
  return y * width + x;
}