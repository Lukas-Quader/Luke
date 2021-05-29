part of ImmunityTD;

class Controller {
  Level model;
  List<Level> levels;
  int spawncount = 25;

  View view = View();

  Controller() {
    main();
  }

  void main() async {
    num towers = 0;
    levels = loadLevelFromData();
    view.generateMenu(levels);
    num l = 0;
    view.buttons.onClick.listen((event) {
      if(event.target is Element) {
        Element button = event.target;
        for(num i = 1; i <= levels.length; i++) {
          if(button.id == 'box_level_$i'){
            l = i;
          }
        }
      }
    });
    view.startButton.onClick.listen((_) {
      if(l != 0) { 
        loadLevel(l);
        towers = setClickListenerForLevel(towers);
        Timer.periodic(Duration(milliseconds: 70), (timer) {
          if (spawncount <= 0 && model.wellen.isNotEmpty) {
            spawm();
            spawncount = 25;
          }
          model.turmAngriff();
          model.feindeBewegen();
          view.update(l, model.kaufen);
          spawncount--;
          if (model.gameOver) {
            timer.cancel();
            view.gameOver();
          } else if(model.win) {
            timer.cancel();
            view.win();
          }
        });
      }
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
  }

  void loadLevel(num level) {
    model = levels[level-1];
      view.menu.style.display = 'none';
      view.generateMap(model.kaufen);
      model.karte.felder = generateWay(model.karte.felder);
      view.setModel(model);
  }

  num setClickListenerForLevel(num towercount) {
    Element button;
        view.kaufButton.onClick.listen((event) {
          if(event.target is Element) {
            button = event.target;
          }
        });
        view.map.onClick.listen((ev) {
          var click = Position(ev.offset.x, ev.offset.y);
            if(model.karte.free() && button != null) {
              if (model.ak - int.parse(button.innerHtml.toString()) >= 0) {
                model.turmPlazieren(button.id, click, 1, towercount++);
                view.setTower(model.turm.last);
                model.buy();
              }
            }
        });
        return towercount;
  }

  List<Level> loadLevelFromData() {
    return [Level(
        50,
        [Blutzelle(1, Position(0, 0), 0)],
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
          ],
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
        Karte([Position(920, 340), Position(630, 340), Position(1220, 320)]))];
  }
}
