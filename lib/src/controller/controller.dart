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
  void main() async {
    //Variable um den Türmen ihre ID zu geben
    num towers = 0;
    //Die Level werden geladen
    levels = await loadLevelFromData();
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
        mainLoop(l, towers);
      }
    });

    view.menueButton.onClick.listen((event) async {
      view.switchToMenu();
      l = 0;
      levels = await loadLevelFromData();
    });

    view.restartButton.onClick.listen((event) async {
      levels = await loadLevelFromData();
      view.resetWinGameover();
      mainLoop(l, towers);
    });
  }

  void mainLoop(num l, towers) {
    //loadlevel starten und die nummer des levels übergeben
    loadLevel(l);
    //setClickListenerForLevel aufrufen und towers übergeben
    towers = setClickListenerForLevel(towers);
    //Einen timer starten welcher alls 70 milisekunden aktualisiert
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (checkScreenOrientation()) {
        //Portraitmodus anzeige auf unsichtbar
        view.portrait.style.display = 'none';
        //wenn noch wellen da in bestimmten abständen Gegner spawnen
        if (spawncount <= 0 && model.wellen.isNotEmpty) {
          //generateEnemy aufrufen und Spawncount auf 25 zurücksetzen
          generateEnemy();
          spawncount = 25;
        }
        //Turmanhroff und feinde bewegen aufrufen
        model.turmAngriff();
        model.feindeBewegen();
        if (model.shots.isNotEmpty) {
          for (var s in model.shots) {
            if (!s.flying) view.shoot(s);
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
      } else {
        view.portrait.style.display = 'grid';
      }
    });
  }

  ///generateWay generiert den Weg
  ///@param relway eine Liste mit den Positionen
  List<dynamic> generateWay(List<dynamic> relway) {
    //es wird die höhe und breite der Map auf dem Bildschirm abgeragt
    var width = view.mapWidth;
    var height = view.mapHeight;
    //Variable way initialisieren
    var way = [];
    //alle positionen in relway in way adden und die skalierung anpassen
    for (var pos in relway) {
      way.add(Position((pos.x * width) / 1600, (pos.y * height) / 800));
    }
    return way;
  }

  ///generateEnemy generiert die Feinde und übergibt ihnen die Wegpunkte
  void generateEnemy() {
    //spawn im Model wird aufgerufen
    if (model.spawn()) {
      //spawn in der view wird aufgerufen und der Feind übergeben
      view.spawn(model.feinde.last);
      //der Weg wird den Feinden übergeben
      model.feinde.last.setWay(generateWay(model.karte.wege[0]));
    }
  }

  ///loadLevel bildet den Übergang vom Hauptmenue in das Spiel
  void loadLevel(num level) {
    //das ausgewählte Level wird das neue Model
    model = levels[level - 1];
    print(levels);
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
        if (model.ak - int.parse(button.attributes['value']) >= 0) {
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
  Future<List<Level>> loadLevelFromData() async {
    var lev = <Level>[];
    Map data = json.jsonDecode(await HttpRequest.getString('levels.json'));
    for (var lvl in data['Levels']) {
      lev.add(Level(lvl['Level']));
    }

    return lev;
  }

  bool checkScreenOrientation() {
    return view.height < view.width ? true : false; //Landscape = True
  }
}
