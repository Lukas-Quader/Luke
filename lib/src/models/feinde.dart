part of ImmunityTD;

abstract class Feinde {
  String name; // Name des Feindtyps
  bool boss; // handelt es sich um einen Boss?
  int id; // Identifikationsnummer des Feindes
  int laufgeschwindigkeit; // Bewegungsgeschwindingkeit des Feindes
  int leben; // lebenspunkte des Feindes
  Position pos; // aktuelle Position
  Position dir; // aktuelle Richtung
  List<Position> way; // Liste der Wegpunkte
  Position goal; // aktueller Zielpunkt
  bool fin; // ziel erreicht
  // bool -> Gegner am Leben, verarbeitung von Schaden und Effekt bei treffer
  bool treffer(int schaden, int effekt);
  void bewegen(); // Bewegung der Feinde
  void redirect(); // Anpassung der Richtung während der Laufzeit
  void setWay(List<Position> w); //Setzen des Weges
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
  List<Position> way;
  @override
  Position goal;
  @override
  bool fin = false;

  Corona(
      // Constructor
      int id,
      int posx,
      int posy,
      int dx,
      int dy,
      bool boss) {
    this.id = id;
    pos = Position(posx, posy); // Position in x und y Koordinaten
    dir = Position(dx, dy); // Richtung in x und y Koordinaten
    this.boss = boss;
    leben = boss ? 200 : 10; // Falls Feind ein Boss ist hat er 200 Lebenspunkte
    // Falls Feind ein Boss ist hat er 2 Laufgeschwindigkeit
    laufgeschwindigkeit = boss ? 2 : 5;
  }

  @override
  // Bewegen der Feinde
  void bewegen() {
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
    }
    // Verlangsamungseffekt
    switch (effekt) {
      case 1:
        if (laufgeschwindigkeit == 5) laufgeschwindigkeit = 3;
        break;
      case 2:
        if (laufgeschwindigkeit != 5) laufgeschwindigkeit = 5;
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
  void setWay(List<Position> w) {
    way = w;
    //way.removeAt(0); // Wegpunkt wird gelöscht
    goal = way[0]; // Nächster Wegpunkt wird als Ziel gesetzt
    pos = goal; // Erster Wegpunkt wird als die aktuelle Position gesetzt
  }
}
