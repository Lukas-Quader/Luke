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
}

class Lunge implements Turm {
  int angriffsgeschwindigkeit;
  int schaden;
  int reichweite;
  int level;
  int kosten;
  int effekt;

  Lunge(int angriffgeschwindigkeit, int schaden, int reichweite, int level,
      int kosten, int effekt) {}

  void upgrade() {
    return null;
  }

  int getAngriffsgeschwindigkeit() {
    return angriffsgeschwindigkeit;
  }

  void setAngriffsgeschwindigkeit(int ag) {}

  int getSchaden() {
    return schaden;
  }

  void setSchaden(int dmg) {}

  int getReichweite() {
    return reichweite;
  }

  void setReichweite(int r) {}

  int getLevel() {
    return level;
  }

  void setLevel(int lvl) {}

  int getKosten() {
    return kosten;
  }

  void setKosten(int k) {}

  /*position*/

  int getEffekt() {
    return effekt;
  }

  void setEffekt(int eff) {}
}

class Auge implements Turm {
  int angriffsgeschwindigkeit;
  int schaden;
  int reichweite;
  int level;
  int kosten;
  int effekt;

  Auge(int angriffgeschwindigkeit, int schaden, int reichweite, int level,
      int kosten, int effekt) {}

  void upgrade() {
    return null;
  }

  int getAngriffsgeschwindigkeit() {
    return angriffsgeschwindigkeit;
  }

  void setAngriffsgeschwindigkeit(int ag) {}

  int getSchaden() {
    return schaden;
  }

  void setSchaden(int dmg) {}

  int getReichweite() {
    return reichweite;
  }

  void setReichweite(int r) {}

  int getLevel() {
    return level;
  }

  void setLevel(int lvl) {}

  int getKosten() {
    return kosten;
  }

  void setKosten(int k) {}

  /*position*/

  int getEffekt() {
    return effekt;
  }

  void setEffekt(int eff) {}
}

class Niere implements Turm {
  int angriffsgeschwindigkeit;
  int schaden;
  int reichweite;
  int level;
  int kosten;
  int effekt;

  Niere(int angriffgeschwindigkeit, int schaden, int reichweite, int level,
      int kosten, int effekt) {}

  void upgrade() {
    return null;
  }

  int getAngriffsgeschwindigkeit() {
    return angriffsgeschwindigkeit;
  }

  void setAngriffsgeschwindigkeit(int ag) {}

  int getSchaden() {
    return schaden;
  }

  void setSchaden(int dmg) {}

  int getReichweite() {
    return reichweite;
  }

  void setReichweite(int r) {}

  int getLevel() {
    return level;
  }

  void setLevel(int lvl) {}

  int getKosten() {
    return kosten;
  }

  void setKosten(int k) {}

  /*position*/

  int getEffekt() {
    return effekt;
  }

  void setEffekt(int eff) {}
}

class Herz implements Turm {
  int angriffsgeschwindigkeit;
  int schaden;
  int reichweite;
  int level;
  int kosten;
  int effekt;

  Herz(int angriffgeschwindigkeit, int schaden, int reichweite, int level,
      int kosten, int effekt) {}
  int getAngriffsgeschwindigkeit() {
    return angriffsgeschwindigkeit;
  }

  void upgrade() {
    return null;
  }

  void setAngriffsgeschwindigkeit(int ag) {}

  int getSchaden() {
    return schaden;
  }

  void setSchaden(int dmg) {}

  int getReichweite() {
    return reichweite;
  }

  void setReichweite(int r) {}

  int getLevel() {
    return level;
  }

  void setLevel(int lvl) {}

  int getKosten() {
    return kosten;
  }

  void setKosten(int k) {}

  /*position*/

  int getEffekt() {
    return effekt;
  }

  void setEffekt(int eff) {}
}

class Blutzelle implements Turm {
  int angriffsgeschwindigkeit;
  int schaden;
  int reichweite;
  int level;
  int kosten;
  int effekt;

  Blutzelle(int angriffgeschwindigkeit, int schaden, int reichweite, int level,
      int kosten, int effekt) {}

  void upgrade() {
    return null;
  }

  int getAngriffsgeschwindigkeit() {
    return angriffsgeschwindigkeit;
  }

  void setAngriffsgeschwindigkeit(int ag) {}

  int getSchaden() {
    return schaden;
  }

  void setSchaden(int dmg) {}

  int getReichweite() {
    return reichweite;
  }

  void setReichweite(int r) {}

  int getLevel() {
    return level;
  }

  void setLevel(int lvl) {}

  int getKosten() {
    return kosten;
  }

  void setKosten(int k) {}

  /*position*/

  int getEffekt() {
    return effekt;
  }

  void setEffekt(int eff) {}
}
