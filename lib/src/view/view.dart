part of ImmunityTD;

class View {
  
  Level model;

  final text = querySelector('#text');

  final buttons = querySelector('#buttons');

  final buemenue = querySelector('#buymenu_wrapper');

  final menu = querySelector('#menu');

  final levelview = querySelector('#level');

  final field = querySelector('#field');

  final map = querySelector('#map');

  HtmlElement get startButton => querySelector('#startButton');

  View();

  void setModel (Level model) {
    this.model = model;
  }

  void update() {
    if(!model.feinde.isEmpty){
      for(Feinde f in model.feinde) {
        var feind = querySelector('#${f.name}_${f.id}');
        feind?.style.left = "${f.getPos().x}px";
        feind?.style.top = "${f.getPos().y}px";
        if(f.fin) feind.style.display = "none";
      }
    }
  }

  void showPoints(List<Position> way) {
    int i = 0;
    for(Position p in way) {
          var pos = querySelector('#wp_$i');
          pos?.style.left = "${p.x}px";
          pos?.style.top = "${p.y}px";
          i++;
      }
  }

  void generatePoints(List<Position> way) {
    int i = 0;
    for(Position p in way) {
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
    map.innerHtml += '<div class=${f.name} id=${f.name}_${f.id}></div>';
    f.setPos(f.goal);
  }

  void generateBuyMenu() {
    String level = "";
    for (int levels = 1; levels <= 4; levels++) {
      level += "<button class='box_level'>Level $levels</button>\n";
    }
    buemenue.innerHtml = level;
  }
}