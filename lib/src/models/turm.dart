part of ImmunityTD;

abstract class Turm {
  String name;
  int id;
  int angriffsgeschwindigkeit;
  int agcount;
  int schaden;
  int reichweite;
  int level;
  int kosten;
  int effekt;
  Position position;

  void upgrade();
  bool angriff(List<Feinde> feinde);
}

class Blutzelle implements Turm {
  @override
  String name = 'blutzelle';
  @override
  int id;
  @override
  int angriffsgeschwindigkeit = 15;
  @override
  int agcount = 15;
  @override
  int schaden = 5;
  @override
  int reichweite = 100;
  @override
  int level = 1;
  @override
  int kosten = 50;
  @override
  int effekt = 0;
  @override
  Position position;

  Blutzelle(int lvl, Position pos, int i) {
    while (lvl > 1) {
      upgrade();
      lvl--;
    }
    position = pos;
    id = i;
  }

  @override
  void upgrade() {
    switch (level) {
      case 2:
        angriffsgeschwindigkeit = 5;
        break;
      case 3:
        schaden = 10;
        break;
      default:
    }
  }

  @override
  bool angriff(List<Feinde> feinde) {
    var kill = false;
    if (agcount <= 0) {
      for (var f in feinde) {
        if (position.dist(f.pos) <= reichweite) {
          kill = f.treffer(schaden, effekt);
          print('attack');
          agcount = angriffsgeschwindigkeit;
          break;
        }
      }
    }
    agcount--;
    print('$kill');
    return kill;
  }

}
