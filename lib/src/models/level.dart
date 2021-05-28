part of ImmunityTD;

class Level {
  int leben = 100;
  List<List<Feinde>> wellen;
  bool gameOver;
  int ak;
  List<String> kaufen;
  List<PowerUp> powerUps;
  List<Turm> turm = [];
  Karte karte;
  List<Feinde> feinde;

  Level(
      int anti,
      List<String> kauf,
      List<List<Feinde>> welle,
      List<PowerUp> pu,
      Karte k) {
    wellen = welle;
    gameOver = false;
    ak = anti;
    kaufen = kauf;
    karte = k;
    powerUps = pu;
    feinde = [];
  }

  void feindeBewegen() {
    if (!feinde.isEmpty) {
      for(Feinde f in feinde) {
        f.bewegen();
        if(f.fin) {
          leben -= f.leben;
          if(leben <= 0) {
            leben = 0;
            gameOver = true;
            return;
          }
        }
      }
    }
  }

  void turmAngriff() {
    if(turm.length > 0 && feinde.length > 0) {
      for(Turm t in turm) {
        if(t.angriff(feinde)) ak += 5;
      }
    }
  }

  void turmPlazieren(String name, Position position, int lvl, int id) {
    Position pos = karte.felder[0];
    for(int i = 1; i < karte.felder.length; i++) {
      if (position.dist(karte.felder[i]) < pos.dist(karte.felder[i])) pos = karte.felder[i];
    }
    switch (name) {
      case 'Blutzelle':
        turm.add(new Blutzelle(lvl, pos, id));
        break;
      default:
    }
  }

  void spawn() {
    if(wellen.length > 0) {
      if(wellen[0].length > 0){
        feinde.add(wellen[0][0]); 
        wellen[0].removeAt(0);
        if(wellen[0].isEmpty) wellen.removeAt(0);
      } 
    }
  }
}
