part of ImmunityTD;

class View {
  Level model;

  final text = querySelector('#text');

  final buttons = querySelector('#buttons');

  final buemenue = querySelector('#buymenu_wrapper');

  final menu = querySelector('#menu');

  final levelview = querySelector('#level');

  final map = querySelector('#map');

  final infobar = querySelector('#infobar');

  final ak = querySelector('#ak');

  final tp = querySelector('#tp');

  final wavecount = querySelector('#wavecount');

  HtmlElement get startButton => querySelector('#startButton');

  View();

  void setModel(Level model) {
    this.model = model;
  }

  void update() {
    if (!model.feinde.isEmpty) {
      for (Feinde f in model.feinde) {
        var feind = querySelector('#${f.name}_${f.id}');
        feind?.style.left = "${f.getPos().x}px";
        feind?.style.top = "${f.getPos().y}px";
        if (f.fin) {
          feind.style.display = "none";
          model.feinde.remove(f);
          feind.remove();
        }
      }
    }
    if (!model.turm.isEmpty) {
      for (Turm t in model.turm) {
        var turm = querySelector('#${t.getName()}_${t.getID()}');
        turm?.style.left = "${t.getPosition().x}px";
        turm?.style.top = "${t.getPosition().y}px";
      }
    }
    generateInfobar();
  }

  void showPoints(List<Position> way) {
    int i = 0;
    for (Position p in way) {
      var pos = querySelector('#wp_$i');
      pos?.style.left = "${p.x}px";
      pos?.style.top = "${p.y}px";
      i++;
    }
  }

  void generatePoints(List<Position> way) {
    int i = 0;
    for (Position p in way) {
      map.innerHtml += '<div class=wp id=wp_$i></div>';
      i++;
    }
  }

  void generateLevel() {
    levelview.style.display = "none";
    String level = "";
    for (int levels = 1; levels <= 10; levels++) {
      level += "<button class='box_level'>Level $levels</button>\n";
    }
    buttons.innerHtml = level;
  }

  void generateMap() {
    generateBuyMenu();
    levelview.style.display = "grid";
  }

  void spawn(Feinde f) {
    String ht = map.innerHtml;
    ht += '\n<div class=${f.name} id=${f.name}_${f.id}></div>';
    map.setInnerHtml(ht);
    f.setPos(f.goal);
  }

  void setTower(Turm turm) {
    String ht = map.innerHtml;
    ht += '\n<div class=${turm.getName()} id=${turm.getName()}_${turm.getID()}></div>';
    map.setInnerHtml(ht);
  }

  void generateBuyMenu() {
    String level = "";
    for (int levels = 1; levels <= 7; levels++) {
      level += "<button class='box_level'>Level $levels</button>\n";
    }
    buemenue.innerHtml = level;
  }

  void generateInfobar() {
    ak.setInnerHtml('Antikoerper: ${model.ak}');
    tp.setInnerHtml('Leben: ${model.leben}');
    wavecount.setInnerHtml('Welle : ${model.wellen.length}/3');
  }
}
