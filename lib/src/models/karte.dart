part of ImmunityTD;

class Karte {
  List<List<Position>> wege;
  List<Feld> felder;
}

class Feld {
  int x;
  int y;
  int typ;

  Feld(int x, int y, int typ) {
    this.x = x;
    this.y = y;
    this.typ = typ;
  }

  int getX() {
    return x;
  }

  void setX(int x) {
    this.x = x;
  }

  int getY() {
    return y;
  }

  void setY(int y) {
    this.y = y;
  }

  int getTyp() {
    return typ;
  }

  void setTyp(int typ) {
    this.typ = typ;
  }
}
