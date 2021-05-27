part of ImmunityTD;

class Position {
  num x, y;

  Position(this.x, this.y);

  operator +(Position next) => new Position(x + next.x, y + next.y);
  operator -(Position next) => new Position(x - next.x, y - next.y);

  num dist(Position anderer) => Math.sqrt(
      Math.pow(this.x - anderer.x, 2) + Math.pow(this.y - anderer.y, 2));
}
