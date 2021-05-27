part of ImmunityTD;

class Position {
  num x, y;

  Position(this.x, this.y);

  operator +(Position next) => new Position(x + next.x, y + next.y);
  operator -(Position next) => new Position(x - next.x, y - next.y);
  operator *(num speed) => new Position( x * speed, y * speed);
  operator <=(num next) => this.x <= next && this.y <= next;

  num length() => Math.sqrt(Math.pow(this.x, 2) + Math.pow(this.y, 2));
  Position uni() => this * (1/this.length());
  num dist(Position next) => Math.sqrt(
      Math.pow(this.x - next.x, 2) + Math.pow(this.y - next.y, 2));
}
