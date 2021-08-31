part of ImmunityTD;

///PowerUp Klasse
abstract class PowerUp {
  int kosten;
  String name;
  /*int getPosition();
  void setPosition(int hierFehltWas);  */
}

class Antibiotika implements PowerUp {
  int abklingzeit;
  double multiplikatorAG;
  int laufzeit;
  @override
  int kosten = 200;
  @override
  String name = 'antibiotika';
  /* position*/

  Antibiotika(Map<String, dynamic> data
      /*position*/
      ) {
    abklingzeit = data['Abklinkzeit'];
    multiplikatorAG = data['MultiplikatorAG'];
    laufzeit = data['laufzeit'];
  }
}

class Adrenalin implements PowerUp {
  int abklingzeit;
  double multiplikatorAG;
  int laufzeit;
  @override
  int kosten = 150;
  @override
  String name = 'adrenalin';
  /* position*/

  Adrenalin(Map<String, dynamic> data
      /*position*/
      ) {
    abklingzeit = data['Abklinkzeit'];
    multiplikatorAG = data['MultiplikatorAG'];
    laufzeit = data['laufzeit'];
  }
}
