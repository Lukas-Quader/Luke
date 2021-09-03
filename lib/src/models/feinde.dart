part of ImmunityTD;

abstract class Feinde {
  /// Name des Feindtyps
  String name;

  /// handelt es sich um einen Boss?
  bool boss;

  /// Identifikationsnummer des Feindes
  num id;

  /// Bewegungsgeschwindingkeit des Feindes
  int laufgeschwindigkeit;

  /// lebenspunkte des Feindes
  int leben;

  /// aktuelle Position
  Position pos;

  /// aktuelle Richtung
  Position dir;

  /// Liste der Wegpunkte
  List<dynamic> way;

  /// aktueller Zielpunkt
  Position goal;

  /// ziel erreicht
  bool fin;

  /// Anzahl an AK die nach dem Tode gutgeschrieben werden
  num wert;

  /// Zählt nach einem Treffer wie lange ein Feind als getroffen gilt (wichtig
  ///  für die Animation)
  int _hit = 0;

  /// gibt einen Wahrheitswert ob der Feind als getroffen gilt
  bool get hitted;

  /// Ist der Abstand zum nachfolgenden Feind.
  int abstand;

  /// Gibt an wie lange ein Feind verlangsamt ist.
  int slowtime = 0;

  /// gibt an wie lange Schaden über Zeit hinzugefügt wird.
  int countDOT = 0;

  /// bool -> Gegner am Leben, verarbeitung von Schaden und Effekt bei treffer
  bool treffer(int schaden, int effekt);

  /// Bewegung der Feinde
  void bewegen();

  /// Anpassung der Richtung während der Laufzeit
  void redirect();

  ///Setzen des Weges
  void setWay(List<dynamic> w);
}

class Corona implements Feinde {
  // Feindklasse Corona
  @override
  String name = 'corona';
  @override
  bool boss;
  @override
  num id;
  @override
  int laufgeschwindigkeit;
  @override
  int leben;
  @override
  Position pos;
  @override
  Position dir;
  @override
  List<dynamic> way;
  @override
  Position goal;
  @override
  bool fin = false;
  @override
  num wert;
  @override
  int _hit = 0;
  @override
  int slowtime = 0;
  @override
  int countDOT = 0;
  @override
  int abstand;

  @override
  bool get hitted => _hit >= 1 && _hit <= 10;

  ///Constructor
  Corona(Map<String, dynamic> data) {
    id = data['id']; // Einlesen der Daten
    pos = Position(0, 0); // Position in x und y Koordinaten
    dir = Position(0, 0); // Richtung in x und y Koordinaten
    boss = data['boss']; // Einlesen der Daten
    leben = boss ? 200 : 10; // Falls Feind ein Boss ist hat er 200 Lebenspunkte
    // Falls Feind ein Boss ist hat er 2 Laufgeschwindigkeit
    laufgeschwindigkeit = boss ? 2 : 4;
    wert = boss ? 50 : 5;
    abstand = data['abstand']; // Einlesen der Daten
  }

  /// Bewegen der Feinde
  @override
  void bewegen() {
    if (_hit >= 1) {
      _hit++;
    }
    //Schaden über Zeit
    if (countDOT > 0) {
      countDOT--;
      if (countDOT % 10 == 0) treffer(1, 0);
    }
    // Falls von Verlangsamungseffekt betroffen -> Cooldown
    if (slowtime <= 0) {
      treffer(0, 2);
    } else {
      slowtime--;
    }

    // Abfrage ob noch Wegpunkte in der Liste sind
    if (way.isNotEmpty) {
      // Abfrage ob die Distanz geringer als die Laufgeschwindigkeit ist
      if (pos.dist(goal) <= laufgeschwindigkeit) {
        pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
        goal = way[0]; // Nächster Zielpunkt wird als Ziel gesetzt
        way.removeAt(0); // Zielpunkt wird aus der Liste gelöscht
        dir = (goal - pos)
            .uni(); // Richtung = Einheitsvektor von (Ziel - Position)
        // Distanz ist nicht geringer als die Laufgeschwindigkeit
      } else {
        pos += dir * laufgeschwindigkeit;
        redirect(); // Anpassen der Laufrichtung an das Ziel
      }
      // Keine Wegpunkte mehr in der Liste: Distanz > als Laufgeschwindigkeit
    } else if (pos.dist(goal) > laufgeschwindigkeit) {
      pos += dir * laufgeschwindigkeit;
      // Keine Wegpunkte mehr in der Liste: Distanz < Laufgeschwindigkeit
    } else {
      pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
      fin = true; // Gegner wird gelöscht
    }
  }

  // Verarbeitung der Treffer an Feinde
  @override
  bool treffer(int schaden, int effekt) {
    var kill = false; //

    // Bekommt der Feind mehr Schaden als er Leben hat wird er gelöscht
    if (leben <= schaden) {
      leben = 0;
      fin = true; // Gegner wird gelöscht
      kill = true; // Gegner getötet
      // Feind hat mehr Leben als er Schaden bekommt
    } else {
      leben -= schaden; // Schaden vom Leben abziehen
      if (schaden > 0) {
        _hit = 1;
      }
    }

    // Verlangsamungseffekt
    switch (effekt) {
      case 1:
        laufgeschwindigkeit = boss ? 1 : 2;
        slowtime = boss ? 20 : 35;
        break;
      case 2:
        laufgeschwindigkeit = boss ? 2 : 4;
        break;
      case 3:
        countDOT = 30;
        break;
      case 4:
        countDOT = 50;
        break;
      default:
    }
    return kill; // Rückgabe, ob der Feind getötet wurde
  }

  /// Anpassung der Richtung während der Laufzeit
  @override
  void redirect() {
    dir = (goal - pos).uni();
  }

  /// Setzen des Weges
  @override
  void setWay(List<dynamic> w) {
    way = w;
    goal = way[0]; // Nächster Wegpunkt wird als Ziel gesetzt
    pos = goal; // Erster Wegpunkt wird als die aktuelle Position gesetzt
  }
}

/// Feindklasse Corona
class MRSA implements Feinde {
  @override
  String name = 'mrsa';
  @override
  bool boss;
  @override
  num id;
  @override
  int laufgeschwindigkeit;
  @override
  int leben;
  @override
  Position pos;
  @override
  Position dir;
  @override
  List<dynamic> way;
  @override
  Position goal;
  @override
  bool fin = false;
  @override
  num wert;
  @override
  int _hit = 0;
  @override
  int slowtime = 0;
  @override
  int countDOT = 0;
  @override
  int abstand;

  @override
  bool get hitted => _hit >= 1 && _hit <= 10;

  MRSA(Map<String, dynamic> data) {
    id = data['id'];
    pos = Position(0, 0); // Position in x und y Koordinaten
    dir = Position(0, 0); // Richtung in x und y Koordinaten
    boss = data['boss'];
    leben = boss ? 200 : 7; // Falls Feind ein Boss ist hat er 200 Lebenspunkte
    // Falls Feind ein Boss ist hat er 2 Laufgeschwindigkeit
    laufgeschwindigkeit = boss ? 2 : 5;
    wert = boss ? 60 : 5;
    abstand = data['abstand'];
  }

  @override
  // Bewegen der Feinde
  void bewegen() {
    if (_hit >= 1) _hit++;
    //Schaden über Zeit
    if (countDOT > 0) {
      countDOT--;
      if (countDOT % 10 == 0) treffer(1, 0);
    }
    // Abfrage ob noch Wegpunkte in der Liste sind
    if (way.isNotEmpty) {
      // Abfrage ob die Distanz geringer als die Laufgeschwindigkeit ist
      if (pos.dist(goal) <= laufgeschwindigkeit) {
        pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
        goal = way[0]; // Nächster Zielpunkt wird als Ziel gesetzt
        way.removeAt(0); // Zielpunkt wird aus der Liste gelöscht
        dir = (goal - pos)
            .uni(); // Richtung = Einheitsvektor von (Ziel - Position)
        // Distanz ist nicht geringer als die Laufgeschwindigkeit
      } else {
        pos += dir * laufgeschwindigkeit;
        redirect(); // Anpassen der Laufrichtung an das Ziel
      }
      // Keine Wegpunkte mehr in der Liste: Distanz > als Laufgeschwindigkeit
    } else if (pos.dist(goal) > laufgeschwindigkeit) {
      pos += dir * laufgeschwindigkeit;
      // Keine Wegpunkte mehr in der Liste: Distanz < Laufgeschwindigkeit
    } else {
      pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
      fin = true; // Gegner wird gelöscht
    }
  }

  // Verarbeitung der Treffer an Feinde
  @override
  bool treffer(int schaden, int effekt) {
    var kill = false; //

    // Bekommt der Feind mehr Schaden als er Leben hat wird er gelöscht
    if (leben <= schaden) {
      leben = 0;
      fin = true; // Gegner wird gelöscht
      kill = true; // Gegner getötet
      // Feind hat mehr Leben als er Schaden bekommt
    } else {
      leben -= schaden; // Schaden vom Leben abziehen
      if (schaden > 0) {
        _hit = 1;
      }
    }

    return kill; // Rückgabe, ob der Feind getötet wurde
  }

  // Anpassung der Richtung während der Laufzeit
  @override
  void redirect() {
    dir = (goal - pos).uni();
  }

  @override
  void setWay(List<dynamic> w) {
    way = w;
    goal = way[0]; // Nächster Wegpunkt wird als Ziel gesetzt
    pos = goal; // Erster Wegpunkt wird als die aktuelle Position gesetzt
  }
}

/// Feindklasse Grippe
class Grippe implements Feinde {
  @override
  String name = 'grippe';
  @override
  bool boss;
  @override
  num id;
  @override
  int laufgeschwindigkeit;
  @override
  int leben;
  @override
  Position pos;
  @override
  Position dir;
  @override
  List<dynamic> way;
  @override
  Position goal;
  @override
  bool fin = false;
  @override
  num wert;
  @override
  int _hit = 0;
  @override
  int slowtime = 0;
  @override
  int countDOT = 0;
  @override
  int abstand;

  @override
  bool get hitted => _hit >= 1 && _hit <= 10;

  Grippe(Map<String, dynamic> data) {
    id = data['id'];
    pos = Position(0, 0); // Position in x und y Koordinaten
    dir = Position(0, 0); // Richtung in x und y Koordinaten
    boss = data['boss'];
    leben = boss ? 105 : 8; // Falls Feind ein Boss ist hat er 200 Lebenspunkte
    // Falls Feind ein Boss ist hat er 2 Laufgeschwindigkeit
    laufgeschwindigkeit = boss ? 2 : 5;
    wert = boss ? 50 : 10;
    abstand = data['abstand'];
  }

  /// Bewegen der Feinde
  @override
  void bewegen() {
    if (_hit >= 1) {
      _hit++;
    }
    //Schaden über Zeit
    if (countDOT > 0) {
      countDOT--;
      if (countDOT % 10 == 0) treffer(1, 0);
    }
    // Falls von Verlangsamungseffekt betroffen -> Cooldown
    if (slowtime <= 0) {
      treffer(0, 2);
    } else {
      slowtime--;
    }

    // Abfrage ob noch Wegpunkte in der Liste sind
    if (way.isNotEmpty) {
      // Abfrage ob die Distanz geringer als die Laufgeschwindigkeit ist
      if (pos.dist(goal) <= laufgeschwindigkeit) {
        pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
        goal = way[0]; // Nächster Zielpunkt wird als Ziel gesetzt
        way.removeAt(0); // Zielpunkt wird aus der Liste gelöscht
        dir = (goal - pos)
            .uni(); // Richtung = Einheitsvektor von (Ziel - Position)
        // Distanz ist nicht geringer als die Laufgeschwindigkeit
      } else {
        pos += dir * laufgeschwindigkeit;
        redirect(); // Anpassen der Laufrichtung an das Ziel
      }
      // Keine Wegpunkte mehr in der Liste: Distanz > als Laufgeschwindigkeit
    } else if (pos.dist(goal) > laufgeschwindigkeit) {
      pos += dir * laufgeschwindigkeit;
      // Keine Wegpunkte mehr in der Liste: Distanz < Laufgeschwindigkeit
    } else {
      pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
      fin = true; // Gegner wird gelöscht
    }
  }

  /// Verarbeitung der Treffer an Feinde
  @override
  bool treffer(int schaden, int effekt) {
    var kill = false; //

    // Bekommt der Feind mehr Schaden als er Leben hat wird er gelöscht
    if (leben <= schaden) {
      leben = 0;
      fin = true; // Gegner wird gelöscht
      kill = true; // Gegner getötet
      // Feind hat mehr Leben als er Schaden bekommt
    } else {
      leben -= schaden; // Schaden vom Leben abziehen
      if (schaden > 0) {
        _hit = 1;
      }
    }

// Verlangsamungseffekt
    switch (effekt) {
      case 1:
        laufgeschwindigkeit = boss ? 1 : 2;
        slowtime = boss ? 20 : 35;
        break;
      case 2:
        laufgeschwindigkeit = boss ? 2 : 5;
        break;
      case 3:
        countDOT = 30;
        break;
      case 4:
        countDOT = 50;
        break;
      default:
    }
    return kill; // Rückgabe, ob der Feind getötet wurde
  }

  // Anpassung der Richtung während der Laufzeit
  @override
  void redirect() {
    dir = (goal - pos).uni();
  }

  @override
  void setWay(List<dynamic> w) {
    way = w;
    goal = way[0]; // Nächster Wegpunkt wird als Ziel gesetzt
    pos = goal; // Erster Wegpunkt wird als die aktuelle Position gesetzt
  }
}

/// Feindklasse Grippe
class Grippling implements Feinde {
  @override
  String name = 'grippling';
  @override
  bool boss;
  @override
  num id;
  @override
  int laufgeschwindigkeit;
  @override
  int leben;
  @override
  Position pos;
  @override
  Position dir;
  @override
  List<dynamic> way;
  @override
  Position goal;
  @override
  bool fin = false;
  @override
  num wert;
  @override
  int _hit = 0;
  @override
  int slowtime = 0;
  @override
  int countDOT = 0;
  @override
  int abstand;

  @override
  bool get hitted => _hit >= 1 && _hit <= 10;

  /// Constructor
  Grippling(Map<String, dynamic> data) {
    id = data['id'];
    pos = Position(0, 0); // Position in x und y Koordinaten
    dir = Position(0, 0); // Richtung in x und y Koordinaten
    boss = data['boss'];
    leben = 4; // Falls Feind ein Boss ist hat er 200 Lebenspunkte
    // Falls Feind ein Boss ist hat er 2 Laufgeschwindigkeit
    laufgeschwindigkeit = 8;
    wert = 5;
    abstand = data['abstand'];
  }

  @override
  // Bewegen der Feinde
  void bewegen() {
    if (_hit >= 1) {
      _hit++;
    }
    //Schaden über Zeit
    if (countDOT > 0) {
      countDOT--;
      if (countDOT % 10 == 0) treffer(1, 0);
    }
    // Falls von Verlangsamungseffekt betroffen -> Cooldown
    if (slowtime <= 0) {
      treffer(0, 2);
    } else {
      slowtime--;
    }

    // Abfrage ob noch Wegpunkte in der Liste sind
    if (way.isNotEmpty) {
      // Abfrage ob die Distanz geringer als die Laufgeschwindigkeit ist
      if (pos.dist(goal) <= laufgeschwindigkeit) {
        pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
        goal = way[0]; // Nächster Zielpunkt wird als Ziel gesetzt
        way.removeAt(0); // Zielpunkt wird aus der Liste gelöscht
        dir = (goal - pos)
            .uni(); // Richtung = Einheitsvektor von (Ziel - Position)
        // Distanz ist nicht geringer als die Laufgeschwindigkeit
      } else {
        pos += dir * laufgeschwindigkeit;
        redirect(); // Anpassen der Laufrichtung an das Ziel
      }
      // Keine Wegpunkte mehr in der Liste: Distanz > als Laufgeschwindigkeit
    } else if (pos.dist(goal) > laufgeschwindigkeit) {
      pos += dir * laufgeschwindigkeit;
      // Keine Wegpunkte mehr in der Liste: Distanz < Laufgeschwindigkeit
    } else {
      pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
      fin = true; // Gegner wird gelöscht
    }
  }

  // Verarbeitung der Treffer an Feinde
  @override
  bool treffer(int schaden, int effekt) {
    var kill = false; //

    // Bekommt der Feind mehr Schaden als er Leben hat wird er gelöscht
    if (leben <= schaden) {
      leben = 0;
      fin = true; // Gegner wird gelöscht
      kill = true; // Gegner getötet
      // Feind hat mehr Leben als er Schaden bekommt
    } else {
      leben -= schaden; // Schaden vom Leben abziehen
      if (schaden > 0) {
        _hit = 1;
      }
    }

// Verlangsamungseffekt
    switch (effekt) {
      case 1:
        laufgeschwindigkeit = 3;
        slowtime = 35;
        break;
      case 2:
        laufgeschwindigkeit = 7;
        break;
      case 3:
        countDOT = 30;
        break;
      case 4:
        countDOT = 50;
        break;
      default:
    }
    return kill; // Rückgabe, ob der Feind getötet wurde
  }

  // Anpassung der Richtung während der Laufzeit
  @override
  void redirect() {
    dir = (goal - pos).uni();
  }

  @override
  void setWay(List<dynamic> w) {
    way = w;
    goal = way[0]; // Nächster Wegpunkt wird als Ziel gesetzt
    pos = goal; // Erster Wegpunkt wird als die aktuelle Position gesetzt
  }
}

/// Feindklasse HSV
class HSV implements Feinde {
  @override
  String name = 'hsv';
  @override
  bool boss;
  @override
  num id;
  @override
  int laufgeschwindigkeit;
  @override
  int leben;
  @override
  Position pos;
  @override
  Position dir;
  @override
  List<dynamic> way;
  @override
  Position goal;
  @override
  bool fin = false;
  @override
  num wert;
  @override
  int _hit = 0;
  @override
  int slowtime = 0;
  @override
  int countDOT = 0;
  @override
  int abstand;

  @override
  bool get hitted => _hit >= 1 && _hit <= 10;

  /// Constructor
  HSV(Map<String, dynamic> data, int anzFeinde) {
    id = data['id'];
    pos = Position(0, 0); // Position in x und y Koordinaten
    dir = Position(0, 0); // Richtung in x und y Koordinaten
    boss = data['boss'];
    leben =
        (boss ? 200 : 10); // Falls Feind ein Boss ist hat er 200 Lebenspunkte
    // Falls Feind ein Boss ist hat er 2 Laufgeschwindigkeit
    laufgeschwindigkeit = boss ? 2 : 5;
    wert = boss ? 50 : 10;
    abstand = data['abstand'];
  }

  void onSpawn(int anzFeinde) => leben += anzFeinde * 5;

  @override
  // Bewegen der Feinde
  void bewegen() {
    if (_hit >= 1) {
      _hit++;
    }
    //Schaden über Zeit
    if (countDOT > 0) {
      countDOT--;
      if (countDOT % 10 == 0) treffer(1, 0);
    }
    // Falls von Verlangsamungseffekt betroffen -> Cooldown
    if (slowtime <= 0) {
      treffer(0, 2);
    } else {
      slowtime--;
    }

    // Abfrage ob noch Wegpunkte in der Liste sind
    if (way.isNotEmpty) {
      // Abfrage ob die Distanz geringer als die Laufgeschwindigkeit ist
      if (pos.dist(goal) <= laufgeschwindigkeit) {
        pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
        goal = way[0]; // Nächster Zielpunkt wird als Ziel gesetzt
        way.removeAt(0); // Zielpunkt wird aus der Liste gelöscht
        dir = (goal - pos)
            .uni(); // Richtung = Einheitsvektor von (Ziel - Position)
        // Distanz ist nicht geringer als die Laufgeschwindigkeit
      } else {
        pos += dir * laufgeschwindigkeit;
        redirect(); // Anpassen der Laufrichtung an das Ziel
      }
      // Keine Wegpunkte mehr in der Liste: Distanz > als Laufgeschwindigkeit
    } else if (pos.dist(goal) > laufgeschwindigkeit) {
      pos += dir * laufgeschwindigkeit;
      // Keine Wegpunkte mehr in der Liste: Distanz < Laufgeschwindigkeit
    } else {
      pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
      fin = true; // Gegner wird gelöscht
    }
  }

  // Verarbeitung der Treffer an Feinde
  @override
  bool treffer(int schaden, int effekt) {
    var kill = false; //

    // Bekommt der Feind mehr Schaden als er Leben hat wird er gelöscht
    if (leben <= schaden) {
      leben = 0;
      fin = true; // Gegner wird gelöscht
      kill = true; // Gegner getötet
      // Feind hat mehr Leben als er Schaden bekommt
    } else {
      leben -= schaden; // Schaden vom Leben abziehen
      if (schaden > 0) {
        _hit = 1;
      }
    }

    // Verlangsamungseffekt
    switch (effekt) {
      case 1:
        laufgeschwindigkeit = boss ? 1 : 2;
        slowtime = boss ? 20 : 35;
        break;
      case 2:
        laufgeschwindigkeit = boss ? 2 : 5;
        break;
      case 3:
        countDOT = 30;
        break;
      case 4:
        countDOT = 50;
        break;
      default:
    }
    return kill; // Rückgabe, ob der Feind getötet wurde
  }

  // Anpassung der Richtung während der Laufzeit
  @override
  void redirect() {
    dir = (goal - pos).uni();
  }

  @override
  void setWay(List<dynamic> w) {
    way = w;
    goal = way[0]; // Nächster Wegpunkt wird als Ziel gesetzt
    pos = goal; // Erster Wegpunkt wird als die aktuelle Position gesetzt
  }
}

/// Feindklasse Clostridien
class Clostridien implements Feinde {
  @override
  String name = 'clostridien';
  @override
  bool boss;
  @override
  num id;
  @override
  int laufgeschwindigkeit;
  @override
  int leben;
  @override
  Position pos;
  @override
  Position dir;
  @override
  List<dynamic> way;
  @override
  Position goal;
  @override
  bool fin = false;
  @override
  num wert;
  @override
  int _hit = 0;
  @override
  int slowtime = 0;
  @override
  int countDOT = 0;
  @override
  int abstand;

  @override
  bool get hitted => _hit >= 1 && _hit <= 10;

  /// Constructor
  Clostridien(Map<String, dynamic> data) {
    id = data['id'];
    pos = Position(0, 0); // Position in x und y Koordinaten
    dir = Position(0, 0); // Richtung in x und y Koordinaten
    boss = data['boss'];
    leben = boss ? 50 : 5; // Falls Feind ein Boss ist hat er 200 Lebenspunkte
    // Falls Feind ein Boss ist hat er 2 Laufgeschwindigkeit
    laufgeschwindigkeit = boss ? 4 : 8;
    wert = boss ? 25 : 5;
    abstand = data['abstand'];
  }

  @override
  // Bewegen der Feinde
  void bewegen() {
    if (_hit >= 1) {
      _hit++;
    }
    //Schaden über Zeit
    if (countDOT > 0) {
      countDOT--;
      if (countDOT % 10 == 0) treffer(1, 0);
    }
    // Falls von Verlangsamungseffekt betroffen -> Cooldown
    if (slowtime <= 0) {
      treffer(0, 2);
    } else {
      slowtime--;
    }

    // Abfrage ob noch Wegpunkte in der Liste sind
    if (way.isNotEmpty) {
      // Abfrage ob die Distanz geringer als die Laufgeschwindigkeit ist
      if (pos.dist(goal) <= laufgeschwindigkeit) {
        pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
        goal = way[0]; // Nächster Zielpunkt wird als Ziel gesetzt
        way.removeAt(0); // Zielpunkt wird aus der Liste gelöscht
        dir = (goal - pos)
            .uni(); // Richtung = Einheitsvektor von (Ziel - Position)
        // Distanz ist nicht geringer als die Laufgeschwindigkeit
      } else {
        pos += dir * laufgeschwindigkeit;
        redirect(); // Anpassen der Laufrichtung an das Ziel
      }
      // Keine Wegpunkte mehr in der Liste: Distanz > als Laufgeschwindigkeit
    } else if (pos.dist(goal) > laufgeschwindigkeit) {
      pos += dir * laufgeschwindigkeit;
      // Keine Wegpunkte mehr in der Liste: Distanz < Laufgeschwindigkeit
    } else {
      pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
      fin = true; // Gegner wird gelöscht
    }
  }

  // Verarbeitung der Treffer an Feinde
  @override
  bool treffer(int schaden, int effekt) {
    var kill = false; //

    // Bekommt der Feind mehr Schaden als er Leben hat wird er gelöscht
    if (leben <= schaden) {
      leben = 0;
      fin = true; // Gegner wird gelöscht
      kill = true; // Gegner getötet
      // Feind hat mehr Leben als er Schaden bekommt
    } else {
      leben -= schaden; // Schaden vom Leben abziehen
      if (schaden > 0) {
        _hit = 1;
      }
    }

    // Verlangsamungseffekt
    switch (effekt) {
      case 1:
        laufgeschwindigkeit = boss ? 2 : 3;
        slowtime = boss ? 20 : 35;
        break;
      case 2:
        laufgeschwindigkeit = boss ? 4 : 7;
        break;
      case 3:
        countDOT = 30;
        break;
      case 4:
        countDOT = 50;
        break;
      default:
    }
    return kill; // Rückgabe, ob der Feind getötet wurde
  }

  // Anpassung der Richtung während der Laufzeit
  @override
  void redirect() {
    dir = (goal - pos).uni();
  }

  @override
  void setWay(List<dynamic> w) {
    way = w;
    goal = way[0]; // Nächster Wegpunkt wird als Ziel gesetzt
    pos = goal; // Erster Wegpunkt wird als die aktuelle Position gesetzt
  }
}
