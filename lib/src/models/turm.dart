part of ImmunityTD;

abstract class Turm {
  void upgrade();
  int getAngriffsgeschwindigkeit();
  void setAngriffsgeschwindigkeit(int ag);
  int getSchaden();
  void setSchaden(int dmg);
  int getReichweite();
  void setReichweite(int r);
  int getLevel();
  void setLevel(int lvl);
  int getKosten();
  void setKosten(int k);
  /*position*/
  int getEffekt();
  void setEffekt(int eff);
  int getAGCount();
  void setAGCount(int agc);
  Position getPosition();
  void setPosition(Position pos);
  bool angriff(List<Feinde> feinde);
  String getName();
  int getID();
}

class Blutzelle implements Turm {
  String name = 'blutzelle';
  int id;
  int angriffsgeschwindigkeit = 15;
  int agcount = 15;
  int schaden = 5;
  int reichweite = 100;
  int level = 1;
  int kosten = 50;
  int effekt = 0;
  Position position;

  void upgrade() {
    switch (level) {
      case 2:
        angriffsgeschwindigkeit = 5;
        break;
      case 3:
        schaden = 10;
        break;
      default:
    }
  }

  bool angriff(List<Feinde> feinde) {
    bool kill = false;
    if (agcount <= 0) {
      for (Feinde f in feinde) {
        if (position.dist(f.pos) <= reichweite) {
          kill = f.treffer(schaden, effekt);
          print('attack');
          agcount = angriffsgeschwindigkeit;
          break;
        }
      }
    }
    agcount--;
    print("$kill");
    return kill;
  }

  Blutzelle(int lvl, Position pos, int i) {
    while (lvl > 1) {
      upgrade();
      lvl--;
    }
    position = pos;
    id = i;
  }

  int getAngriffsgeschwindigkeit() {
    return angriffsgeschwindigkeit;
  }

  void setAngriffsgeschwindigkeit(int ag) {
    angriffsgeschwindigkeit = ag;
  }

  int getAGCount() {
    return agcount;
  }

  void setAGCount(int agc) {
    agcount = agc;
  }

  int getSchaden() {
    return schaden;
  }

  void setSchaden(int dmg) {
    schaden = dmg;
  }

  int getReichweite() {
    return reichweite;
  }

  void setReichweite(int r) {
    reichweite = r;
  }

  int getLevel() {
    return level;
  }

  void setLevel(int lvl) {
    level = lvl;
  }

  int getKosten() {
    return kosten;
  }

  void setKosten(int k) {
    kosten = k;
  }

  /*position*/

  int getEffekt() {
    return effekt;
  }

  void setEffekt(int eff) {
    effekt = eff;
  }

  Position getPosition() {
    return position;
  }

  void setPosition(Position pos) {
    position = pos;
  }

  String getName() {
    return name;
  }

  int getID() {
    return id;
  }
}
