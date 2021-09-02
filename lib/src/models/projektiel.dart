part of ImmunityTD;

abstract class Projektiel {
  String name; // Name des Feindtyps
  int id; // Identifikationsnummer des Feindes
  int fluggeschwindigkeit; // Bewegungsgeschwindingkeit des Feindes
  Position pos; // aktuelle Position
  Position dir; // aktuelle Richtung
  Feinde enemy; // aktueller Zielpunkt
  bool fin; // ziel erreicht
  bool flying; // Projektiel fliegt
  num dmg;
  // bool -> Gegner am Leben, verarbeitung von Schaden und Effekt bei treffer
  num fly(); // Bewegung der Feinde
  void redirect(); // Anpassung der Richtung während der Laufzeit
}

class Blutschuss implements Projektiel {
  // Feindklasse Corona
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

  Blutschuss(
      // Constructor
      int id,
      Position posi,
      Feinde goal,
      int eff,
      int schaden) {
    this.id = id;
    pos = posi; // Position in x und y Koordinaten
    enemy = goal;
    dir = (enemy.pos - pos).uni(); // Richtung in x und y Koordinaten
    dmg = schaden;
    // Falls Feind ein Boss ist hat er 2 Laufgeschwindigkeit
    fluggeschwindigkeit = 10;
    effect = eff;
  }

  @override
  // Bewegen der Feinde
  num fly() {
    var kill = 0;
    var goal = enemy.pos + Position(17, 17);
    // Abfrage ob die Distanz geringer als die Laufgeschwindigkeit ist
    if (pos.dist(goal) <= fluggeschwindigkeit) {
      pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
      if (enemy.treffer(dmg, effect)) kill = enemy.wert;
      fin = true;
      // Distanz ist nicht geringer als die Laufgeschwindigkeit
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

class Luftschuss implements Projektiel {
  // Feindklasse Corona
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

  Luftschuss(
      // Constructor
      int id,
      Position posi,
      Feinde goal,
      int eff,
      int schaden) {
    this.id = id;
    pos = posi; // Position in x und y Koordinaten
    enemy = goal;
    dir = (enemy.pos - pos).uni(); // Richtung in x und y Koordinaten
    dmg = schaden;
    // Falls Feind ein Boss ist hat er 2 Laufgeschwindigkeit
    fluggeschwindigkeit = 10;
    effect = eff;
  }

  @override
  // Bewegen der Projektiele
  num fly() {
    var kill = 0;
    var goal = enemy.pos + Position(17, 17);
    // Abfrage ob die Distanz geringer als die Laufgeschwindigkeit ist
    if (pos.dist(goal) <= fluggeschwindigkeit) {
      pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
      if (enemy.treffer(dmg, effect)) kill = enemy.wert;
      fin = true;
      // Distanz ist nicht geringer als die Laufgeschwindigkeit
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

class Augenschuss implements Projektiel {
  // Feindklasse Corona
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

  Augenschuss(
      // Constructor
      int id,
      Position posi,
      Feinde goal,
      int eff,
      int schaden) {
    this.id = id;
    pos = posi; // Position in x und y Koordinaten
    enemy = goal;
    dir = (enemy.pos - pos).uni(); // Richtung in x und y Koordinaten
    dmg = schaden;
    // Falls Feind ein Boss ist hat er 2 Laufgeschwindigkeit
    fluggeschwindigkeit = 20;
    effect = eff;
  }

  @override
  // Bewegen der Feinde
  num fly() {
    var kill = 0;
    var goal = enemy.pos + Position(17, 17);
    // Abfrage ob die Distanz geringer als die Laufgeschwindigkeit ist
    if (pos.dist(goal) <= fluggeschwindigkeit) {
      pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
      if (enemy.treffer(dmg, effect)) kill = enemy.wert;
      fin = true;
      // Distanz ist nicht geringer als die Laufgeschwindigkeit
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

class Herzschuss implements Projektiel {
  // Feindklasse Corona
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

  Herzschuss(
      // Constructor
      int id,
      Position posi,
      Feinde goal,
      int eff,
      int schaden) {
    this.id = id;
    pos = posi; // Position in x und y Koordinaten
    enemy = goal;
    dir = (enemy.pos - pos).uni(); // Richtung in x und y Koordinaten
    dmg = schaden;
    // Falls Feind ein Boss ist hat er 2 Laufgeschwindigkeit
    fluggeschwindigkeit = 10;
    effect = eff;
  }

  @override
  // Bewegen der Feinde
  num fly() {
    var kill = 0;
    var goal = enemy.pos + Position(17, 17);
    // Abfrage ob die Distanz geringer als die Laufgeschwindigkeit ist
    if (pos.dist(goal) <= fluggeschwindigkeit) {
      pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
      if (enemy.treffer(dmg, effect)) kill = enemy.wert;
      fin = true;
      // Distanz ist nicht geringer als die Laufgeschwindigkeit
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

class Nierenschuss implements Projektiel {
  // Feindklasse Corona
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

  Nierenschuss(
      // Constructor
      int id,
      Position posi,
      Feinde goal,
      int eff,
      int schaden) {
    this.id = id;
    pos = posi; // Position in x und y Koordinaten
    enemy = goal;
    dir = (enemy.pos - pos).uni(); // Richtung in x und y Koordinaten
    dmg = schaden;
    // Falls Feind ein Boss ist hat er 2 Laufgeschwindigkeit
    fluggeschwindigkeit = 10;
    effect = eff;
  }

  @override
  // Bewegen der Feinde
  num fly() {
    var kill = 0;
    var goal = enemy.pos + Position(17, 17);
    // Abfrage ob die Distanz geringer als die Laufgeschwindigkeit ist
    if (pos.dist(goal) <= fluggeschwindigkeit) {
      pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
      if (enemy.treffer(dmg, effect)) kill = enemy.wert;
      fin = true;
      // Distanz ist nicht geringer als die Laufgeschwindigkeit
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
