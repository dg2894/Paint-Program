//takes position for the square, size, color to create color gallery
class Palette {
  float x, y, pSize;
  color c;

  Palette(int xPos, int yPos, int theSize, color theColor) {
    x = xPos;
    y = yPos;
    pSize = theSize;
    c = theColor;
    fill(c);
    rect(x, y, pSize, pSize);
  }
}

