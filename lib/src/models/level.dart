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

  Level(int anti, List<Turm> kauf, List<List<Feinde>> welle, List<List> felder,
      List<int> typ, List<List<Position>> wege, List<PowerUp> pu) {
    wellen = welle;
    gameOver = false;
    ak = anti;
    kaufen = kauf;
    karte = new Karte(felder, typ, wege);
    powerUps = pu;
  }

  void feindeBewegen() {
    //TODO feindeBewegen implementieren
  }

  void turmAngriff() {
    //TODO turmAngriff impen
  }
}
