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
    //TODO turmAngriff impen
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
