part of ImmunityTD;

class Karte {
  List<List<Position>> wege;
  List<Feld> felder;

  Karte(List<List> f, List<int> type, List<List<Position>> w) {
    int i = 0;
    for (var row in f) {
      for (var field in row) {
        final r = field.getBoundingClientRect().toInt();
        final c = field.getBoundingClientRect().toInt();
        felder.add(new Feld(r, c, type[i]));
        i++;
      }
    }
    wege = w;
  }

  List<Feld> getFelder() {
    return felder;
  }

  void setFelder(List<Feld> f) {
    felder = f;
  }

  List<List<Position>> getWege() {
    return wege;
  }

  void setWege(List<List<Position>> w) {
    wege = w;
  }
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
