part of ImmunityTD;

class Controller {
  Level model;
  int spawncount = 25;

  View view = new View();

  Controller() {
    main();
  }

  void main() async {
    model = new Level(50, [
      new Lunge(5, 1, 1, 1, 1, 1)
    ], [
      [
        new Corona(0, 0, 0, 10, 0, false, [new Position(100, 200)]),
        new Corona(1, 0, 0, 10, 0, false, [new Position(200, 100)]),
        new Corona(2, 0, 0, 10, 0, false, [new Position(200, 100)]),
        new Corona(3, 0, 0, 10, 0, false, [new Position(200, 100)]),
        new Corona(4, 0, 0, 10, 0, false, [new Position(200, 100)]),
        new Corona(5, 0, 0, 10, 0, false, [new Position(200, 100)]),
        new Corona(6, 0, 0, 10, 0, false, [new Position(200, 100)]),
        new Corona(7, 0, 0, 10, 0, false, [new Position(200, 100)]),
        new Corona(8, 0, 0, 10, 0, false, [new Position(100, 200)]),
        new Corona(9, 0, 0, 10, 0, false, [new Position(200, 100)])
      ]
    ], [
      new Antibiotika(50, 4, 10)
    ]);

    view.generateLevel();
    view.startButton.onClick.listen((_) {
      view.menu.style.display = "none";
      view.generateMap();
      view.setModel(model);
      view.generateInfobar();
      Timer.periodic(Duration(milliseconds: 100), (timer) {
        if (spawncount <= 0 && model.wellen.length > 0) {
          spawm();
          model.feinde.last.setWay(generateWay([
            new Position(0, 370),
            new Position(500, 340),
            new Position(510, 490),
            new Position(790, 480),
            new Position(810, 230),
            new Position(1100, 230),
            new Position(1110, 480),
            new Position(1520, 448)
          ]));
          spawncount = 25;
        }
        model.feindeBewegen();
        view.update();
        spawncount--;
        print("${model.leben}");
        if (model.gameOver) timer.cancel();
      });
    });
  }

  List<Position> generateWay(List<Position> relway) {
    num width = view.map.getBoundingClientRect().width.toDouble();
    num height = view.map.getBoundingClientRect().height.toDouble();
    List<Position> way = [];
    for (Position pos in relway)
      way.add(new Position((pos.x * width) / 1600, (pos.y * height) / 800));
    return way;
  }

  void spawm() {
    model.spawn();
    view.spawn(model.feinde.last);
  }
}
