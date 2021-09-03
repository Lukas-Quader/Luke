part of ImmunityTD;

///PowerUp Klasse: Jedes Powerup kann in den Fähigkeiten variieren.
abstract class PowerUp {
  ///Name des PowerUps
  String name;

  ///Abklingzeiten der PowerUps
  int abklingzeit;

  ///Laufzeit des PowerUps
  int laufzeit;

  ///Multiplikator der Angriffsgeschwindigkeit
  double multiplikatorAG;

  ///Multiplikator des Schadens
  double multiplikatorDMG;
}

///Antibiotikaklasse: Sie soll den Schaden der Türme erhöhen
class Antibiotika implements PowerUp {
  int abklingzeit;
  double multiplikatorAG;
  int laufzeit;
  @override
  String name = 'antibiotika';
  double multiplikatorDMG;

  ///Constructor: initialisiert die Variablen mit den Daten aus der Json
  ///@param date die Daten aus der Json
  Antibiotika(Map<String, dynamic> data) {
    abklingzeit = data['Abklingzeit'];
    multiplikatorAG = data['MultiplikatorAG'];
    multiplikatorDMG = data['MultiplikatorDMG'];
    laufzeit = data['laufzeit'];
  }
}

/// Adrenalinklase: Sie soll die Geschwindigkeit der Tower erhöhen
class Adrenalin implements PowerUp {
  int abklingzeit;
  double multiplikatorAG;
  double multiplikatorDMG;
  int laufzeit;
  @override
  String name = 'adrenalin';

  ///Constructor: initialisiert die Variablen mit den Daten aus der Json
  ///@param date die Daten aus der Json
  Adrenalin(Map<String, dynamic> data) {
    abklingzeit = data['Abklingzeit'];
    multiplikatorAG = data['MultiplikatorAG'];
    multiplikatorDMG = data['MultiplikatorDMG'];
    laufzeit = data['laufzeit'];
  }
}
