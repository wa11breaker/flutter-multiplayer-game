import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game/src/levels/levels.dart';

class AppGame extends FlameGame with HasKeyboardHandlerComponents {
  @override
  Color backgroundColor() {
    return Colors.blueGrey[400]!;
  }

  late final CameraComponent cam;
  final world = Level();

  @override
  FutureOr<void> onLoad() async {
    // Device setup
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    await images.loadAllImages();

    cam = CameraComponent.withFixedResolution(
      world: world,
      width: size.x / 1.5,
      height: size.y / 1.5,
    );
    cam.viewfinder.anchor = Anchor.center;

    addAll([
      cam,
      world,
    ]);

    return super.onLoad();
  }
}
