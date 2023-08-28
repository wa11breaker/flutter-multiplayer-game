import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game/src/world.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  double _turn = 0.0;
  double _x = 0.0;
  double _y = 0.0;

  void _gameLoop() {
    setState(() {
      _turn += 0.01;
      _x += 0.1;
      _y += 0.2;
    });
  }

  @override
  void initState() {
    super.initState();

    // Create a timer that will call the gameLoop() function every frame.
    Timer.periodic(Duration(milliseconds: 100), (_) => _gameLoop());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          painter: WolrldPainterPainter(),
        ),
      ),
    );
  }
}
