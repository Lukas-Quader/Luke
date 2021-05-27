part of ImmunityTD;

class View {
  final text = querySelector('#text');

  final buttons = querySelector('#buttons');

  final buemenue = querySelector('#buymenu_wrapper');

  final menu = querySelector('#menu');

  final levelview = querySelector('#level');

  final map = querySelector('#field');

  HtmlElement get startButton => querySelector('#startButton');
  int count = 0;

  void generateLevel() {
    levelview.style.display = "none";
    String level = "";
    for (int levels = 1; levels <= 10; levels++) {
      level += "<button class='box_level'>Level $levels</button>\n";
    }
    buttons.innerHtml = level;
  }

  void generateMap() {
    levelview.style.display = "none";
    String table = "";
    for (int row = 1; row < 9; row++) {
      table += "<tr>";
      for (int col = 1; col < 17; col++) {
        table += "<td>$row + $col</td>";
      }
      table += "</tr>\n";
    }
    map.innerHtml = table;
    generateBuyMenu();
    levelview.style.display = "grid";
  }

  void generateBuyMenu() {
    String level = "";
    for (int levels = 1; levels <= 4; levels++) {
      level += "<button class='box_level'>Level $levels</button>\n";
    }
    buemenue.innerHtml = level;
  }
}
