class Particule {
  PVector position;
  PVector positionInit;
  PVector velo;
 
  Particule() {
    positionInit = new PVector(random(width-1), random(height-1));
    init();
  }

  void init() {
    position = positionInit.copy();
    velo = new PVector(0, 0);
    }

  void init(Particule particuleCopy) {
    positionInit = particuleCopy.position.copy();
    position = positionInit.copy();
    
    //velo = particuleCopy.velo.copy();
    velo = new PVector(0, 0);
   }

  void majPos() {
    position.add(velo);
  }

  void display() {
    //float a = 67 + age * ageMax/172;
    float alpha = 255 - pow(PVector.dist(position, PS.cible), 3) * 255/(pow(width, 3));
    if (alpha<0) {
      alpha  = 0;
    } else if (alpha>255) {
      alpha = 255;
    }
    stroke(255, alpha/115);
    strokeWeight(86 - alpha/3);
    point(position.x, position.y);
    stroke(255,alpha);
    strokeWeight(1);
    point(position.x, position.y);
  }
}
