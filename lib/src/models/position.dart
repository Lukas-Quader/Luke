part of ImmunityTD;

///Klasse um Positionen zu speichern und Richtungen zu berechnen
///Sie basiert auf Vektorberechnung
class Position {
  //Variable für x und y Wert
  num x, y;

  ///Construktor
  Position(this.x, this.y);

  ///Methode zum Laden der Daten aus der Json
  void positionFromData(Map<String, dynamic> data) {
    x = data['x'];
    y = data['y'];
  }

  //Neuzuweisung der Operatoren +, -, * und <=
  ///+ es werden jeweils x und y Werte addiert
  operator +(Position next) => new Position(x + next.x, y + next.y);

  ///- es werden jeweils x und y Werte subtrahiert
  operator -(Position next) => new Position(x - next.x, y - next.y);

  /// x und y werden jeweils mit einem dem selben Wert multipliziert
  operator *(num speed) => new Position(x * speed, y * speed);

  ///<= es wird geprüft ob x und y kleiner als eine andere Zahl sind
  operator <=(num next) => this.x <= next && this.y <= next;

  ///Die länge eines Vektors
  num length() => Math.sqrt(Math.pow(this.x, 2) + Math.pow(this.y, 2));

  ///Macht einen Einheitsvektor aus dem Vektor
  Position uni() => this * (1 / this.length());

  ///die Distanz zwischen zwei Vektoren
  num dist(Position next) =>
      Math.sqrt(Math.pow(this.x - next.x, 2) + Math.pow(this.y - next.y, 2));
}
