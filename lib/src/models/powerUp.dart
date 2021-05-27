part of ImmunityTD;

abstract class PowerUp {
  int getAbklingzeit();
  void setAbklingzeit(int cd);
  int getLaufzeit();
  void setLaufzeit(int laufz);
  double getMultiplikatorAG();
  void setMultiplikatorAG(double mult);
  /*int getPosition();
  void setPosition(int hierFehltWas);  */
}

class Antibiotika implements PowerUp {
  int abklingzeit;
  double multiplikatorAG;
  int laufzeit;
  /* position*/

  Antibiotika(
    int abklingzeit,
    double multiplikatorAG,
    int laufzeit,
    /*position*/
  ) {
    this.abklingzeit = abklingzeit;
    this.multiplikatorAG = multiplikatorAG;
    this.laufzeit = laufzeit;
  }

  int getAbklingzeit() {
    return abklingzeit;
  }

  void setAbklingzeit(int cd) {}

  int getLaufzeit() {
    return laufzeit;
  }

  void setLaufzeit(int laufz) {}

  double getMultiplikatorAG() {
    return multiplikatorAG;
  }

  void setMultiplikatorAG(double mult) {}
}

class Adrenalin implements PowerUp {
  int abklingzeit;
  double multiplikatorAG;
  int laufzeit;
  /* position*/

  Adrenalin(
    int abklingzeit,
    double multiplikatorAG,
    int laufzeit,
    /*position*/
  ) {
    this.abklingzeit = abklingzeit;
    this.multiplikatorAG = multiplikatorAG;
    this.laufzeit = laufzeit;
  }

  int getAbklingzeit() {
    return abklingzeit;
  }

  void setAbklingzeit(int cd) {}

  int getLaufzeit() {
    return laufzeit;
  }

  void setLaufzeit(int laufz) {}

  double getMultiplikatorAG() {
    return multiplikatorAG;
  }

  void setMultiplikatorAG(double mult) {}
}
