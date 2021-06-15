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
  bool fly(); // Bewegung der Feinde
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
      Feinde goal, int eff) {
    this.id = id;
    pos = posi; // Position in x und y Koordinaten
    enemy = goal;
    dir = (enemy.pos - pos).uni(); // Richtung in x und y Koordinaten
    // Falls Feind ein Boss ist hat er 2 Laufgeschwindigkeit
    fluggeschwindigkeit = 10;
    effect = eff;
  }

  @override
  // Bewegen der Feinde
  bool fly() {
    var kill = false;
    var goal = enemy.pos + Position(17, 17);
      // Abfrage ob die Distanz geringer als die Laufgeschwindigkeit ist
      if (pos.dist(goal) <= fluggeschwindigkeit) {
        pos = goal; // angepeilter Wegpunkt wird zur aktuellen Position
        kill = enemy.treffer(dmg, 0);
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
