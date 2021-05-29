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

  ElementList<HtmlElement> get kaufButton => querySelectorAll('.buy_tower');

  HtmlElement get startButton => querySelector('#startButton');

  View();

  void setModel(Level model) {
    this.model = model;
  }

  void update(num l, List<Turm> buy) {
    map.style.backgroundImage = 'url(img/map_$l.png)';
    if (model.feinde.isNotEmpty) {
      for (var f in model.feinde) {
        var feind = querySelector('#${f.name}_${f.id}');
        feind?.style?.left = '${f.pos.x}px';
        feind?.style?.top = '${f.pos.y}px';
        if (f.fin) {
          feind.style.display = 'none';
          model.kill(f);
          feind.remove();
        }
      }
    }
    if (model.turm.isNotEmpty) {
      for (var t in model.turm) {
        var turm = querySelector('#${t.name}_${t.id}');
        turm?.style?.left = '${t.position.x}px';
        turm?.style?.top = '${t.position.y}px';
      }
    }
    generateInfobar();
  }

  void showPoints(List<Position> way) {
    var i = 0;
    for (var p in way) {
      var pos = querySelector('#wp_$i');
      pos?.style?.left = '${p.x}px';
      pos?.style?.top = '${p.y}px';
      i++;
    }
  }

  void generatePoints(List<Position> way) {
    var i = 0;
    for (var j = 0; j < way.length; j++) {
      map.innerHtml += '<div class=wp id=wp_$i></div>';
      i++;
    }
  }

  void generateMenu(List<Level> levels) {
    levelview.style.display = 'none';
    var level = '';
    for (var lev = 1; lev <= levels.length; lev++) {
      level += "<button class='box_level' id='box_level_$lev'>Level $lev</button>\n";
      buttons.innerHtml += level;
      var lvl = querySelector('#box_level_$lev');
      lvl.style.backgroundImage = 'url(img/map_$lev.png)';
      lvl.style.backgroundSize = '100% 100%';
    }
  }

  void generateMap(List<Turm> buy) {
      generateBuyMenu(buy);
      levelview.style.display = 'grid';
  }

  void spawn(Feinde f) {
    var ht = map.innerHtml;
    ht += '\n<div class=${f.name} id=${f.name}_${f.id}></div>';
    map.setInnerHtml(ht);
    f.pos = f.goal;
  }

  void setTower(Turm turm) {
    var ht = map.innerHtml;
    ht += '\n<div class=${turm.name} id=${turm.name}_${turm.id}></div>';
    map.setInnerHtml(ht);
  }

  void generateBuyMenu(List<Turm> tower) {
    var html = '';
    for (var t in tower) {
      html += "<button draggable='true' class='buy_tower' id='${t.name}'>${t.kosten}</button>\n";
      buemenue.innerHtml += html;
    }
  }

  void generateInfobar() {
    ak.setInnerHtml('Antikoerper: ${model.ak}');
    tp.setInnerHtml('Leben: ${model.leben}');
    wavecount.setInnerHtml('Welle : ${model.wellen.length}/3');
  }

  void cleanMap() {
    for (Feinde f in model.feinde) {
        var feind = querySelector('#${f.name}_${f.id}');
        feind.style.display = 'none';
        feind.remove();
      }
    for (Turm t in model.turm) {
      var turm = querySelector('#${t.name}_${t.id}');
      turm.style.display = 'none';
      turm.remove();
    }
  }

  void win() {
    cleanMap();
    map.innerHtml += 'WIN!';
  }

  void gameOver() {
    cleanMap();
    map.innerHtml += 'GAME OVER!';
  }
}
