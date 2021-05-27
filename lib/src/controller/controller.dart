part of ImmunityTD;

class Controller {
  Level model;

  View view = new View();

  Controller() {
    model = new Level(
        50,
        [new Lunge(5, 1, 1, 1, 1, 1)],
        [
          [
            new Corona(0, 100, 100, 10, 0, false, [new Position(200, 100)]),
            new Corona(1, 200, 200, 10, 0, false, [new Position(200, 100)])
          ]
        ],
        view.field.querySelectorAll('td'),
        [0],
        [
          [new Position(50, 50)]
        ],
        [new Antibiotika(50, 4, 10)]);

    view.generateLevel();
    view.startButton.onClick.listen((_) {
      view.menu.style.display = "none";
      view.generateMap();
      Timer.periodic(Duration(milliseconds: 1000), (timer) {
        view.spawn(model.spawn());
        if (model.wellen.isEmpty) timer.cancel();
      });
    });
  }
}
