part of ImmunityTD;

class View {
  Level model;

  var pointCounter = 0;
  // Der NodeValidator wird benötigt um zu Definieren, dass bestimmte attribute
  // im HTML code erlaubt sind.
  NodeValidatorBuilder _validatorBuilder = new NodeValidatorBuilder()
    ..allowHtml5()
    ..allowElement('DIV', attributes: ['style'])
    ..allowElement("BUTTON", attributes: ['style']);

  final portrait = querySelector('#portrait');

  final text = querySelector('#text'); // HTML-Teil des Textes

  final body = querySelector('body');

  final buttons = querySelector('#buttons'); // HTML-Teil des Buttons

  final buemenue = querySelector('#buymenu_wrapper'); // HTML-Teil des Kaufmenüs

  final menu = querySelector('#menu'); // HTML-Teil des Startmenüs

  final levelview = querySelector('#level'); // HTML-Teil der Levelview

  final map = querySelector('#map'); // HTML-Teil der Karte

  final gameover =
      querySelector('#gameover'); // QuerySelector für das Gameover Stylesheet

  final winLogo =
      querySelector('#win'); // QuerySelector für das Gameover Stylesheet

  final infobar = querySelector('#infobar'); // HTML-Teil der Infoleiste

  final ak = querySelector('#ak'); // HTML-Teil der Antikörper(Infoleiste)

  final tp = querySelector('#tp'); // HTML-Teil der Leben(Infoleiste)
  // HTML-Teil der Feindwellenanzeige(Infoleiste)
  final wavecount = querySelector('#wavecount');

  // KaufButton
  ElementList<HtmlElement> get towerPoints => querySelectorAll('.wp');

  int wavemax = 0;

  // KaufButton
  ElementList<HtmlElement> get kaufButton => querySelectorAll('.buy_tower');
  // KaufButton
  ElementList<HtmlElement> get upgradeButton =>
      querySelectorAll('.upgrade_tower');
  // StartButton
  HtmlElement get startButton => querySelector('#startButton');

  HtmlElement get menueButton => querySelector('#menueButton');

  HtmlElement get restartButton => querySelector('#restartButton');

  HtmlElement getTower(Turm turm) => querySelector('#${turm.name}_${turm.id}');

  HtmlElement get backButton => querySelector('#back_button');

  HtmlElement get sellButton => querySelector('.sell_tower');

  /// Constructor der View
  View();

  /// Setzen des ViewModels
  void setModel(Level model) {
    this.model = model;
    wavemax = model.wellen.length;
  }

  /// generelles updaten der Ansicht des Spiels
  void update(num l, List<Turm> buy) {
    List<Feinde> killed = [];
    // Hintergrundbild der Karte
    map.style.backgroundImage = 'url(img/map_$l.png)';
    // Gibt es noch Feinde in der Liste?
    if (model.feinde.isNotEmpty) {
      // Durchgehen der Feindesliste
      for (var f in model.feinde) {
        var feind = querySelector('#${f.name}_${f.id}');
        feind?.style?.left = '${f.pos.x}px'; // nächste x position
        feind?.style?.top = '${f.pos.y}px'; // nächste y position
        feind.classes.remove('dmg');
        if (f.hitted) feind.classes.add('dmg');
        feind.classes.remove('boss');
        if (f.boss) feind.classes.add('boss');
        // Gegner im Ziel?
        if (f.fin) {
          feind.style.display = 'none'; // feind sichtbar machen
          killed.add(f);
          feind.remove(); // entferent Feind aus der View
        }
      }
      for (Feinde feind in killed) {
        model.kill(feind); // entfernt Feind aus der Liste
      }
    }
    // Gibt es Türme in der Liste?
    if (model.turm.isNotEmpty) {
      // Durchgehen der Turmliste
      for (var t in model.turm) {
        var turm = querySelector('#${t.name}_${t.id}');
        turm?.style?.left = '${t.position.x}px'; // definierte x-Position setzen
        turm?.style?.top = '${t.position.y}px'; // definierte y-Position setzen
      }
    }

    if (model.shots.isNotEmpty) {
      List<Projektiel> hits = [];
      // Durchgehen der Projektielliste
      for (var s in model.shots) {
        var schuss = querySelector('#${s.name}_${s.id}');
        schuss?.style?.left = '${s.pos.x}px'; // definierte x-Position setzen
        schuss?.style?.top = '${s.pos.y}px'; // definierte y-Position setzen
        if (s.fin || s.enemy.fin) {
          hits.add(s);
          schuss.remove();
        }
      }
      // In der Schleife werden die Schüsse wieder entfernt
      for (var h in hits) {
        model.shots.remove(h);
      }
    }
    // Methodenaufruf
    generateInfobar();
  }

  /// Debugging Tool
  /// Darstellen von Punkten auf der Karte
  void showPoints(List<dynamic> way) {
    var i = 0;
    // Auswählen und darstellen der erstellten Punkte
    for (var p in way) {
      var pos = querySelector('#wp_$i');
      if(int.parse(pos.getAttribute('value')) == 1) {
        pos?.style?.left = '${p.x}px'; // definierte x-Position setzen
      pos?.style?.top = '${p.y}px'; //  definierte y-Position setzen
      pos?.style?.display =
          'block'; // Style wird auf Block gesetzt. Dadurch wird es Sichtbar
      }
      i++;
    }
  }

  /// Debugging Tool
  /// Erstellen von Punkten auf der Karte
  void generatePoints(num way) {
    // Erstellen der Punkte
    for (var j = 0; j < way; j++) {
      // hinzufügen des Punktes zur innerHTML von map
      map.innerHtml += '<button class=wp id=wp_$pointCounter value=1></button>';
      pointCounter++; // nächster Punkt
    }
  }

  void setPoint(num point) {
    var pos = querySelector('#wp_$point');
    pos.setAttribute('value', '1');
  }

  void removePoint(num point) {
    var pos = querySelector('#wp_$point');
    pos.setAttribute('value', '0');
  }

  /// Erstellen des Startmenüs
  void generateMenu(List<Level> levels) {
    //entfernt alle bisherigen Buttons
    buttons.innerHtml = '';
    //alles was nicht notwendig ist wird unsichtbar
    menueButton.style.display = 'none';
    restartButton.style.display = 'none';
    gameover.style.display = 'none';
    winLogo.style.display = 'none';
    levelview.style.display = 'none';
    var level = ''; // zwischenvariable zum zwischenspeichern der Buttons
    // Erstellen der Level-Button des Menüs
    for (var lev = 1; lev <= levels.length; lev++) {
      // es wird im LocalStorade geprüft, welche Level geschafft wurden.
      if (lev <= int.parse(window.localStorage['completeLevel']) + 1) {
        //solange die Anzahl der geschafften Level größer ist aks die Anzahl aller
        //wird das Level hinzugefügt. Ansonsten nur das Schlosssymbol
        level =
            "<button class='box_level' id='box_level_$lev'>Level $lev</button>\n";
      } else {
        level =
            "<button class='box_level' id='box_schloss'>Level $lev</button>\n";
      }
      // Button wird der innerHTML von Button beigefügt
      buttons.innerHtml += level;
    }
  }

  /// Erstellen der Karte
  void generateMap(List<Turm> buy) {
    generateBuyMenu(buy); // Erstellen des Kaufmenüs
    levelview.style.display = 'grid'; // Levelview wird sichtbar gemacht
  }

  /// Erschaffen der Feinde
  void spawn(Feinde f) {
    var ht = map.innerHtml; // zwischenspeichern der innerHTML von map
    // Fügt den Feind mit Namen und id zum HTML File hinzu
    ht += '\n<div class=${f.name} id=${f.name}_${f.id}></div>';
    map.setInnerHtml(ht,
        validator: _validatorBuilder); // Fügt den Feind der Map hinzu
  }

  void shoot(Projektiel projektiel) {
    var ht = map.innerHtml; // zwischenspeichern der innerHTML von map
    // Fügt den Feind mit Namen und id zum HTML File hinzu
    ht +=
        '\n<div class=${projektiel.name} id=${projektiel.name}_${projektiel.id}></div>';
    map.setInnerHtml(ht,
        validator: _validatorBuilder); // Fügt den Feind der Map hinzu
    projektiel.flying = true;
  }

  /// Erstellen von Türmen
  void setTower(Turm turm) {
    var ht = map.innerHtml; // zwischenspeichern der innerHTML von map
    // Fügt den Turm mit Namen und id zum HTML File hinzu
    ht += '\n<div class=${turm.name} id=${turm.name}_${turm.id}></div>';
    map.setInnerHtml(ht,
        validator: _validatorBuilder); // Fügt den Turm der Map hinzu
    var points = towerPoints;
    points.style.display = 'none';
  }

  /// Erstellen des Kaufmenüs auf er rechten seite des Bildschirms
  void generateBuyMenu(List<Turm> tower) {
    var html = ''; // Leeres HTML Dokument
    // Erstellen der Button der Türme
    for (var t in tower) {
      // Fügt den Button mit Namen und Kosten zum HTML File hinzu
      html +=
          "<div>\n<button draggable='true' class='buy_tower' id='${t.name}' value='${t.kosten}'></button>\n<div class='buy_text'>${t.kosten}</div>\n</div>";
    }
    buemenue.innerHtml = html; // Fügt den Button zum Menü hinzu
  }

  /// Erstellen des Upgrade auf er rechten seite des Bildschirms
  void generateUpgradeMenu(Turm tower) {
    var html = ''; // Leeres HTML Dokument
    var sell;
    var u0;
    var u1;
    var u2;
    switch (tower.level) {
      case 1:
        sell = tower.kosten * (3 / 4);
        u0 = 0;
        u1 = tower.kostenU1;
        u2 = tower.kostenU1 + tower.kostenU2;
        break;

      case 2:
        sell = (tower.kosten + tower.kostenU1) * (3 / 4);
        u0 = 0 - tower.kostenU1;
        u1 = 0;
        u2 = 0 + tower.kostenU2;
        break;

      case 3:
        sell = (tower.kosten + tower.kostenU1 + tower.kostenU2) * (3 / 4);
        u0 = 0 - tower.kostenU1 - tower.kostenU2;
        u1 = 0 - tower.kostenU2;
        u2 = 0;
        break;
      default:
    }
    html +=
        "<div>\n<button id='back_button'>Zurueck</button></div>\n<div></div>\n";
    html +=
        "<div>\n<button class='sell_tower' value='${sell.round()}'></button>\n<div class='sell_text'>Verkaufen: ${sell.round()}</div>\n</div>";
    html +=
        "<div>\n<button class='upgrade_tower' id='${tower.name}' value='${1}'></button>\n<div class='${u0 > 0 ? 'upgrade_cost' : 'upgrade_gain'}'>${u0 < 0 ? u0 * (-1) : u0}</div>\n</div>";
    html +=
        "<div>\n<button class='upgrade_tower' id='${tower.name}U1' value='${2}'></button>\n<div class='${u1 > 0 ? 'upgrade_cost' : 'upgrade_gain'}'>${u1 < 0 ? u1 * (-1) : u1}</div>\n</div>";
    html +=
        "<div>\n<button class='upgrade_tower' id='${tower.name}U2' value='${3}'></button>\n<div class='${u2 > 0 ? 'upgrade_cost' : 'upgrade_gain'}'>${u2 < 0 ? u2 * (-1) : u2}</div>\n</div>";
    buemenue.innerHtml = html; // Fügt den Button zum Menü hinzu
  }

  void sellTower(Turm tower, num point) {
    setPoint(point);
    getTower(tower)?.remove();
  }

  /// Erstellen der Infobar im unteren Teil des Bildschirms
  void generateInfobar() {
    //variable für die Textgröße
    var fontsize = height / 13;
    // anzeigen der Menge an Antikörpern
    ak.setInnerHtml('Antikoerper: ${model.ak}');
    //Textgröße proportional zur höhe
    ak.style.fontSize = '${fontsize}px';
    // anzeigen der Menge an Leben
    tp.setInnerHtml('Leben: ${model.leben}');
    tp.style.fontSize = '${fontsize}px';
    // anzeigen der aktuellen Welle
    wavecount.setInnerHtml(
        'Wellen : ${model.wellen.isEmpty ? wavemax : wavemax - model.wellen.length + 1}/$wavemax',
        validator: _validatorBuilder);
  }

  /// Lässt nurnoch die leere Karte anzeigen
  void cleanMap() {
    // Entfernen aller Feinde auf dem Spielfeld
    for (Feinde f in model.feinde) {
      var feind = querySelector('#${f.name}_${f.id}'); //
      feind.remove(); // Feind entfernen
    }
    // Entfernen aller Türme auf dem Spielfeld
    for (Turm t in model.turm) {
      var turm = querySelector('#${t.name}_${t.id}'); //
      turm.remove(); // Turm entfernen
    }
    for (Projektiel s in model.shots) {
      var schuss = querySelector('#${s.name}_${s.id}'); //
      schuss.remove(); // Turm entfernen
    }
  }

  /// Win Screen nach gewinnen des Spiels
  void win() {
    cleanMap(); // Lässt nurnoch die leere Karte anzeigen
    winLogo.style.display = 'grid'; // Zeigt auf dem Spielfeld Win an
    menueButton.style.display = 'grid'; //Zeigt den Menue Button an
    restartButton.style.display = 'grid'; //Zeigt auf dem Spielfeld Restart an
  }

  /// GameOver Screen nach verlieren des Spiels
  void gameOver() {
    cleanMap(); // Lässt nurnoch die leere Karte anzeigen
    gameover.style.display = 'grid'; // Zeigt auf dem Spielfeld Gameover an
    menueButton.style.display = 'grid'; //Zeigt auf dem Spielfeld Menue an
    restartButton.style.display = 'grid'; //Zeigt auf dem Spielfeld Restart an
  }

  /// Methode um zum Menü zurück zu kehren
  void switchToMenu() {
    levelview.style.display = 'none';
    menu.style.display = 'grid';
    resetWinGameover();
  }

  /// Macht die Button und Logos nach dem Spielende wieder unsichtbar
  void resetWinGameover() {
    winLogo.style.display = 'none';
    gameover.style.display = 'none';
    menueButton.style.display = 'none';
    restartButton.style.display = 'none';
  }

  // Es wird ausgelesen, welches Level angewählt wird und setzt die Umrandung
  // auf Gelb
  void selectLevel(num l) {
    var levelButton = querySelector('#box_level_$l');
    levelButton.style.borderColor = 'yellow';
  }

  // Es wenn ein Level abgewählt wird, wird die Umrandungsfarbe unsichtbar
  void unselectLevel(num l) {
    var levelButton = querySelector('#box_level_$l');
    levelButton.style.borderColor = 'transparent';
  }

  // Es folgen diverse Getter Methoden.
  num get mapWidth => map.getBoundingClientRect().width.toDouble();

  num get mapHeight => map.getBoundingClientRect().height.toDouble();

  num get width => body.getBoundingClientRect().width.toDouble();

  num get height => body.getBoundingClientRect().height.toDouble();
}
