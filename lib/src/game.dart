import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:game/src/levels/levels.dart';
import 'package:game/src/player/player.dart';
import 'package:game/src/state/player_state.dart';

class AppGame extends FlameGame with HasKeyboardHandlerComponents {
  late final CameraComponent cam;
  final world = Level();

  late PlayerState playerState;
  late Player player;

  @override
  Color backgroundColor() {
    return Colors.blueGrey[400]!;
  }

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
    _spawnPlayer();

    return super.onLoad();
  }

  Future<void> _spawnPlayer() async {
    final level = await TiledComponent.load('world.tmx', Vector2.all(32));
    final spawnPoint = level.tileMap.getLayer<ObjectGroup>('spawn_points');

    for (final sp in spawnPoint!.objects) {
      if (sp.class_ == 'player') {
        playerState = PlayerState(isMe: true, xPosition: sp.x, yPosition: sp.y);
        player = Player(position: Vector2(sp.x, sp.y));
        add(player);
        cam.follow(player);
        break;
      }
    }
  }
}
