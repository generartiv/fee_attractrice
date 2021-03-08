class ParticuleSystem {
  PVector carteVelo[][];
  PVector carteVeloSuiv[][];
  ArrayList<Particule> particules = new ArrayList<Particule>();
  PVector attracteur = new PVector(width/2, height/2);

  float angleCible = 0;
  PVector cible;



  ParticuleSystem() {
    cible = new PVector(width/2, height/2);
    carteVelo = new PVector[width][height];
    carteVeloSuiv = new PVector[width][height];
    for (int x=0; x<width; x++) {
      for (int y=0; y<height; y++) {
        carteVelo[x][y] = new PVector(random(-1, 1), random(-1, 1));
        carteVelo[x][y].normalize();
      }
    }
  }

  void run() {

    angleCible += 0.00220;
    if (angleCible>TWO_PI) {
      angleCible -=TWO_PI;
    }
    cible.x = cos(angleCible) * height/4  + width/2;
    cible.y = sin(angleCible) * height/4  + height/2;

    loadPixels();
    for (int x=0; x<width; x++) {
      for (int y=0; y<height; y++) {
        int numPixel = getNumPixel(x, y);
        color c = pixels[numPixel];
        pixels[numPixel] = color(red(c)*0.995, green(c)*0.996, blue(c)*0.999);
        carteVeloSuiv[x][y] = carteVelo[x][y].copy();
      }
    }
    updatePixels();

    if (particules.size()<158 ) {
        particules.add(new Particule());
    }

     for (int x=0; x<width; x++) {
      for (int y=0; y<height; y++) {
        carteVeloSuiv[x][y] = carteVelo[x][y].copy();
      }
    }

    PVector v2cible = new PVector(0, 0);
    for (int i=1; i<particules.size(); i++) {
      Particule particuleTmp = particules.get(i);

      v2cible = PVector.sub(cible, particuleTmp.position);
      v2cible.normalize();

      carteVeloSuiv[floor(particuleTmp.position.x)][floor(particuleTmp.position.y)].lerp(v2cible, 0.33);
      carteVeloSuiv[floor(particuleTmp.position.x)][floor(particuleTmp.position.y)].lerp(particuleTmp.velo, 0.24);

      carteVeloSuiv[floor(particuleTmp.position.x)][floor(particuleTmp.position.y)].normalize();

      particuleTmp.velo.lerp(carteVelo[floor(particuleTmp.position.x)][floor(particuleTmp.position.y)], 0.57);
      particuleTmp.velo.normalize();
      particuleTmp.majPos();

      particuleTmp.display();
      if (particuleTmp.position.x<0 ||
        particuleTmp.position.x>width-1||
        particuleTmp.position.y<0 ||
        particuleTmp.position.y>height-1) {

        particules.remove(particuleTmp);
      } else if (PVector.dist(particuleTmp.position, cible)<2) {
        if (random(100)<49) {
          particuleTmp.init();
        } else {
          if (random(100)>54) {
            particuleTmp.init(particules.get(floor(random(particules.size()-1))));
          } else {
            particules.remove(particuleTmp);
          }
        }
      }
    }

    for (int x=0; x<width; x++) {
      for (int y=0; y<height; y++) {
        carteVelo[x][y] = carteVeloSuiv[x][y].copy();
      }
    }
  }
}