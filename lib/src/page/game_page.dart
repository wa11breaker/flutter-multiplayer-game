import 'package:flutter/material.dart';
import 'package:game/src/game.dart';
import 'package:flame/game.dart';

class GameWrapperPage extends StatelessWidget {
  const GameWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(game: AppGame()),
    );
  }
}
