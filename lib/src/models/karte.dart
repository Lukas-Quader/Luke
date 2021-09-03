part of ImmunityTD;

///Kartenklasse
///Sie beinhaltet alle Informationen, die für die Positionierung wichtig sind
class Karte {
  //Variablen bekanntmachen
  ///Wege speichert eine Liste von Listen mit Positionen
  List<List<dynamic>> wege = [];

  ///Speichert eine Liste mit Positionen, auf welchen Türme gesetzt werden können
  List<dynamic> felder;

  ///Eine Liste die anzeigt ob ein Feld besetzt ist.
  List<bool> besetzt = [false];

  ///Constructor
  ///Ihm wird eine Liste mit Positionen übergeben
  Karte(Map<String, dynamic> data) {
    var f = [];
    //Einlesen der Felder auf den Daten der Json
    for (var feld in data['Felder']) {
      f.add(Position(feld['Position']['x'], feld['Position']['y']));
    }
    felder = f;
    //Schleife um eine Liste zu erstellen welche speichert,
    //ob das Feld besetzt ist
    for (var fel in felder) {
      besetzt.add(false);
    }
    //Einlesen der Wegpunkte aus den Daten der Json
    for (var weg in data['Wege']) {
      var way = [];
      for (var wegpunkt in weg) {
        way.add(Position(wegpunkt['Position']['x'], wegpunkt['Position']['y']));
      }
      wege.add(way);
    }
  }

  ///Freemethode prüft ob Feld belegt ist
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
