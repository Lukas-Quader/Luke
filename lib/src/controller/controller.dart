part of ImmunityTD;

class Controller {
  View view = new View();

  Controller() {
    view.generateLevel();
    view.startButton.onClick.listen((_) {});
  }
}
