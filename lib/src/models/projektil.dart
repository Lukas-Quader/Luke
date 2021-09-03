part of ImmunityTD;

abstract class Projektil {
  /// Name des Feindtyps
  String name;

  /// Identifikationsnummer des Feindes
  int id;

  /// Bewegungsgeschwindingkeit des Feindes
  int fluggeschwindigkeit;

  /// aktuelle Position
  Position pos;

  /// aktuelle Richtung
  Position dir;

  /// aktueller Zielpunkt
  Feinde enemy;

  /// ziel erreicht
  bool fin;

  /// Projektil fliegt
  bool flying;
  // bool -> Gegner am Leben, verarbeitung von Schaden und Effekt bei treffer
  ///Schaden des Projektils
  num dmg;

  /// Bewegung der Projektile
  num fly();

  /// Anpassung der Richtung während der Laufzeit
  void redirect();
}

/// Projektilklasse Blutschuss
class Blutschuss implements Projektil {
  @override
  String name = 'blutschuss';
  @override
  int id;
  @override
  int fluggeschwindigkeit;
  @override
  Position pos;
  @override
  Position dir;
  @override
  Feinde enemy;
  @override
  bool fin = false;
  @override
  bool flying = false;
  @override
  num dmg = 5;
  int effect = 0;

  /// Constructor
  Blutschuss(int id, Position posi, Feinde goal, int eff, int schaden) {
    this.id = id;
    pos = posi; // Position in x und y Koordinaten
    enemy = goal;
    dir = (enemy.pos - pos).uni(); // Richtung in x und y Koordinaten
    dmg = schaden;

    fluggeschwindigkeit = 10;
    effect = eff;
  }

  /// Bewegen der Projektile
  @override
  num fly() {
    var kill = 0;
    var goal = enemy.pos + Position(17, 17);
    // Abfrage ob die Distanz geringer als die Fluggeschwindigkeit ist
    if (pos.dist(goal) <= fluggeschwindigkeit) {
      pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
      if (enemy.treffer(dmg, effect)) kill = enemy.wert;
      fin = true;
      // Distanz ist nicht geringer als die Fluggeschwindigkeit
    } else {
      pos += dir * fluggeschwindigkeit;
      redirect(); // Anpassen der Laufrichtung an das Ziel
    }
    return kill;
  }

  // Anpassung der Richtung während der Laufzeit
  @override
  void redirect() {
    dir = (enemy.pos + Position(17, 17) - pos).uni();
  }
}

/// Projektilklasse Luftschuss
class Luftschuss implements Projektil {
  @override
  String name = 'luftschuss';
  @override
  int id;
  @override
  int fluggeschwindigkeit;
  @override
  Position pos;
  @override
  Position dir;
  @override
  Feinde enemy;
  @override
  bool fin = false;
  @override
  bool flying = false;
  @override
  num dmg = 0;
  int effect = 0;

  /// Constructor
  Luftschuss(int id, Position posi, Feinde goal, int eff, int schaden) {
    this.id = id;
    pos = posi; // Position in x und y Koordinaten
    enemy = goal;
    dir = (enemy.pos - pos).uni(); // Richtung in x und y Koordinaten
    dmg = schaden;

    fluggeschwindigkeit = 10;
    effect = eff;
  }

  /// Bewegen der Projektile
  @override
  num fly() {
    var kill = 0;
    var goal = enemy.pos + Position(17, 17);
    // Abfrage ob die Distanz geringer als die Fluggeschwindigkeit ist
    if (pos.dist(goal) <= fluggeschwindigkeit) {
      pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
      if (enemy.treffer(dmg, effect)) kill = enemy.wert;
      fin = true;
      // Distanz ist nicht geringer als die Fluggeschwindigkeit
    } else {
      pos += dir * fluggeschwindigkeit;
      redirect(); // Anpassen der Laufrichtung an das Ziel
    }
    return kill;
  }

  // Anpassung der Richtung während der Laufzeit
  @override
  void redirect() {
    dir = (enemy.pos + Position(17, 17) - pos).uni();
  }
}

/// Projektilklasse
class Augenschuss implements Projektil {
  @override
  String name = 'augenschuss';
  @override
  int id;
  @override
  int fluggeschwindigkeit;
  @override
  Position pos;
  @override
  Position dir;
  @override
  Feinde enemy;
  @override
  bool fin = false;
  @override
  bool flying = false;
  @override
  num dmg = 0;
  int effect = 0;

  /// Constructor
  Augenschuss(int id, Position posi, Feinde goal, int eff, int schaden) {
    this.id = id;
    pos = posi; // Position in x und y Koordinaten
    enemy = goal;
    dir = (enemy.pos - pos).uni(); // Richtung in x und y Koordinaten
    dmg = schaden;

    fluggeschwindigkeit = 20;
    effect = eff;
  }

  /// Bewegen der Projektile
  @override
  num fly() {
    var kill = 0;
    var goal = enemy.pos + Position(17, 17);
    // Abfrage ob die Distanz geringer als die Fluggeschwindigkeit ist
    if (pos.dist(goal) <= fluggeschwindigkeit) {
      pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
      if (enemy.treffer(dmg, effect)) kill = enemy.wert;
      fin = true;
      // Distanz ist nicht geringer als die Fluggeschwindigkeit
    } else {
      pos += dir * fluggeschwindigkeit;
      redirect(); // Anpassen der Laufrichtung an das Ziel
    }
    return kill;
  }

  // Anpassung der Richtung während der Laufzeit
  @override
  void redirect() {
    dir = (enemy.pos + Position(17, 17) - pos).uni();
  }
}

/// Projektilklasse Herzschuss
class Herzschuss implements Projektil {
  @override
  String name = 'herzschuss';
  @override
  int id;
  @override
  int fluggeschwindigkeit;
  @override
  Position pos;
  @override
  Position dir;
  @override
  Feinde enemy;
  @override
  bool fin = false;
  @override
  bool flying = false;
  @override
  num dmg = 5;
  int effect = 0;

  /// Constructor
  Herzschuss(int id, Position posi, Feinde goal, int eff, int schaden) {
    this.id = id;
    pos = posi; // Position in x und y Koordinaten
    enemy = goal;
    dir = (enemy.pos - pos).uni(); // Richtung in x und y Koordinaten
    dmg = schaden;
    fluggeschwindigkeit = 10;
    effect = eff;
  }

  /// Bewegen der Projektile
  @override
  num fly() {
    var kill = 0;
    var goal = enemy.pos + Position(17, 17);
    // Abfrage ob die Distanz geringer als die Fluggeschwindigkeit ist
    if (pos.dist(goal) <= fluggeschwindigkeit) {
      pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
      if (enemy.treffer(dmg, effect)) kill = enemy.wert;
      fin = true;
      // Distanz ist nicht geringer als die Fluggeschwindigkeit
    } else {
      pos += dir * fluggeschwindigkeit;
      redirect(); // Anpassen der Laufrichtung an das Ziel
    }
    return kill;
  }

  // Anpassung der Richtung während der Laufzeit
  @override
  void redirect() {
    dir = (enemy.pos + Position(17, 17) - pos).uni();
  }
}

/// Projektilklasse Nierenschuss
class Nierenschuss implements Projektil {
  @override
  String name = 'nierenschuss';
  @override
  int id;
  @override
  int fluggeschwindigkeit;
  @override
  Position pos;
  @override
  Position dir;
  @override
  Feinde enemy;
  @override
  bool fin = false;
  @override
  bool flying = false;
  @override
  num dmg = 5;
  int effect = 0;

  /// Constructor
  Nierenschuss(int id, Position posi, Feinde goal, int eff, int schaden) {
    this.id = id;
    pos = posi; // Position in x und y Koordinaten
    enemy = goal;
    dir = (enemy.pos - pos).uni(); // Richtung in x und y Koordinaten
    dmg = schaden;
    fluggeschwindigkeit = 10;
    effect = eff;
  }

  @override

  /// Bewegen der Projektile
  num fly() {
    var kill = 0;
    var goal = enemy.pos + Position(17, 17);
    // Abfrage ob die Distanz geringer als die Fluggeschwindigkeit ist
    if (pos.dist(goal) <= fluggeschwindigkeit) {
      pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
      if (enemy.treffer(dmg, effect)) kill = enemy.wert;
      fin = true;
      // Distanz ist nicht geringer als die Fluggeschwindigkeit
    } else {
      pos += dir * fluggeschwindigkeit;
      redirect(); // Anpassen der Laufrichtung an das Ziel
    }
    return kill;
  }

  // Anpassung der Richtung während der Laufzeit
  @override
  void redirect() {
    dir = (enemy.pos + Position(17, 17) - pos).uni();
  }
}
