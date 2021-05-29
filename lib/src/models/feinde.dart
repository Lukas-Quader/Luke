part of ImmunityTD;

abstract class Feinde {
  String name;
  bool boss;
  int id;
  int laufgeschwindigkeit;
  int leben;
  Position pos;
  Position dir;
  List<Position> way;
  Position goal;
  bool fin;

  bool treffer(int schaden, int effekt);
  void bewegen();
  void redirect();
  void setWay(List<Position> w);
}

class Corona implements Feinde {
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
      int id, int posx, int posy, int dx, int dy, bool boss, List<Position> w) {
    this.id = id;
    pos = Position(posx, posy);
    dir = Position(dx, dy);
    this.boss = boss;
    leben = 10;
    laufgeschwindigkeit = 5;
    way = w;
    if (way.isNotEmpty) {
      goal = way[0];
      way.removeAt(0);
    }
  }

  @override
  void bewegen() {
    if (way.isNotEmpty) {
      if (pos.dist(goal) <= laufgeschwindigkeit) {
        pos = goal;
        goal = way[0];
        way.removeAt(0);
        dir = (goal - pos).uni();
      } else {
        pos += dir * laufgeschwindigkeit;
        redirect();
      }
    } else if (pos.dist(goal) > laufgeschwindigkeit) {
      pos += dir * laufgeschwindigkeit;
    } else {
      pos = goal;
      fin = true;
    }
  }

  @override
  bool treffer(int schaden, int effekt) {
    var kill = false;
    if (leben <= schaden) {
      leben = 0;
      fin = true;
      kill = true;
    } else {
      leben -= schaden;
    }
    switch (effekt) {
      case 1:
        if (laufgeschwindigkeit == 5) laufgeschwindigkeit = 3;
        break;
      case 2:
        if (laufgeschwindigkeit != 5) laufgeschwindigkeit = 5;
        break;
      default:
    }
    return kill;
  }

  @override
  void redirect() {
    dir = (goal - pos).uni();
  }

  @override
  void setWay(List<Position> w) {
    way = w;
    goal = way[0];
    pos = goal;
  }
}
