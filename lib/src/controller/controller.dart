part of ImmunityTD;

class Controller {
  Level model;
  int spawncount = 25;

  View view = View();

  Controller() {
    main();
  }

  void main() async {
    model = Level(
        50,
        ['Blutzelle'],
        [
          [
            Corona(0, 0, 0, 10, 0, false, [Position(100, 200)]),
            Corona(1, 0, 0, 10, 0, false, [Position(200, 100)]),
            Corona(2, 0, 0, 10, 0, false, [Position(200, 100)]),
            Corona(3, 0, 0, 10, 0, false, [Position(200, 100)]),
            Corona(4, 0, 0, 10, 0, false, [Position(200, 100)]),
            Corona(5, 0, 0, 10, 0, false, [Position(200, 100)]),
            Corona(6, 0, 0, 10, 0, false, [Position(200, 100)]),
            Corona(7, 0, 0, 10, 0, false, [Position(200, 100)]),
            Corona(8, 0, 0, 10, 0, false, [Position(100, 200)]),
            Corona(9, 0, 0, 10, 0, false, [Position(200, 100)])
          ]
        ],
        [Antibiotika(50, 4, 10)],
        Karte([Position(885, 325)]));

    view.generateLevel();
    view.startButton.onClick.listen((_) {
      view.menu.style.display = 'none';
      view.generateMap();
      model.karte.felder = generateWay(model.karte.felder);
      view.setModel(model);
      model.turmPlazieren('Blutzelle', Position(200, 200), 1, 0);
      view.setTower(model.turm.last);
      Timer.periodic(Duration(milliseconds: 100), (timer) {
        if (spawncount <= 0 && model.wellen.length > 0) {
          spawm();
          model.feinde.last.setWay(generateWay([
            Position(0, 370),
            Position(500, 340),
            Position(510, 490),
            Position(790, 480),
            Position(810, 230),
            Position(1100, 230),
            Position(1110, 480),
            Position(1520, 448)
          ]));
          spawncount = 25;
        }
        model.feindeBewegen();
        model.turmAngriff();
        view.update();
        spawncount--;
        if (model.gameOver) timer.cancel();
      });
    });
  }

  List<Position> generateWay(List<Position> relway) {
    num width = view.map.getBoundingClientRect().width.toDouble();
    num height = view.map.getBoundingClientRect().height.toDouble();
    var way = <Position>[];
    for (var pos in relway) {
      way.add(Position((pos.x * width) / 1600, (pos.y * height) / 800));
    }
    return way;
  }

  void spawm() {
    model.spawn();
    view.spawn(model.feinde.last);
  }
}
