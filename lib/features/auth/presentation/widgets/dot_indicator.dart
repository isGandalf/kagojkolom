import 'package:flutter/material.dart';

class DotIndicator extends Decoration {
  final Color color;
  final double radius;

  const DotIndicator({this.color = Colors.blue, this.radius = 4});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DotPainter(color, radius);
  }
}

class _DotPainter extends BoxPainter {
  final Color color;
  final double radius;

  _DotPainter(this.color, this.radius);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration config) {
    final Paint paint = Paint()..color = color;

    // Center x of the tab
    final double x = offset.dx + config.size!.width / 2;

    // Position y just above the bottom of the tab
    final double y = offset.dy + config.size!.height - radius;

    canvas.drawCircle(Offset(x, y), radius, paint);
  }
}
