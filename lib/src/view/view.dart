part of ImmunityTD;

class View {
  final text = querySelector('#text');

  final buttons = querySelector('.buttons');

  HtmlElement get startButton => querySelector('.startButton');
  int count = 0;

  void generateLevel() {
    String level = "";
    for (int levels = 1; levels <= 10; levels++) {
      level += "<button class='box_level'>Level $levels</button>\n";
    }
    buttons.innerHtml = level;
  }
}
