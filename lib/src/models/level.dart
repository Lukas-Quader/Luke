part of ImmunityTD;

///Levelklasse
///Sie ist die Hauptklasse des Models und vereint alle Informationen aus den
///Models.
class Level {
  //Variablen bekanntmachen
  int leben = 100;
  List<dynamic> wellen;
  bool gameOver;
  bool win;
  num ak;
  List<Turm> kaufen = [];
  List<Turm> turm = [];
  List<PowerUp> powerup = [];
  Karte karte;
  List<Feinde> feinde = [];
  List<Projektiel> shots = [];

  ///Constructor:
  ///@param anti = Antikörper
  ///@param kauf = kaufen
  ///@param welle = Welle
  ///@param pu = PowerUps
  ///@param k = Karte
  Level(Map<String, dynamic> data) {
    var waves = [];
    for (var wave in data['Wellen']) {
      var welle = [];
      for (Map feind in wave) {
        switch (feind.keys.first) {
          case 'Corona':
            welle.add(Corona(feind['Corona']));
            break;
          case 'MRSA':
            welle.add(MRSA(feind['MRSA']));
            break;
          case 'Grippe':
            welle.add(Grippe(feind['Grippe']));
            break;
          case 'HSV':
            welle.add(HSV(feind['HSV'], feinde.length));
            break;
          case 'Clostridien':
            welle.add(Clostridien(feind['Clostridien']));
            break;
          default:
        }
      }
      waves.add(welle);
    }
    wellen = waves;
    gameOver = false;
    win = false;
    ak = data['Antikörper'];
    for (var tower in data['Turmkauf']) {
      switch (tower.keys.first) {
        case 'Blutzelle':
          kaufen.add(Blutzelle(tower['Blutzelle']));
          break;
        case 'Auge':
          kaufen.add(Auge(tower['Auge']));
          break;
        case 'Niere':
          kaufen.add(Niere(tower['Niere']));
          break;
        case 'Lunge':
          kaufen.add(Lunge(tower['Lunge']));
          break;
        case 'Herz':
          kaufen.add(Herz(tower['Herz']));
          break;
        default:
      }
    }
    for (var up in data['PowerUps']) {
      switch (up.keys.first) {
        case 'Antibiotika':
          powerup.add(Antibiotika(up['Antibiotika']));
          break;
        case 'Adrenalin':
          powerup.add(Adrenalin(up['Adrenalin']));
          break;
        default:
      }
    }

    karte = Karte(data['Karte']);
    feinde = [];
  }

  Level from(Level l) {
    wellen = l.wellen;
    gameOver = false;
    win = false;
    ak = l.ak;
    kaufen = l.kaufen;
    karte = l.karte;
    feinde = l.feinde;
    powerup = l.powerup;
    return this;
  }

  ///Mehtode um die Feinde zu bewegen
  void feindeBewegen() async {
    //Prüfen ob Feinde existieren
    if (feinde.isNotEmpty) {
      feinde.sort((a, b) => a.way.length == b.way.length
          ? a.pos.dist(a.goal).compareTo(b.pos.dist(b.goal))
          : a.way.length.compareTo(b.way.length));
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
        if (shot.isNotEmpty) {
          shots.addAll(shot);
        }
      }
      for (var pro in shots) {
        var kill = pro.fly();
        if (kill > 0) {
          ak += kill;
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
  num turmPlazieren(String name, Position position, int lvl, int id) {
    var pos = Position(0, 0); //initialisieren der Variable pos als Position
    num count = -1; //initialisieren der Variable count
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
      karte.besetzt[count] =
          true; //Setzen des kontrollfeldes in der besetzt liste von Karte
      switch (name) {
        case 'blutzelle':
          turm.add(Blutzelle({
            'Level': lvl,
            'Position': {'x': pos.x, 'y': pos.y},
            'id': id
          }));
          break;
        case 'auge':
          turm.add(Auge({
            'Level': lvl,
            'Position': {'x': pos.x, 'y': pos.y},
            'id': id
          }));
          break;
        case 'niere':
          turm.add(Niere({
            'Level': lvl,
            'Position': {'x': pos.x, 'y': pos.y},
            'id': id
          }));
          break;
        case 'lunge':
          turm.add(Lunge({
            'Level': lvl,
            'Position': {'x': pos.x, 'y': pos.y},
            'id': id
          }));
          break;
        case 'herz':
          turm.add(Herz({
            'Level': lvl,
            'Position': {'x': pos.x, 'y': pos.y},
            'id': id
          }));
          break;
        default:
      }
    }
    return count;
  }

  ///Spawnmethode:
  ///solange noch weitere Wellen und Feinde in den Wellen existieren, werden
  ///die Feine in feinde geaddet und der Aktuelle Feind wird entfernt.
  ///Wenn die Welle leer ist wird diese entfernt.
  bool spawn() {
    var spawned = false;
    if (wellen.isNotEmpty) {
      if (wellen[0].isNotEmpty) {
        feinde.add(wellen[0][0]);
        if ('hsv' == feinde.last.name)
          feinde.last.leben += feinde.length * 5; // Dynamisches Leben von HSV
        wellen[0].removeAt(0);
        spawned = true;
      }
      if (wellen[0].isEmpty && feinde.isEmpty) {
        wellen.removeAt(0);
      }
    }
    return spawned;
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

  bool upgrade(Turm tow, num lev) {
    var temp = tow.level;
    var done = true;
    switch (temp) {
      case 1:
        if (lev == 1)
          ;
        else if (lev == 2 && ak >= tow.kostenU1) {
          ak -= tow.kostenU1;
          tow.upgrade(lev);
        } else if (lev == 3 && ak >= tow.kostenU1 + tow.kostenU2) {
          ak -= (tow.kostenU1 + tow.kostenU2);
          tow.upgrade(lev);
        } else
          done = false;
        break;
      case 2:
        if (lev == 1) {
          ak += tow.kostenU1;
          tow.upgrade(lev);
        } else if (lev == 2)
          ;
        else if (lev == 3 && ak >= tow.kostenU2) {
          ak -= tow.kostenU2;
          tow.upgrade(lev);
        } else
          done = false;
        break;
      case 3:
        if (lev == 1) {
          ak += tow.kostenU1 + tow.kostenU2;
          tow.upgrade(lev);
        } else if (lev == 2) {
          ak += tow.kostenU2;
          tow.upgrade(lev);
        } else if (lev == 3)
          ;
        else
          done = false;
        break;
    }
    return done;
  }

  num sellTower(Turm tower, num value) {
    var count = 0;
    for (int i = 0; i < karte.felder.length; i++) {
      if (karte.besetzt[i] && karte.felder[i].dist(tower.position) == 0) {
        karte.besetzt[i] = false;
        count = i;
      }
    }
    turm.remove(tower);
    ak += value;
    return count;
  }

  // Das übergeben Level wird im LocalStorage des Browsers gespeichert.
  // Es ist eine Map mit einem Key/Value Paar
  void safeLevel(num l) {
    if (int.parse(window.localStorage['completeLevel']) < l)
      window.localStorage['completeLevel'] = '$l';
  }
}
