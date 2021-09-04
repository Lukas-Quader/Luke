part of ImmunityTD;

///Controller Klasse
///Sie bildet den Controller des Spiels ab
class Controller {
  //Variablen bekanntmachen und initialisieren
  Level model;
  List<Level> levels;
  List<dynamic> tutorials;
  int spawncount = 100;
  View view = View();
  bool _buy = false;
  bool _powerup = false;
  int powerUpTime = 0;
  Element tower;
  PowerUp pushedPowerUp;
  Turm selectedTower;
  num towers;
  num wayNow = 0;
  bool _tutInGame = false;

  ///Constructor
  ///Ruft die Main Methode auf
  Controller() {
    main();
  }

  ///Main Methode
  ///Sie ist der Eintrittspunkt in das Spiel
  void main() async {
    // Abfrage zum Initialisieren des LocalStorage
    if (!window.localStorage.containsKey('completeLevel')) {
      window.localStorage['completeLevel'] = '0';
    }
    if (!window.localStorage.containsKey('tutorialITD')) {
      window.localStorage['tutorialITD'] = '0';
      window.localStorage['tutorialact'] = '0';
    }
    //Variable um den Türmen ihre ID zu geben
    towers = 0;
    //Die Level werden geladen
    levels = await loadLevelFromData();
    //Tutorials werden geladen
    tutorials = await loadTutorialsFromData();
    //Die Level werden an das Menü in der View übergeben
    view.generateMenu(levels);
    //Variable um das gewählte Level zu speichern
    num l = 0;
    //Onclick listener welches Level gewählt wird
    view.buttons.onClick.listen((event) {
      if (event.target is Element) {
        //merken welches Level gewählt wird
        Element button = event.target;
        //Schleife um zu prüfen welches Level gewählt wurde,
        for (num i = 1; i <= levels.length; i++) {
          if (button.id == 'box_level_$i') {
            if (l != 0) view.unselectLevel(l);
            view.selectLevel(i);
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
        //abfrage falls neue Informationen aufkommen
        if(l - 1 == int.parse(window.localStorage['completeLevel'])){
          switch (l) {
            case 1:
              if(int.parse(window.localStorage['tutorialITD']) <= 8) {
                _tutInGame = true;
                if(int.parse(window.localStorage['tutorialITD']) < 2) window.localStorage['tutorialITD'] = '2';
                window.localStorage['tutorialact'] = '2';
                view.switchToTutorial(tutorials[2], _tutInGame);
              }
              else mainLoop(l);
              break;
            case 2:
              if(int.parse(window.localStorage['tutorialITD']) <= 12) {
                _tutInGame = true;
                window.localStorage['tutorialact'] = '9';
                view.switchToTutorial(tutorials[9], _tutInGame);
              }
              else mainLoop(l);
              break;
            case 3:
              if(int.parse(window.localStorage['tutorialITD']) <= 15) {
                _tutInGame = true;
                window.localStorage['tutorialact'] = '13';
                view.switchToTutorial(tutorials[13], _tutInGame);
              }
              else mainLoop(l);
              break;
            case 4:
              if(int.parse(window.localStorage['tutorialITD']) <= 16) {
                _tutInGame = true;
                window.localStorage['tutorialact'] = '16';
                view.switchToTutorial(tutorials[16], _tutInGame);
              }
              else mainLoop(l);
              break;
            default:
              mainLoop(l);
          }
        }
        else mainLoop(l);
      }
    });

    //Eventlistener zum prüfen ob tutorial gedrückt wurde
    view.tutorialButton.onClick.listen((_) {
      view.switchToTutorial(
          tutorials[int.parse(window.localStorage['tutorialact'])], _tutInGame);
    });

    //Eventlistener zum prüfen ob tutorial gedrückt wurde
    view.tutorialBack.onClick.listen((_) {
      view.switchToMenu();
    });

    //Eventlistener zum prüfen ob tutorial gedrückt wurde
    view.tutorialLeft.onClick.listen((_) {
      if(int.parse(window.localStorage['tutorialact']) > 0) {
        window.localStorage['tutorialact'] = (int.parse(window.localStorage['tutorialact']) - 1).toString();
        view.switchToTutorial(tutorials[int.parse(window.localStorage['tutorialact'])], _tutInGame);
      }     
    });

    //Eventlistener zum prüfen ob tutorial gedrückt wurde
    view.tutorialRight.onClick.listen((_) {
      if(_tutInGame) {
        if(int.parse(window.localStorage['tutorialITD']) == 8) {
          window.localStorage['tutorialITD'] = '9';
          view.switchToMenu();
          mainLoop(l);
        } 
        else if(int.parse(window.localStorage['tutorialITD']) == 12) {
          window.localStorage['tutorialITD'] = '13';
          view.switchToMenu();
          mainLoop(l);
        }  
        else if(int.parse(window.localStorage['tutorialITD']) == 15) {
          window.localStorage['tutorialITD'] = '16';
          view.switchToMenu();
          mainLoop(l);
        }  
        else if(int.parse(window.localStorage['tutorialITD']) == 16) {
          window.localStorage['tutorialITD'] = '17';
          view.switchToMenu();
          mainLoop(l);
        } 
        else {
          if(window.localStorage['tutorialITD'] == window.localStorage['tutorialact']) window.localStorage['tutorialITD'] = (int.parse(window.localStorage['tutorialITD']) + 1).toString();
          window.localStorage['tutorialact'] = (int.parse(window.localStorage['tutorialact']) + 1).toString();
          view.switchToTutorial(tutorials[int.parse(window.localStorage['tutorialact'])], _tutInGame);
        }
      } else {
          if(window.localStorage['tutorialITD'] == window.localStorage['tutorialact']) window.localStorage['tutorialITD'] = (int.parse(window.localStorage['tutorialITD']) + 1).toString();
          window.localStorage['tutorialact'] = (int.parse(window.localStorage['tutorialact']) + 1).toString();
          view.switchToTutorial(tutorials[int.parse(window.localStorage['tutorialact'])], _tutInGame);
      }
    });

    //Onclick für den Menübutton nach dem Spiel
    view.menueButton.onClick.listen((event) async {
      //Buttons werden ausgeblendet und das Menü neu generiert.
      view.switchToMenu();
      view.generateMenu(levels);
      l = 0; // benötigt, da sonst ein Level direkt ausgewählt ist.
      levels = await loadLevelFromData(); //neuladen der Json
    });

    //Onclick für den Restartbutton nach dem Spiel
    view.restartButton.onClick.listen((event) async {
      levels = await loadLevelFromData(); //neuladen der Json
      // Das Win oder Gameober wird ausgeblendet
      spawncount = 100;
      view.resetWinGameover();
      //erneutes starten des Levels
      mainLoop(l);
    });
  }

  ///Die Mainloop wird aufgerufen um die Level zu starten.
  void mainLoop(num l) {
    //loadlevel starten und die nummer des levels übergeben
    loadLevel(l);
    view.generatePoints(model.karte.felder.length);
    //setClickListenerForLevel aufrufen und towers übergeben
    setClickListenerForLevel();
    //Einen timer starten welcher alls 60 milisekunden aktualisiert
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      //Solange ein Turm im Menü ausgewählt ist, werden die Turmorte angezeigt
      if (_buy) {
        view.showPoints(model.karte.felder);
        setClickForPoints();
      }
      //Die Powerups werden nach benutzen für eine bestimmte Abklingzeit ausgeblendet
      //_powerup zeigt ob ein Powerup aktiv ist
      if (_powerup) {
        view.switchPowerUpStyle(true);
        powerUpTime--;
        if (powerUpTime == 0) {
          _powerup = false;
          powerUpTime = pushedPowerUp.abklingzeit;
        }
      } else if (powerUpTime > 0) {
        powerUpTime--;
      } else {
        view.switchPowerUpStyle(false);
      }

      if (checkScreenOrientation()) {
        //Portraitmodus anzeige auf unsichtbar
        view.portraitNone();
        //Falles es Türme gibt, wird ein Listener dafür erstellt
        if (model.turm.isNotEmpty) setClickForTowers(model.turm);
        //wenn noch wellen da in bestimmten abständen Gegner spawnen
        if (spawncount <= 0 && model.wellen.isNotEmpty) {
          //generateEnemy aufrufen und Spawncount auf den nächsten Feind zurücksetzen
          generateEnemy();
          //Falls es eine weitere nicht leere Welle gibt. wird der abstand des
          //nächsten Feindes als Spawncount gesetzt. Ansonsten ist dieser pauschal 20
          if (model.wellen.first.isNotEmpty) {
            spawncount = model.wellen.first.first.abstand;
          } else {
            spawncount = 20;
          }
        }
        //Turmanhroff und feinde bewegen aufrufen
        model.turmAngriff(_powerup, pushedPowerUp);
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
          // Das Aktuelle Level wird der safeLevel Methode übergeben.
          model.safeLevel(l);
        }
      } else {
        // Portraitmodus wird Sichtbar. Das Fenster ist nun geblockt.
        view.portraitGrid();
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
      //falls mehrere wege existieren
      if (model.karte.wege.length > 1) {
        wayNow = (wayNow >= model.karte.wege.length - 1) ? 0 : wayNow + 1;
      }
      //der Weg wird den Feinden übergeben
      model.feinde.last.setWay(generateWay(model.karte.wege[wayNow]));
    }
  }

  ///loadLevel bildet den Übergang vom Hauptmenue in das Spiel
  void loadLevel(num level) {
    //das ausgewählte Level wird das neue Model
    model = levels[level - 1];
    //Das Menue wird ausgeblendet
    view.menu.style.display = 'none';
    //die generate Map der View wird aufgerufen
    view.generateMap(model.kaufen, model.powerup);
    //Der generierte weg wird an die Felder übergeben
    model.karte.felder = generateWay(model.karte.felder);
    //das neue Model wird an die View übergeben
    view.setModel(model);
  }

  ///Methode mit Eventlistener im Level
  ///Es wird registriert, ob ein Turm gekauft wird und
  ///ob/wo er auf der Karte plaziert wird.
  ///@param towerID gibt den Türmen ihre ID
  void setClickListenerForLevel() {
    //Variable um den Button zu speichern
    //onClick listener für den Kauf button
    view.kaufButton.onClick.listen((event) {
      if (event.target is Element) {
        //Speichern welcher button geklickt wurde
        tower = event.target;
        _buy = true;
      }
    });
    //onClick für die PowerUp Buttons
    view.powerUpButton.onClick.listen((event) {
      //Das ausgewählte Element wird ausgelesen
      if (event.target is Element) {
        //Alle vorhandenen Powerups werden mit der id des Buttons verglichen
        //und das entsprechende Powerup wird gespeichert.
        for (var p in model.powerup) {
          if (p.name == (event.target as Element).id) pushedPowerUp = p;
        }
        // Die Abklingzeit wird gesetzt.
        powerUpTime = pushedPowerUp.laufzeit;
        //Wird in der Mainloop benötigt und dort wieder auf false gesetzt
        _powerup = true;
      }
    });
    //klick auf die Map um platzierpunkte verschwinen zu lassen
    view.map.onClick.listen((event) {
      if (view.towerPoints.style.display == 'block') {
        _buy = false;
        view.hidePoints();
      }
    });
  }

  ///Clicklistener Methode für die Punkte, auf welchen die Türme platziert
  ///werden können
  void setClickForPoints() {
    view.towerPoints.onClick.listen((ev) {
      //es wird gespeichert auf welcher position geklickt wurde
      var click = Position((ev.target as ButtonElement).offsetLeft,
          (ev.target as ButtonElement).offsetTop);
      //Wenn das Feld frei ist und vorher auf kauf gedrückt wurde
      if (model.karte.free() && tower != null) {
        //Es wird geprüft ob genug Antikörper für den Kauf zur verfügung stehen
        if (model.ak - int.parse(tower.attributes['value']) >= 0) {
          //Es wird ein Turm plaziert
          var which = model.turmPlazieren(
              tower.id, click, 1, towers++, view.mapWidth, view.mapHeight);
          if (which >= 0) {
            view.removePoint(which);
            //Der Turm wird an die View übergeben
            view.setTower(model.turm.last);
            //Ruft die Buy Methode im Model auf
            model.buy();
          }
        }
        _buy = false;
      }
    });
  }

  ///onClick Methode für die Türme auf dem Feld um Upgrade/Verkäufe auszuführen
  void setClickForTowers(List<Turm> towers) {
    for (var tower in towers) {
      view.getTower(tower).onClick.listen((event) {
        view.generateUpgradeMenu(tower);
        setClickListenerForUpgrade();
        selectedTower = tower;
      });
    }
  }

  ///Methode um die Clicklistener für die Upgrades der Türme zu setzen.
  void setClickListenerForUpgrade() {
    view.backButton.onClick.listen((event) {
      view.generateBuyMenu(model.kaufen, model.powerup);
      setClickListenerForLevel();
    });
    //Variable um den Button zu speichern
    //onClick listener für den Kauf button
    view.upgradeButton.onClick.listen((event) {
      if (event.target is Element) {
        Element temp = event.target;
        if (model.upgrade(
            selectedTower, int.parse(temp.getAttribute('value')))) {
          switch (int.parse(temp.getAttribute('value'))) {
            case 1:
              view.getTower(selectedTower).className =
                  selectedTower.name.toString();
              break;
            case 2:
              view.getTower(selectedTower).className =
                  selectedTower.name.toString() + 'U1';
              break;
            case 3:
              view.getTower(selectedTower).className =
                  selectedTower.name.toString() + 'U2';
              break;
            default:
          }
        }
      }
      view.generateBuyMenu(model.kaufen, model.powerup);
      setClickListenerForLevel();
    });
    view.sellButton.onClick.listen((event) {
      if (event.target is Element) {
        Element temp = event.target;
        view.sellTower(
            selectedTower,
            model.sellTower(
                selectedTower, int.parse(temp.getAttribute('value'))));
        view.generateBuyMenu(model.kaufen, model.powerup);
        setClickListenerForLevel();
      }
    });
  }

  ///Methode um das das Level zu Laden.
  ///Hier wird im verlauf die JSON Datei geladen
  Future<List<Level>> loadLevelFromData() async {
    var lev = <Level>[];
    Map data = json.jsonDecode(await HttpRequest.getString('levels.json'));
    for (var lvl in data['Levels']) {
      lev.add(Level(lvl['Level'], view.mapWidth, view.mapHeight));
    }

    return lev;
  }

  ///Methode um Tutorials zu Laden.
  ///Hier wird im verlauf die JSON Datei geladen
  Future<List<dynamic>> loadTutorialsFromData() async {
    var tut = [];
    Map data = json.jsonDecode(await HttpRequest.getString('levels.json'));
    for (var tutorial in data['Tutorials']) {
      tut.add(tutorial['Tutorial']);
    }
    return tut;
  }

  ///Methode um die Bildschirmorientierung zu Prüfen.
  ///True = Landscape
  ///False = Portait
  bool checkScreenOrientation() {
    return view.height < view.width ? true : false;
  }
}
