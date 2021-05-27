part of ImmunityTD;

class Controller {
  Level model;
  int spawncount = 25;

  View view = new View();

  Controller() {
    model = new Level(
        50,
        [new Lunge(5, 1, 1, 1, 1, 1)],
        [
          [
            new Corona(0, 0, 0, 10, 0, false, [new Position(100, 200)]),
            new Corona(1, 0, 0, 10, 0, false, [new Position(200, 100)]),
            new Corona(2, 0, 0, 10, 0, false, [new Position(200, 100)]),
            new Corona(3, 0, 0, 10, 0, false, [new Position(200, 100)]),
            new Corona(4, 0, 0, 10, 0, false, [new Position(200, 100)]),
            new Corona(5, 0, 0, 10, 0, false, [new Position(200, 100)]),
            new Corona(6, 0, 0, 10, 0, false, [new Position(200, 100)]),
            new Corona(7, 0, 0, 10, 0, false, [new Position(200, 100)])
          ]
        ],
        [new Antibiotika(50, 4, 10)]);

    view.generateLevel();
    view.startButton.onClick.listen((_) {
      view.menu.style.display = "none";
      view.generateMap();
      view.setModel(model);
      List<Position> way = [new Position(0, 420), new Position(540, 390), new Position(550, 530), new Position(830, 520), new Position(850, 270), new Position(1140, 270), new Position(1150, 520), new Position(1600, 488)];
      Timer.periodic(Duration(milliseconds: 100), (timer) {
        if(spawncount <= 0) {
          model.feindeBewegen(true);
          model.feinde.last.way = way;
          model.feinde.last.redirect();
          view.spawn(model.feinde.last);
          spawncount = 25;
        } else {
          model.feindeBewegen(false);
        }
        view.update();
        spawncount--;
        if (model.gameOver) timer.cancel();
      });
    });
  }
  List<Position> generateWay(List<Position> relway) {
    int width = view.map.getBoundingClientRect().width.toInt();
    int height = view.map.getBoundingClientRect().height.toInt();
    List<Position> way;
    for(Position pos in relway) way.add(new Position(pos.x * 1600 / width, pos.y * 800 / height));
  }
}
