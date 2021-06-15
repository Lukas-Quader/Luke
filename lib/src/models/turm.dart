part of ImmunityTD;

///Abstrakte Klasse Turm
///Sie wird um die speziellen Türme erweitert.
abstract class Turm {
  String name;
  int id;
  int angriffsgeschwindigkeit;
  int agcount; //Counter um die Angriffsgeschwindigkeit zu berechnen
  int schaden;
  int reichweite;
  int level;
  int kosten;
  int effekt;
  Position position;

  ///Methode um einen Turm zu upgraden
  void upgrade();

  ///Methode welche einen Turm angreifen lässt.
  ///Ihr wird eine Liste von Feinden
  Projektiel angriff(List<Feinde> feinde);
}

///Blutzellen Klasse
///Die Blutzelle ist der Basisturm und hat keine speziellen Fähigkeiten
class Blutzelle implements Turm {
  //Variablen werden bekannt gemacht und zum Teil initialisiert
  @override
  String name = 'blutzelle'; //Name/Typ des Turms
  @override
  int id; //id um die Türme zu unterscheiden
  @override
  int angriffsgeschwindigkeit = 20; // Angriffsgeschwindigkeit
  @override
  int agcount = 0; // Count für die Angriffsgeschwindigkeit
  @override
  int schaden = 5; // Initialer Schaden
  @override
  int reichweite = 100; // Initiale Reichweite
  @override
  int level = 1; // Initiales Level
  @override
  int kosten = 50; // Kosten des Turms
  @override
  int effekt = 0; // Welche Effekte der Turm besitzt hier keine
  @override
  Position position; // Position des Turms

  ///Constructor
  ///@param lvl = Turmlevel
  ///@param pos = Position des Turms
  ///@param id = ID des Turms
  Blutzelle(Map<String, dynamic> data) {
    //das level des Turms wird erhöht um das level
    var updates = data['Level'];
    while (updates > 1) {
      upgrade();
      updates--;
    }
    position = Position(data['Position']['x'], data['Position']['y']);
    id = data['id'];
  }

  ///Das Turmlevel wird hiermit erhöht
  @override
  void upgrade() {
    switch (level) {
      //Erhöhung der Angriffsgeschwindigkeit
      case 2:
        angriffsgeschwindigkeit = 30;
        break;
      //Der Schaden wird erhöht
      case 3:
        schaden = 10;
        break;
      //Falls level 1 bleibt alles unverändert
      default:
    }
  }

  ///Angriffsmethode
  ///Sie fügt dem Feind schaden zu
  ///Falls der Schaden zum Tod führt gibt die Methode True zurück.
  ///@param feinde = Liste aus Feinden
  @override
  Projektiel angriff(List<Feinde> feinde) {
    //var kill auf auf false setzen
    var kill;
    //Wenn der counter 0 wird erfolgt ein Angriff
    if (agcount <= 0) {
      //Alle Feinde durchgehen
      for (var f in feinde) {
        //Prüfen ob ein Feind in Reichweite ist
        if (position.dist(f.pos) <= reichweite) {
          //Feind mit Schaden und Effekt treffen und speichern ob tödlich
          kill = Blutschuss(id, position + Position(25, 25), f, effekt);
          //agcount "resetten"
          agcount = angriffsgeschwindigkeit;
          //Breack, damit nur der "nächste" Feind angegriffen wird.
          break;
        }
      }
    }
    //Angriffscounter einen runterzählen
    agcount--;
    //Rückgabe ob der Treffer tödlich war
    return kill;
  }
}

///Blutzellen Klasse
///Die Blutzelle ist der Basisturm und hat keine speziellen Fähigkeiten
class Auge implements Turm {
  //Variablen werden bekannt gemacht und zum Teil initialisiert
  @override
  String name = 'auge'; //Name/Typ des Turms
  @override
  int id; //id um die Türme zu unterscheiden
  @override
  int angriffsgeschwindigkeit = 10; // Angriffsgeschwindigkeit
  @override
  int agcount = 0; // Count für die Angriffsgeschwindigkeit
  @override
  int schaden = 10; // Initialer Schaden
  @override
  int reichweite = 300; // Initiale Reichweite
  @override
  int level = 1; // Initiales Level
  @override
  int kosten = 75; // Kosten des Turms
  @override
  int effekt = 0; // Welche Effekte der Turm besitzt hier keine
  @override
  Position position; // Position des Turms

  ///Constructor
  ///@param lvl = Turmlevel
  ///@param pos = Position des Turms
  ///@param id = ID des Turms
  Auge(Map<String, dynamic> data) {
    //das level des Turms wird erhöht um das level
    var updates = data['Level'];
    while (updates > 1) {
      upgrade();
      updates--;
    }
    position = Position(data['Position']['x'], data['Position']['y']);
    id = data['id'];
  }

  ///Das Turmlevel wird hiermit erhöht
  @override
  void upgrade() {
    switch (level) {
      //Erhöhung der Angriffsgeschwindigkeit
      case 2:
        angriffsgeschwindigkeit = 15;
        break;
      //Der Schaden wird erhöht
      case 3:
        schaden = 20;
        break;
      //Falls level 1 bleibt alles unverändert
      default:
    }
  }

  ///Angriffsmethode
  ///Sie fügt dem Feind schaden zu
  ///Falls der Schaden zum Tod führt gibt die Methode True zurück.
  ///@param feinde = Liste aus Feinden
  @override
  Projektiel angriff(List<Feinde> feinde) {
    //var kill auf auf false setzen
    var kill;
    //Wenn der counter 0 wird erfolgt ein Angriff
    if (agcount <= 0) {
      //Alle Feinde durchgehen
      for (var f in feinde) {
        //Prüfen ob ein Feind in Reichweite ist
        if (position.dist(f.pos) <= reichweite) {
          //Feind mit Schaden und Effekt treffen und speichern ob tödlich
          kill = Blutschuss(id, position + Position(25, 25), f, effekt);
          //agcount "resetten"
          agcount = angriffsgeschwindigkeit;
          //Break, damit nur der "nächste" Feind angegriffen wird.
          break;
        }
      }
    }
    //Angriffscounter einen runterzählen
    agcount--;
    //Rückgabe ob der Treffer tödlich war
    return kill;
  }
}
