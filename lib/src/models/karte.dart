part of ImmunityTD;

class Karte {
  List<List<Position>> wege;
  List<Position> felder;
  List<bool> besetzt = [false];

  Karte(List<Position> f) {
    felder = f;
    for(var fel in felder) {
      besetzt.add(false);
    }
  }

  bool free() {
    var free = false;
    for(var b in besetzt) {
      if(!b) {
        free = true;
      }
    }
    return free;
  }
}

