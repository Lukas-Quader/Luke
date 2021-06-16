part of ImmunityTD;

class View {
  Level model;

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

  int wavemax = 0;

  // KaufButton
  ElementList<HtmlElement> get kaufButton => querySelectorAll('.buy_tower');
  // StartButton
  HtmlElement get startButton => querySelector('#startButton');

  HtmlElement get menueButton => querySelector('#menueButton');

  HtmlElement get restartButton => querySelector('#restartButton');

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
        if (s.fin) {
          hits.add(s);
          schuss.remove();
        }
      }
      for (var h in hits) {
        model.shots.remove(h);
      }
    }
    generateInfobar();
  }

  /// Debugging Tool
  /// Darstellen von Punkten auf der Karte
  void showPoints(List<dynamic> way) {
    var i = 0;
    // Auswählen und darstellen der erstellten Punkte
    for (var p in way) {
      var pos = querySelector('#wp_$i');
      pos?.style?.left = '${p.x}px'; // definierte x-Position setzen
      pos?.style?.top = '${p.y}px'; //  definierte y-Position setzen
      pos?.style?.display = 'block';
      i++;
    }
  }

  /// Debugging Tool
  /// Erstellen von Punkten auf der Karte
  void generatePoints(num way) {
    var i = 0;
    // Erstellen der Punkte
    for (var j = 0; j < way; j++) {
      // hinzufügen des Punktes zur innerHTML von map
      map.innerHtml += '<div class=wp id=wp_$i></div>';
      i++; // nächster Punkt
    }
  }

  void removePoint(num point) {
    var pos = querySelector('#wp_$point');
    pos.remove();
  }

  /// Erstellen des Startmenüs
  void generateMenu(List<Level> levels) {
    menueButton.style.display = 'none';
    restartButton.style.display = 'none';
    gameover.style.display = 'none';
    winLogo.style.display = 'none';
    levelview.style.display = 'none'; // Levelview aktuell unsichtbar
    var level = ''; // zwischenvariable zum zwischenspeichern der Buttons
    // Erstellen der Level-Button des Menüs
    for (var lev = 1; lev <= levels.length; lev++) {
      // Fügt den Button der Variable hinzu
      level +=
          "<button class='box_level' id='box_level_$lev'>Level $lev</button>\n";
      // Button wird der innerHTML von Button beigefügt
      buttons.innerHtml += level;
      // Button wird dem Level hinzugefügt
      var lvl = querySelector('#box_level_$lev');
      // Hintergrundbild setzen
      lvl.style.backgroundImage = 'url(img/map_$lev.png)';
      lvl.style.backgroundSize = '100% 100%'; // Bildgröße setzen
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
    map.setInnerHtml(ht); // Fügt den Feind der Map hinzu
  }

  void shoot(Projektiel projektiel) {
    var ht = map.innerHtml; // zwischenspeichern der innerHTML von map
    // Fügt den Feind mit Namen und id zum HTML File hinzu
    ht +=
        '\n<div class=${projektiel.name} id=${projektiel.name}_${projektiel.id}></div>';
    map.setInnerHtml(ht); // Fügt den Feind der Map hinzu
    projektiel.flying = true;
  }

  /// Erstellen von Türmen
  void setTower(Turm turm) {
    var ht = map.innerHtml; // zwischenspeichern der innerHTML von map
    // Fügt den Turm mit Namen und id zum HTML File hinzu
    ht += '\n<div class=${turm.name} id=${turm.name}_${turm.id}></div>';
    map.setInnerHtml(ht); // Fügt den Turm der Map hinzu
  }

  /// Erstellen des Kaufmenüs auf er rechten seite des Bildschirms
  void generateBuyMenu(List<Turm> tower) {
    var html = ''; // Leeres HTML Dokument
    // Erstellen der Button der Türme
    for (var t in tower) {
      // Fügt den Button mit Namen und Kosten zum HTML File hinzu
      html +=
          "<button draggable='true' class='buy_tower' id='${t.name}' value='${t.kosten}'></button>\n";
      buemenue.innerHtml += html; // Fügt den Button zum Menü hinzu
    }
    print(buemenue.innerHtml);
    buemenue.innerHtml = html; // Fügt den Button zum Menü hinzu
  }

  /// Erstellen der Infobar im unteren Teil des Bildschirms
  void generateInfobar() {
    // anzeigen der Menge an Antikörpern
    ak.setInnerHtml('Antikoerper: ${model.ak}');
    // anzeigen der Menge an Leben
    tp.setInnerHtml('Leben: ${model.leben}');
    // anzeigen der aktuellen Welle
    wavecount.setInnerHtml(
        'Wellen : ${model.wellen.isEmpty ? wavemax : wavemax - model.wellen.length + 1}/$wavemax');
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

  /// Löscht Button und Logo nach dem Spielende wieder
  void resetWinGameover() {
    winLogo.style.display = 'none';
    gameover.style.display = 'none';
    menueButton.style.display = 'none';
    restartButton.style.display = 'none';
  }

  num get mapWidth => map.getBoundingClientRect().width.toDouble();

  num get mapHeight => map.getBoundingClientRect().height.toDouble();

  num get width => body.getBoundingClientRect().width.toDouble();

  num get height => body.getBoundingClientRect().height.toDouble();
}
