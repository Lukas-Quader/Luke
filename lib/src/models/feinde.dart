part of ImmunityTD;

abstract class Feinde {
  void treffer(int schaden, int effekt);
  void bewegen();
  int getLaufgeschwindigkeit();
  void setLaufgeschwindigkeit(int geschw);
  Position getPos();
  void setPos(Position p);
  Position getDir();
  void setDir(Position d);
}

class Corona implements Feinde {
  bool boss;
  int id;
  int laufgeschwindigkeit;
  int leben;
  Position pos;
  Position dir;
  List<Position> way;
  Position goal;

  Corona(
      int id, int posx, int posy, int dx, int dy, bool boss, List<Position> w) {
    this.id = id;
    pos = new Position(posx, posy);
    dir = new Position(dx, dy);
    this.boss = boss;
    leben = 10;
    laufgeschwindigkeit = 5;
    way = w;
    if (!way.isEmpty) goal = way[0];
  }

  void bewegen() {
    // TODO: implement bewegen
  }

  void treffer(int schaden, int effekt) {
    // TODO: implement treffer
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
}
