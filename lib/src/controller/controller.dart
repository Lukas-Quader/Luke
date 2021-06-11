part of ImmunityTD;

///Controller Klasse
///Sie bildet den Controller des Spiels ab
class Controller {
  //Variablen bekanntmachen und initialisieren
  Level model;
  List<Level> levels;
  int spawncount = 25;
  View view = View();

  ///Constructor
  ///Ruft die Main Methode auf
  Controller() {
    main();
  }

  ///Main Methode
  ///Sie ist der Eintrittspunkt in das Spiel
  void main() {
    //Variable um den Türmen ihre ID zu geben
    num towers = 0;
    //Die Level werden geladen
    levels = loadLevelFromData();
    //Die Level werden an das Menü in der View übergeben
    view.generateMenu(levels);
    //Variable um das gewählte Level zu speichern
    num l = 0;
    //Onclick listener welches Level gewählt wird
    view.buttons.onClick.listen((event) {
      if (event.target is Element) {
        //merken welches Level gewählt wird
        Element button = event.target;
        //Schleife um zu prüfen welches Level gewählt wurde
        for (num i = 1; i <= levels.length; i++) {
          if (button.id == 'box_level_$i') {
            //merken des Levels
            l = i;
          }
        }
      }
    });
    //Eventlistener zum prüfen ob start gedrückt wurde
    view.startButton.onClick.listen((_) {
      //Falls kein Level gewählt wurde passiert nichts
      if (l != 0) {
        //loadlevel starten und die nummer des levels übergeben
        loadLevel(l);
        //setClickListenerForLevel aufrufen und towers übergeben
        towers = setClickListenerForLevel(towers);
        //Einen timer starten welcher alls 70 milisekunden aktualisiert
        Timer.periodic(Duration(milliseconds: 50), (timer) {
          //wenn noch wellen da in bestimmten abständen Gegner spawnen
          if (spawncount <= 0 && model.wellen.isNotEmpty) {
            //generateEnemy aufrufen und Spawncount auf 25 zurücksetzen
            generateEnemy();
            spawncount = 25;
          }
          //Turmanhroff und feinde bewegen aufrufen
          model.turmAngriff();
          model.feindeBewegen();
          if(model.shots.isNotEmpty) {
            for(var s in model.shots) {
              view.shoot(s);
            }
          }
          //View updaten und den turm und das Kaufmenue übergeben
          view.update(l, model.kaufen);
          //counter für den spawn reduzieren
          spawncount--;
          //Falls game over wird der Timer abgebrochen
          //bei Sieg = Win und bei Gameover = gameover
          if (model.gameOver) {
            timer.cancel();
            view.gameOver();
          } else if (model.win) {
            timer.cancel();
            view.win();
          }
        });
      }
    });
  }

  ///generateWay generiert den Weg
  ///@param relway eine Liste mit den Positionen
  List<Position> generateWay(List<Position> relway) {
    //es wird die höhe und breite der Map auf dem Bildschirm abgeragt
    num width = view.map.getBoundingClientRect().width.toDouble();
    num height = view.map.getBoundingClientRect().height.toDouble();
    //Variable way initialisieren
    var way = <Position>[];
    //alle positionen in relway in way adden und die skalierung anpassen
    for (var pos in relway) {
      way.add(Position((pos.x * width) / 1600, (pos.y * height) / 800));
    }
    return way;
  }

  ///generateEnemy generiert die Feinde und übergibt ihnen die Wegpunkte
  void generateEnemy() {
    //spawn im Model wird aufgerufen
    model.spawn();
    //spawn in der view wird aufgerufen und der Feind übergeben
    view.spawn(model.feinde.last);
    //der Weg wird den Feinden übergeben
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

  ///loadLevel bildet den Übergang vom Hauptmenue in das Spiel
  void loadLevel(num level) {
    //das ausgewählte Level wird das neue Model
    model = levels[level - 1];
    //Das Menue wird ausgeblendet
    view.menu.style.display = 'none';
    //die generate Map der View wird aufgerufen
    view.generateMap(model.kaufen);
    //Der generierte weg wird an die Felder übergeben
    model.karte.felder = generateWay(model.karte.felder);
    //das neue Model wird an die View übergeben
    view.setModel(model);
  }

  ///Methode mit Eventlistener im Level
  ///Es wird registriert, ob ein Turm gekauft wird und
  ///ob/wo er auf der Karte plaziert wird.
  ///@param towerID gibt den Türmen ihre ID
  num setClickListenerForLevel(num towerID) {
    //Variable um den Button zu speichern
    Element button;
    //onClick listener für den Kauf button
    view.kaufButton.onClick.listen((event) {
      if (event.target is Element) {
        //Speichern welcher button geklickt wurde
        button = event.target;
      }
    });
    //onClick listener für die Karte
    view.map.onClick.listen((ev) {
      //es wird gespeichert auf welcher position geklickt wurde
      var click = Position(ev.offset.x, ev.offset.y);
      //Wenn das Feld frei ist und vorher auf kauf gedrückt wurde
      if (model.karte.free() && button != null) {
        //Es wird geprüft ob genug Antikörper für den Kauf zur verfügung stehen
        if (model.ak - int.parse(button.innerHtml.toString()) >= 0) {
          //Es wird ein Turm plaziert
          model.turmPlazieren(button.id, click, 1, towerID++);
          //Der Turm wird an die View übergeben
          view.setTower(model.turm.last);
          //Ruft die Buy Methode im Model auf
          model.buy();
        }
      }
    });
    //gibt die Anzahl der Türme zurück
    return towerID;
  }

  ///Methode um das das Level zu Laden.
  ///Hier wird im verlauf die JSON Datei geladen
  List<Level> loadLevelFromData() {
    return [
      Level(
          50,
          [Blutzelle(1, Position(0, 0), 0)],
          [
            [
              Corona(0, 0, 0, 10, 0, false),
              Corona(1, 0, 0, 10, 0, false),
              Corona(2, 0, 0, 10, 0, false),
              Corona(3, 0, 0, 10, 0, false),
              Corona(4, 0, 0, 10, 0, false),
              Corona(5, 0, 0, 10, 0, false),
              Corona(6, 0, 0, 10, 0, false),
              Corona(7, 0, 0, 10, 0, false),
              Corona(8, 0, 0, 10, 0, false),
              Corona(9, 0, 0, 10, 0, false)
            ],
            [
              Corona(0, 0, 0, 10, 0, false),
              Corona(1, 0, 0, 10, 0, false),
              Corona(2, 0, 0, 10, 0, false),
              Corona(3, 0, 0, 10, 0, false),
              Corona(4, 0, 0, 10, 0, false),
              Corona(5, 0, 0, 10, 0, false),
              Corona(6, 0, 0, 10, 0, false),
              Corona(7, 0, 0, 10, 0, false),
              Corona(8, 0, 0, 10, 0, false),
              Corona(9, 0, 0, 10, 0, false)
            ]
          ],
          [Antibiotika(50, 4, 10)],
          Karte([Position(920, 340), Position(630, 340), Position(1220, 320)]))
    ];
  }
}
