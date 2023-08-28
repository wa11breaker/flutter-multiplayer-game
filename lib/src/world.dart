import 'package:flutter/material.dart';

// https://gist.github.com/nosmirck/1305106bae6d43d05f57c7bb254f9ff9
const worldWidth = 2160.0;
const worldHeight = 3840.0;

const viewPort = 500;
const viewPorty = 400;

class WolrldPainterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = const Color(0xff869456);

    canvas.drawRect(
      const Offset(
            -worldWidth / 2,
            -worldHeight / 2,
          ) &
          const Size(worldWidth, worldHeight),
      paint,
    );
  }

  @override
  bool shouldRepaint(WolrldPainterPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(WolrldPainterPainter oldDelegate) => false;
}
