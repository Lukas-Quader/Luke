part of ImmunityTD;

class Level {
  int leben = 100;
  List<List<Feinde>> wellen;
  bool gameOver;
  int ak;
  List<Turm> kaufen;
  List<PowerUp> powerUps;
  List<Turm> turm;
  Karte karte;
  List<Feinde> feinde;

  Level(
      int anti,
      List<Turm> kauf,
      List<List<Feinde>> welle,
      List<PowerUp> pu) {
    wellen = welle;
    gameOver = false;
    ak = anti;
    kaufen = kauf;
    karte = new Karte();
    powerUps = pu;
    feinde = [];
  }

  void feindeBewegen(bool spawn) {
    print("JOLO");
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
    if(spawn && !wellen.isEmpty) {
      feinde.add(wellen[0][0]);
      if(!wellen[0].isEmpty) wellen[0].removeAt(0);
      else wellen.removeAt(0);
    }
  }

  void turmAngriff() {
    //TODO turmAngriff impen
  }
}
