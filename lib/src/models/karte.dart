part of ImmunityTD;

///Kartenklasse
///Sie beinhaltet alle Informationen, die für die Positionierung wichtig sind
class Karte {
  //Variablen bekanntmachen
  List<List<Position>> wege;
  List<Position> felder;
  List<bool> besetzt = [false];

  ///Constructor
  ///Im wird eine Liste mit Positionen übergeben
  Karte(List<Position> f) {
    felder = f;
    //Schleife um eine Liste zu erstellen welche speichert,
    //ob das Feld besetzt ist
    for (var fel in felder) {
      besetzt.add(false);
    }
  }

  ///Freemethode entfernt den besetzt Status
  bool free() {
    var free = false;
    for (var b in besetzt) {
      if (!b) {
        free = true;
      }
    }
    return free;
  }
}
