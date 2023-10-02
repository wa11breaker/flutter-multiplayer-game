import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game/src/actors/player.dart';
import 'package:game/src/game.dart';

class Level extends World with ParentIsA<AppGame> {
  late TiledComponent level;
  late Player player;

  @override
  FutureOr<void> onLoad() async {
    await _setupLevel();
    await _setupActor();
    await _setupCamera();
    return super.onLoad();
  }

  _setupLevel() async {
    level = await TiledComponent.load('world.tmx', Vector2.all(32));
    add(level);
  }

  _setupActor() async {
    final spawnPoint = level.tileMap.getLayer<ObjectGroup>('spawn_points');

    for (final sp in spawnPoint!.objects) {
      switch (sp.class_) {
        case 'player':
          player = Player(position: Vector2(sp.x, sp.y));
          add(player);
          break;
        default:
      }
    }
  }

  _setupCamera() {
    parent.cam.follow(player, maxSpeed: 1000);
  }
}
