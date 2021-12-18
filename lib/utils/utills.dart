import 'dart:math';

class Uttils {
  static double getXpoint(double center, double angle, double raduis) {
    return center + cos(angle) * raduis;
  }

  static double angleToRadian(double angle) {
    return angle * (pi / 180);
  }

  static double getYpoint(double center, double angle, double raduis) {
    return center + sin(angle) * raduis;
  }
}
