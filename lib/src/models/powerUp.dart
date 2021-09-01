part of ImmunityTD;

///PowerUp Klasse
abstract class PowerUp {
  int kosten;
  String name;
  int abklingzeit;
  double multiplikatorAG;
  double multiplikatorDMG;
}

class Antibiotika implements PowerUp {
  int abklingzeit;
  double multiplikatorAG;
  int laufzeit;
  @override
  int kosten = 200;
  @override
  String name = 'antibiotika';
  double multiplikatorDMG;

  Antibiotika(Map<String, dynamic> data) {
    abklingzeit = data['Abklinkzeit'];
    multiplikatorAG = data['MultiplikatorAG'];
    multiplikatorDMG = data['MultiplikatorDMG'];
    laufzeit = data['laufzeit'];
  }
}

class Adrenalin implements PowerUp {
  int abklingzeit;
  double multiplikatorAG;
  double multiplikatorDMG;
  int laufzeit;
  @override
  int kosten = 150;
  @override
  String name = 'adrenalin';

  Adrenalin(Map<String, dynamic> data) {
    abklingzeit = data['Abklinkzeit'];
    multiplikatorAG = data['MultiplikatorAG'];
    multiplikatorDMG = data['MultiplikatorDMG'];
    laufzeit = data['laufzeit'];
  }
}
