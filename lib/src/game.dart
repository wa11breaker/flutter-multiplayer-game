import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game/src/levels/levels.dart';

class AppGame extends FlameGame with HasKeyboardHandlerComponents {
  @override
  Color backgroundColor() {
    return const Color(0xff72751B);
  }

  late final CameraComponent cam;
  final world = Level();

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    cam = CameraComponent.withFixedResolution(
      world: world,
      width: 1920,
      height: 1080,
   );

    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([
      cam,
      world,
    ]);

    return super.onLoad();
  }
}
