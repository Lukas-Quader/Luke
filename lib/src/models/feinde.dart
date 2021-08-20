part of ImmunityTD;

abstract class Feinde {
  String name; // Name des Feindtyps
  bool boss; // handelt es sich um einen Boss?
  int id; // Identifikationsnummer des Feindes
  int laufgeschwindigkeit; // Bewegungsgeschwindingkeit des Feindes
  int leben; // lebenspunkte des Feindes
  Position pos; // aktuelle Position
  Position dir; // aktuelle Richtung
  List<dynamic> way; // Liste der Wegpunkte
  Position goal; // aktueller Zielpunkt
  bool fin; // ziel erreicht
  num wert;
  int _hit = 0;
  int slowtime = 0;
  bool get hitted;
  // bool -> Gegner am Leben, verarbeitung von Schaden und Effekt bei treffer
  bool treffer(int schaden, int effekt);
  void bewegen(); // Bewegung der Feinde
  void redirect(); // Anpassung der Richtung während der Laufzeit
  void setWay(List<dynamic> w); //Setzen des Weges
}

class Corona implements Feinde {
  // Feindklasse Corona
  @override
  String name = 'corona';
  @override
  bool boss;
  @override
  int id;
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
  bool get hitted => _hit >= 1 && _hit <= 10;

  Corona(
      // Constructor
      Map<String, dynamic> data) {
    id = data['id'];
    pos = Position(0, 0); // Position in x und y Koordinaten
    dir = Position(0, 0); // Richtung in x und y Koordinaten
    boss = data['boss'];
    leben = boss ? 200 : 10; // Falls Feind ein Boss ist hat er 200 Lebenspunkte
    // Falls Feind ein Boss ist hat er 2 Laufgeschwindigkeit
    laufgeschwindigkeit = boss ? 2 : 5;
    wert = boss ? 50 : 10;
  }

  @override
  // Bewegen der Feinde
  void bewegen() {
    if (_hit >= 1) {
      _hit++;
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
    //way.removeAt(0); // Wegpunkt wird gelöscht
    goal = way[0]; // Nächster Wegpunkt wird als Ziel gesetzt
    pos = goal; // Erster Wegpunkt wird als die aktuelle Position gesetzt
  }
}

class MRSA implements Feinde {
  // Feindklasse Corona
  @override
  String name = 'mrsa';
  @override
  bool boss;
  @override
  int id;
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
  bool get hitted => _hit >= 1 && _hit <= 10;

  MRSA(
      // Constructor
      Map<String, dynamic> data) {
    id = data['id'];
    pos = Position(0, 0); // Position in x und y Koordinaten
    dir = Position(0, 0); // Richtung in x und y Koordinaten
    boss = data['boss'];
    leben = boss ? 200 : 5; // Falls Feind ein Boss ist hat er 200 Lebenspunkte
    // Falls Feind ein Boss ist hat er 2 Laufgeschwindigkeit
    laufgeschwindigkeit = boss ? 2 : 5;
    wert = boss ? 60 : 20;
  }

  @override
  // Bewegen der Feinde
  void bewegen() {
    if (_hit >= 1) _hit++;

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
    //way.removeAt(0); // Wegpunkt wird gelöscht
    goal = way[0]; // Nächster Wegpunkt wird als Ziel gesetzt
    pos = goal; // Erster Wegpunkt wird als die aktuelle Position gesetzt
  }
}

class Grippe implements Feinde {
  // Feindklasse Grippe
  @override
  String name = 'grippe';
  @override
  bool boss;
  @override
  int id;
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
  bool get hitted => _hit >= 1 && _hit <= 10;

  Grippe(
      // Constructor
      Map<String, dynamic> data) {
    id = data['id'];
    pos = Position(0, 0); // Position in x und y Koordinaten
    dir = Position(0, 0); // Richtung in x und y Koordinaten
    boss = data['boss'];
    leben = boss ? 200 : 10; // Falls Feind ein Boss ist hat er 200 Lebenspunkte
    // Falls Feind ein Boss ist hat er 2 Laufgeschwindigkeit
    laufgeschwindigkeit = boss ? 2 : 5;
    wert = boss ? 50 : 10;
  }

  @override
  // Bewegen der Feinde
  void bewegen() {
    if (_hit >= 1) {
      _hit++;
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
    //way.removeAt(0); // Wegpunkt wird gelöscht
    goal = way[0]; // Nächster Wegpunkt wird als Ziel gesetzt
    pos = goal; // Erster Wegpunkt wird als die aktuelle Position gesetzt
  }
}

class HSV implements Feinde {
  // Feindklasse HSV
  @override
  String name = 'hsv';
  @override
  bool boss;
  @override
  int id;
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
  bool get hitted => _hit >= 1 && _hit <= 10;

  HSV(
      // Constructor
      Map<String, dynamic> data) {
    id = data['id'];
    pos = Position(0, 0); // Position in x und y Koordinaten
    dir = Position(0, 0); // Richtung in x und y Koordinaten
    boss = data['boss'];
    leben = boss ? 200 : 10; // Falls Feind ein Boss ist hat er 200 Lebenspunkte
    // Falls Feind ein Boss ist hat er 2 Laufgeschwindigkeit
    laufgeschwindigkeit = boss ? 2 : 5;
    wert = boss ? 50 : 10;
  }

  @override
  // Bewegen der Feinde
  void bewegen() {
    if (_hit >= 1) {
      _hit++;
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
    //way.removeAt(0); // Wegpunkt wird gelöscht
    goal = way[0]; // Nächster Wegpunkt wird als Ziel gesetzt
    pos = goal; // Erster Wegpunkt wird als die aktuelle Position gesetzt
  }
}

class Clostridien implements Feinde {
  // Feindklasse Clostridien
  @override
  String name = 'clostridien';
  @override
  bool boss;
  @override
  int id;
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
  bool get hitted => _hit >= 1 && _hit <= 10;

  Clostridien(
      // Constructor
      Map<String, dynamic> data) {
    id = data['id'];
    pos = Position(0, 0); // Position in x und y Koordinaten
    dir = Position(0, 0); // Richtung in x und y Koordinaten
    boss = data['boss'];
    leben = boss ? 200 : 10; // Falls Feind ein Boss ist hat er 200 Lebenspunkte
    // Falls Feind ein Boss ist hat er 2 Laufgeschwindigkeit
    laufgeschwindigkeit = boss ? 2 : 5;
    wert = boss ? 50 : 10;
  }

  @override
  // Bewegen der Feinde
  void bewegen() {
    if (_hit >= 1) {
      _hit++;
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
    //way.removeAt(0); // Wegpunkt wird gelöscht
    goal = way[0]; // Nächster Wegpunkt wird als Ziel gesetzt
    pos = goal; // Erster Wegpunkt wird als die aktuelle Position gesetzt
  }
}
