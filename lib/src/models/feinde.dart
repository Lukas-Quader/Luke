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

  void treffer(int schaden, int effekt);
  void bewegen();
  int getLaufgeschwindigkeit();
  void setLaufgeschwindigkeit(int geschw);
  Position getPos();
  void setPos(Position p);
  Position getDir();
  void setDir(Position d);
  void redirect();
}

class Corona implements Feinde {
  String name = 'corona';
  bool boss;
  int id;
  int laufgeschwindigkeit;
  int leben;
  Position pos;
  Position dir;
  List<Position> way;
  Position goal;
  bool fin = false;

  Corona(
      int id, int posx, int posy, int dx, int dy, bool boss, List<Position> w) {
    this.id = id;
    pos = new Position(posx, posy);
    dir = new Position(dx, dy);
    this.boss = boss;
    leben = 10;
    laufgeschwindigkeit = 5;
    way = w;
    if (!way.isEmpty) {
      goal = way[0];
      way.removeAt(0);
    }
  }

  void bewegen() {
    if(!way.isEmpty) {
      if(pos.dist(goal) <= laufgeschwindigkeit) {
        Position extra = (pos+(dir*laufgeschwindigkeit) - goal);
        pos = goal;
        goal = way[0];
        way.removeAt(0);
        dir = (goal - pos).uni();
        pos += dir * extra.length();
      }
      else {
        pos += dir*laufgeschwindigkeit;
      }
    } 
    else if(pos.dist(goal) > laufgeschwindigkeit) pos += dir*laufgeschwindigkeit;
    else {
      pos = goal;
      fin = true;
    }
  }

  void treffer(int schaden, int effekt) {
    if(leben <= schaden) leben = 0;
    else leben -= schaden;
    switch (effekt) {
      case 1:
        if(laufgeschwindigkeit == 5) laufgeschwindigkeit = 3;
        break;
      case 2:
        if(laufgeschwindigkeit != 5) laufgeschwindigkeit = 5;
        break;
      default:
    }
  }

  int getLaufgeschwindigkeit() {
    return laufgeschwindigkeit;
  }

  void setLaufgeschwindigkeit(int geschw) {
    laufgeschwindigkeit = geschw;
  }

  Position getPos() {
    return pos;
  }

  void setPos(Position p) {
    pos = p;
  }

  Position getDir() {
    return dir;
  }

  void setDir(Position d) {
    dir = d;
  }

  void redirect() {
    dir = (goal - pos).uni();
  }
}
