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
  int kostenU1;
  int kostenU2;
  int effekt;
  Position position;

  ///Methode um einen Turm zu upgraden
  void upgrade(num goal);

  ///Methode welche einen Turm angreifen lässt.
  ///Ihr wird eine Liste von Feinden
  List<Projektiel> angriff(List<Feinde> feinde, bool _powerup, PowerUp powerUp);
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
  int kostenU1 = 50; // Kosten des ersten Upgrades
  @override
  int kostenU2 = 50; // Kosten des zweiten Upgrades
  @override
  int effekt = 0; // Welche Effekte der Turm besitzt hier keine
  @override
  Position position; // Position des Turms

  ///Constructor
  ///@param lvl = Turmlevel
  ///@param pos = Position des Turms
  ///@param id = ID des Turms
  Blutzelle(Map<String, dynamic> data, num width, num height) {
    //das level des Turms wird erhöht um das level
    upgrade(data['Level']);
    position = Position(data['Position']['x'], data['Position']['y']);
    id = data['id'];
    reichweite = (reichweite * width / 620).round();
  }

  ///Das Turmlevel wird hiermit erhöht
  @override
  void upgrade(num goal) {
    switch (goal) {
      case 1:
        angriffsgeschwindigkeit = 15;
        schaden = 8;
        level = 1;
        break;
      //Erhöhung der Angriffsgeschwindigkeit
      case 2:
        angriffsgeschwindigkeit = 13;
        schaden = 10;
        level = 2;
        break;
      //Der Schaden wird erhöht
      case 3:
        angriffsgeschwindigkeit = 8;
        schaden = 10;
        level = 3;
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
  List<Projektiel> angriff(
      List<Feinde> feinde, bool _powerup, PowerUp powerUp) {
    //var kill auf auf false setzen
    List<Projektiel> kill = [];
    //Wenn der counter 0 wird erfolgt ein Angriff
    if (agcount <= 0) {
      //Alle Feinde durchgehen
      for (var f in feinde) {
        //Prüfen ob ein Feind in Reichweite ist
        if (position.dist(f.pos) <= reichweite) {
          if (_powerup) {
            //Feind mit Schaden und Effekt treffen und speichern ob tödlich
            kill.add(Blutschuss(id, position + Position(25, 25), f, effekt,
                (schaden * powerUp.multiplikatorDMG) as int));
            agcount =
                (angriffsgeschwindigkeit / powerUp.multiplikatorAG) as int;
          } else {
            //Feind mit Schaden und Effekt treffen und speichern ob tödlich
            kill.add(Blutschuss(
                id, position + Position(25, 25), f, effekt, schaden));
            agcount = angriffsgeschwindigkeit;
          }
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

///Augen Klasse
///Das Auge ist ein Sniper-Turm mit höherer Reichweite
class Auge implements Turm {
  //Variablen werden bekannt gemacht und zum Teil initialisiert
  @override
  String name = 'auge'; //Name/Typ des Turms
  @override
  int id; //id um die Türme zu unterscheiden
  @override
  int angriffsgeschwindigkeit = 30; // Angriffsgeschwindigkeit
  @override
  int agcount = 0; // Count für die Angriffsgeschwindigkeit
  @override
  int schaden = 10; // Initialer Schaden
  @override
  int reichweite = 200; // Initiale Reichweite
  @override
  int level = 1; // Initiales Level
  @override
  int kosten = 75; // Kosten des Turms
  @override
  int kostenU1 = 75; // Kosten des ersten Upgrades
  @override
  int kostenU2 = 75; // Kosten des zweiten Upgrades
  @override
  int effekt = 0; // Welche Effekte der Turm besitzt hier keine
  @override
  Position position; // Position des Turms

  ///Constructor
  ///@param lvl = Turmlevel
  ///@param pos = Position des Turms
  ///@param id = ID des Turms
  Auge(Map<String, dynamic> data, num width, num height) {
    //das level des Turms wird erhöht um das level
    upgrade(data['Level']);
    position = Position(data['Position']['x'], data['Position']['y']);
    id = data['id'];
    reichweite = (reichweite * width / 620).round();
  }

  ///Das Turmlevel wird hiermit erhöht
  @override
  void upgrade(num goal) {
    switch (goal) {
      case 1:
        reichweite = 200;
        schaden = 10;
        level = 1;
        angriffsgeschwindigkeit = 30;
        break;
      //Erhöhung der Angriffsgeschwindigkeit
      case 2:
        reichweite = 400;
        schaden = 11;
        level = 2;
        angriffsgeschwindigkeit = 25;
        break;
      //Der Schaden wird erhöht
      case 3:
        reichweite = 400;
        schaden = 16;
        level = 3;
        angriffsgeschwindigkeit = 25;
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
  List<Projektiel> angriff(
      List<Feinde> feinde, bool _powerup, PowerUp powerUp) {
    //var kill auf auf false setzen
    List<Projektiel> kill = [];
    //Wenn der counter 0 wird erfolgt ein Angriff
    if (agcount <= 0) {
      //Alle Feinde durchgehen
      for (var f in feinde) {
        //Prüfen ob ein Feind in Reichweite ist
        if (position.dist(f.pos) <= reichweite) {
          if (_powerup) {
            //Feind mit Schaden und Effekt treffen und speichern ob tödlich
            kill.add(Augenschuss(id, position + Position(25, 25), f, effekt,
                (schaden * powerUp.multiplikatorDMG) as int));
            agcount =
                (angriffsgeschwindigkeit / powerUp.multiplikatorAG) as int;
          } else {
            //Feind mit Schaden und Effekt treffen und speichern ob tödlich
            kill.add(Augenschuss(
                id, position + Position(25, 25), f, effekt, schaden));
            agcount = angriffsgeschwindigkeit;
          }
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

///Nieren Klasse
///Die Niere ist ein Sniper-Turm mit höherer Reichweite
class Niere implements Turm {
  //Variablen werden bekannt gemacht und zum Teil initialisiert
  @override
  String name = 'niere'; //Name/Typ des Turms
  @override
  int id; //id um die Türme zu unterscheiden
  @override
  int angriffsgeschwindigkeit = 10; // Angriffsgeschwindigkeit
  @override
  int agcount = 0; // Count für die Angriffsgeschwindigkeit
  @override
  int schaden = 1; // Initialer Schaden
  @override
  int reichweite = 150; // Initiale Reichweite
  @override
  int level = 1; // Initiales Level
  @override
  int kosten = 75; // Kosten des Turms
  @override
  int kostenU1 = 75; // Kosten des ersten Upgrades
  @override
  int kostenU2 = 50; // Kosten des zweiten Upgrades
  @override
  int effekt = 3; // Welche Effekte der Turm besitzt hier keine
  @override
  Position position; // Position des Turms

  ///Constructor
  ///@param lvl = Turmlevel
  ///@param pos = Position des Turms
  ///@param id = ID des Turms
  Niere(Map<String, dynamic> data, num width, num height) {
    //das level des Turms wird erhöht um das level
    upgrade(data['Level']);
    position = Position(data['Position']['x'], data['Position']['y']);
    id = data['id'];
    reichweite = (reichweite * width / 620).round();
  }

  ///Das Turmlevel wird hiermit erhöht
  @override
  void upgrade(num goal) {
    switch (goal) {
      case 1:
        reichweite = 150;
        effekt = 3;
        level = 1;
        break;
      //Erhöhung der Angriffsgeschwindigkeit
      case 2:
        reichweite = 200;
        effekt = 3;
        level = 2;
        break;
      //Der Schaden wird erhöht
      case 3:
        reichweite = 200;
        effekt = 4;
        level = 3;
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
  List<Projektiel> angriff(
      List<Feinde> feinde, bool _powerup, PowerUp powerUp) {
    //var kill auf auf false setzen
    List<Projektiel> kill = [];
    //Wenn der counter 0 wird erfolgt ein Angriff
    if (agcount <= 0) {
      //Alle Feinde durchgehen
      for (var f in feinde) {
        //Prüfen ob ein Feind in Reichweite ist
        if (position.dist(f.pos) <= reichweite &&
            (f.countDOT <= 0 || agcount <= -10)) {
          if (_powerup) {
            //Feind mit Schaden und Effekt treffen und speichern ob tödlich
            kill.add(Nierenschuss(id, position + Position(25, 25), f, effekt,
                (schaden * powerUp.multiplikatorDMG) as int));
            agcount =
                (angriffsgeschwindigkeit / powerUp.multiplikatorAG) as int;
          } else {
            //Feind mit Schaden und Effekt treffen und speichern ob tödlich
            kill.add(Nierenschuss(
                id, position + Position(25, 25), f, effekt, schaden));
            agcount = angriffsgeschwindigkeit;
          }
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

///Lunge Klasse
///Die Lunge ist ein Verlangsamungs-Turm
class Lunge implements Turm {
  //Variablen werden bekannt gemacht und zum Teil initialisiert
  @override
  String name = 'lunge'; //Name/Typ des Turms
  @override
  int id; //id um die Türme zu unterscheiden
  @override
  int angriffsgeschwindigkeit = 15; // Angriffsgeschwindigkeit
  @override
  int agcount = 0; // Count für die Angriffsgeschwindigkeit
  @override
  int schaden = 2; // Initialer Schaden
  @override
  int reichweite = 80; // Initiale Reichweite
  @override
  int level = 1; // Initiales Level
  @override
  int kosten = 100; // Kosten des Turms
  @override
  int kostenU1 = 100; // Kosten des ersten Upgrades
  @override
  int kostenU2 = 50; // Kosten des zweiten Upgrades
  @override
  int effekt = 1; // Welche Effekte der Turm besitzt Slow
  @override
  Position position; // Position des Turms

  ///Constructor
  ///@param lvl = Turmlevel
  ///@param pos = Position des Turms
  ///@param id = ID des Turms
  Lunge(Map<String, dynamic> data, num width, num height) {
    //das level des Turms wird erhöht um das level
    upgrade(data['Level']);
    position = Position(data['Position']['x'], data['Position']['y']);
    id = data['id'];
    reichweite = (reichweite * width / 620).round();
  }

  ///Das Turmlevel wird hiermit erhöht
  @override
  void upgrade(num goal) {
    switch (goal) {
      case 1:
        angriffsgeschwindigkeit = 15;
        reichweite = 100;
        level = 1;
        break;
      //Erhöhung der Reichweite und Flaechenangriff
      case 2:
        angriffsgeschwindigkeit = 15;
        reichweite = 110;
        level = 2;
        break;
      //Der Schaden wird erhöht
      case 3:
        angriffsgeschwindigkeit = 12;
        reichweite = 160;
        level = 3;
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
  List<Projektiel> angriff(
      List<Feinde> feinde, bool _powerup, PowerUp powerUp) {
    //var kill auf auf false setzen
    List<Projektiel> kill = [];
    //counter für die Id
    var idcount = 0;
    //Wenn der counter 0 wird erfolgt ein Angriff
    if (agcount <= 0) {
      //Alle Feinde durchgehen
      for (var f in feinde) {
        //Prüfen ob ein Feind in Reichweite ist
        if (position.dist(f.pos) <= reichweite) {
          //agcount "resetten"
          if (_powerup) {
            //Feind mit Schaden und Effekt treffen und speichern ob tödlich
            kill.add(Luftschuss(idcount++, position + Position(25, 25), f,
                effekt, (schaden * powerUp.multiplikatorDMG) as int));
          } else {
            //Feind mit Schaden und Effekt treffen und speichern ob tödlich
            kill.add(Luftschuss(
                idcount++, position + Position(25, 25), f, effekt, schaden));
          }
          //Break, damit nur der "nächste" Feind angegriffen wird.
          if (level <= 1) break;
        }
      }
      //agcount "resetten"
      if (_powerup) {
        agcount = (angriffsgeschwindigkeit / powerUp.multiplikatorAG) as int;
      } else {
        agcount = angriffsgeschwindigkeit;
      }
    }
    //Angriffscounter einen runterzählen
    agcount--;
    //Rückgabe ob der Treffer tödlich war
    return kill;
  }
}

///Herz Klasse
///Das Herz ist ein Effekt-Turm welches im Umkreis Flächenschaden verursacht
class Herz implements Turm {
  //Variablen werden bekannt gemacht und zum Teil initialisiert
  @override
  String name = 'herz'; //Name/Typ des Turms
  @override
  int id; //id um die Türme zu unterscheiden
  @override
  int angriffsgeschwindigkeit = 20; // Angriffsgeschwindigkeit
  @override
  int agcount = 0; // Count für die Angriffsgeschwindigkeit
  @override
  int schaden = 4; // Initialer Schaden
  @override
  int reichweite = 60; // Initiale Reichweite
  @override
  int level = 1; // Initiales Level
  @override
  int kosten = 125; // Kosten des Turms
  @override
  int kostenU1 = 125; // Kosten des ersten Upgrades
  @override
  int kostenU2 = 100; // Kosten des zweiten Upgrades
  @override
  int effekt = 2; // Welche Effekte der Turm besitzt hier keine
  @override
  Position position; // Position des Turms

  ///Constructor
  ///@param lvl = Turmlevel
  ///@param pos = Position des Turms
  ///@param id = ID des Turms
  Herz(Map<String, dynamic> data, num width, num height) {
    //das level des Turms wird erhöht um das level
    upgrade(data['Level']);
    position = Position(data['Position']['x'], data['Position']['y']);
    id = data['id'];
    reichweite = (reichweite * width / 620).round();
  }

  ///Das Turmlevel wird hiermit erhöht
  @override
  void upgrade(num goal) {
    switch (goal) {
      case 1:
        angriffsgeschwindigkeit = 20;
        reichweite = 100;
        level = 1;
        schaden = 4;
        break;
      //Erhöhung der Angriffsgeschwindigkeit
      case 2:
        angriffsgeschwindigkeit = 15;
        reichweite = 100;
        level = 2;
        schaden = 5;
        break;
      //Der Schaden wird erhöht
      case 3:
        angriffsgeschwindigkeit = 12;
        reichweite = 150;
        level = 3;
        schaden = 6;
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
  List<Projektiel> angriff(
      List<Feinde> feinde, bool _powerup, PowerUp powerUp) {
    //var kill auf auf false setzen
    List<Projektiel> kill = [];
    //counter für id bei angriff von mehreren gegnern gleichzeitig
    var idcount = 0;
    //Wenn der counter 0 wird erfolgt ein Angriff
    if (agcount <= 0) {
      //Alle Feinde durchgehen
      for (var f in feinde) {
        //Prüfen ob ein Feind in Reichweite ist
        if (position.dist(f.pos) <= reichweite) {
          //Feind mit Schaden und Effekt treffen und speichern ob tödlich
          if (_powerup) {
            kill.add(Herzschuss(idcount++, position + Position(25, 25), f,
                effekt, (schaden * powerUp.multiplikatorDMG) as int));
          } else {
            kill.add(Herzschuss(
                idcount++, position + Position(25, 25), f, effekt, schaden));
          }
        }
      }
      //agcount "resetten"
      if (_powerup) {
        agcount = (angriffsgeschwindigkeit / powerUp.multiplikatorAG) as int;
      } else {
        agcount = angriffsgeschwindigkeit;
      }
    }
    //Angriffscounter einen runterzählen
    agcount--;
    //Rückgabe ob der Treffer tödlich war
    return kill;
  }
}
