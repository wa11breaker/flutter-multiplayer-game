import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game/src/levels/levels.dart';

class AppGame extends FlameGame {
  @override
  Color backgroundColor() {
    return Colors.green;
  }

  late final CameraComponent cam;
  final world = Level();

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    cam = CameraComponent.withFixedResolution(
      world: world,
      width: 1280,
      height: 1280,
    );
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([
      cam,
      world,
    ]);

    return super.onLoad();
  }
}
