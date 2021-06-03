part of ImmunityTD;

///Levelklasse
///Sie ist die Hauptklasse des Models und vereint alle Informationen aus den
///Models.
class Level {
  //Variablen bekanntmachen
  int leben = 100;
  List<List<Feinde>> wellen;
  bool gameOver;
  bool win;
  num ak;
  List<Turm> kaufen;
  List<Turm> turm = [];
  Karte karte;
  List<Feinde> feinde;
  List<Projektiel> shots = [];

  ///Constructor:
  ///@param anti = Antikörper
  ///@param kauf = kaufen
  ///@param welle = Welle
  ///@param pu = PowerUps
  ///@param k = Karte
  Level(int anti, List<Turm> kauf, List<List<Feinde>> welle, List<PowerUp> pu,
      Karte k) {
    wellen = welle;
    gameOver = false;
    win = false;
    ak = anti;
    kaufen = kauf;
    karte = k;
    feinde = [];
  }

  ///Mehtode um die Feinde zu bewegen
  void feindeBewegen() async {
    //Prüfen ob Feinde existieren
    if (feinde.isNotEmpty) {
      //Alle Feinde durchgehen
      for (var f in feinde) {
        //Bewegenmethode aufrufen
        f.bewegen();
        //Prüfen ob der Feind das Ziel erreicht hat
        if (f.fin) {
          //Wenn Ziel erreicht dann Leben abziehen
          leben -= f.leben;
          //Prüfen ob Leben kleiner als 0
          if (leben <= 0) {
            //Leben 0 Setzen damit kein Minusleben angezeigt wird
            leben = 0;
            //GameOver auf true setzen
            gameOver = true;
            return;
          }
        }
      }
    }
  }

  ///Methode für Turmangriffe
  void turmAngriff() {
    //Abfrage zum Prüfen ob turm oder feinde leer ist
    if (turm.isNotEmpty && feinde.isNotEmpty) {
      //Alle existerenden Türme angreifen lassen
      for (var t in turm) {
        //merken ob der Angriff getötet hat
        var shot = t.angriff(feinde);
        //falls der Angriff getötet hat 10 Antikörper gutschreiben
        if (shot != null) {
          shots.add(shot);
        }
      }
      for(var pro in shots) {
        var kill = pro.fly();
        if (kill) {
          ak += 10;
        }
        if(pro.fin) {
          shots.remove(pro);
        }
      }
    }
    // Prüfen ob der Angriff zum Sieg geführt hat
    if (feinde.isEmpty && wellen.isEmpty && !gameOver) {
      win = true; //Sieg
    }
  }

  ///Mehode um Türme zu Platzieren.
  ///@param name Name / Art des Turms
  ///@param position übergibt die Position auf der der Turm stehen soll
  ///@param lvl übergibt das Turmlevel
  ///@param id übergibt die TurmID
  void turmPlazieren(String name, Position position, int lvl, int id) {
    var pos = Position(0, 0); //initialisieren der Variable pos als Position
    num count = 0; //initialisieren der Variable count
    //For-Schleife um ermitteln der Position, welche am nähsten am Klick und frei ist
    for (num j = 0; j < karte.felder.length; j++) {
      if (position.dist(karte.felder[j]) < pos.dist(position) &&
          !karte.besetzt[j]) {
        pos = karte.felder[j];
        count = j;
      }
    }
    // Hinzufügen des übergebenen Turms un die liste aktiver Türme
    if (pos.dist(Position(0, 0)) != 0) {
      karte.besetzt[count] = true;  //Ssetzen des kontrollfeldes in der besetzt liste von Karte
      switch (name) {
        case 'blutzelle':
          turm.add(Blutzelle(lvl, pos, id));
          break;
        default:
      }
    }
  }

  ///Spawnmethode:
  ///solange noch weitere Wellen und Feinde in den Wellen existieren, werden
  ///die Feine in feinde geaddet und der Aktuelle Feind wird entfernt.
  ///Wenn die Welle leer ist wird diese entfernt.
  void spawn() {
    if (wellen.isNotEmpty) {
      if (wellen[0].isNotEmpty) {
        feinde.add(wellen[0][0]);
        wellen[0].removeAt(0);
        if (wellen[0].isEmpty) wellen.removeAt(0);
      }
    }
  }

  ///Kaufmethode:
  ///Die Kosten des jeweiligen Turmes werden von den Antikörpern abgezogen,
  ///Das Feld auf der Karte wird reserviert.
  void buy() {
    ak -= turm.last.kosten;
    karte.besetzt.last = true;
  }

  ///Killmethode:
  ///Entfernt den Feind TODO: unnötig weil es die remove gibt?
  void kill(Feinde f) {
    feinde.remove(f);
  }
}
