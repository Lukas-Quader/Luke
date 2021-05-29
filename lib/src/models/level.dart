part of ImmunityTD;

class Level {
  int leben = 100;
  List<List<Feinde>> wellen;
  bool gameOver;
  int ak;
  List<Turm> kaufen;
  List<PowerUp> powerUps;
  List<Turm> turm = [];
  Karte karte;
  List<Feinde> feinde;

  Level(int anti, List<Turm> kauf, List<List<Feinde>> welle, List<PowerUp> pu,
      Karte k) {
    wellen = welle;
    gameOver = false;
    ak = anti;
    kaufen = kauf;
    karte = k;
    powerUps = pu;
    feinde = [];
  }

  void feindeBewegen() async {
    if (feinde.isNotEmpty) {
      for (var f in feinde) {
        f.bewegen();
        if (f.fin) {
          leben -= f.leben;
          if (leben <= 0) {
            leben = 0;
            gameOver = true;
            return;
          }
        }
      }
    }
  }

  void turmAngriff() {
    if (turm.isNotEmpty && feinde.isNotEmpty) {
      for (var t in turm) {
        var kill = t.angriff(feinde);
        if (kill) {
          ak += 5;
        }
      }
    }
  }

  void turmPlazieren(String name, Position position, int lvl, int id) {
    var pos = Position(0, 0);
    num count = 0;
    for(num i = 0; i < karte.felder.length; i++) {
      if(!karte.besetzt[i]) {
        pos = karte.felder[i];
        count = i;
        break;
      }
    }
    for (num j = 0; j < karte.felder.length; j++) {
      if (position.dist(karte.felder[j]) < pos.dist(position) && !karte.besetzt[j]) {
        pos = karte.felder[j];
        count = j;
      }
    }
    if(pos.dist(Position(0, 0)) != 0) {
      karte.besetzt[count] = true;
      switch (name) {
        case 'blutzelle':
          turm.add(Blutzelle(lvl, pos, id));
          break;
        default:
      }
    }
  }

  void spawn() {
    if (wellen.isNotEmpty) {
      if (wellen[0].isNotEmpty) {
        feinde.add(wellen[0][0]);
        wellen[0].removeAt(0);
        if (wellen[0].isEmpty) wellen.removeAt(0);
      }
    }
  }
}
