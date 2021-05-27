part of ImmunityTD;

class View {
  final text = querySelector('#text');

  final buttons = querySelector('#buttons');

  final buemenue = querySelector('#buymenu_wrapper');

  final menu = querySelector('#menu');

  final levelview = querySelector('#level');

  final field = querySelector('#field');

  final map = querySelector('#map');

  HtmlElement get startButton => querySelector('#startButton');

  void generateLevel() {
    levelview.style.display = "none";
    String level = "";
    for (int levels = 1; levels <= 10; levels++) {
      level += "<button class='box_level'>Level $levels</button>\n";
    }
    buttons.innerHtml = level;
  }

  void generateMap() {
    String table = "";
    for (int row = 1; row < 9; row++) {
      table += "<tr>";
      for (int col = 1; col < 17; col++) {
        table += "<td></td>";
      }
      table += "</tr>\n";
    }
    field.innerHtml = table;
    generateBuyMenu();
    levelview.style.display = "grid";
  }

  void spawn(Feinde f) {
    String name = 'corona';
    map.innerHtml += '<div class=$name id=${name}_${f.id}></div>';
    var corona = querySelector('#${name}_${f.id}');
    f.setPos(new Position(map.getBoundingClientRect().left.toInt(),
        map.getBoundingClientRect().height.toInt() / 8 * 3));
    corona?.style.left = "${f.getPos().x}px";
    corona?.style.top = "${f.getPos().y}px";
  }

  void generateBuyMenu() {
    String level = "";
    for (int levels = 1; levels <= 4; levels++) {
      level += "<button class='box_level'>Level $levels</button>\n";
    }
    buemenue.innerHtml = level;
  }
}
