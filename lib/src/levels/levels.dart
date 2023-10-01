import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game/src/actors/player.dart';

class Level extends World {
  late TiledComponent level;

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('world.tmx', Vector2.all(32));
    add(level);

    final spawnPoint = level.tileMap.getLayer<ObjectGroup>('spawn_points');
    for (final sp in spawnPoint!.objects) {
      switch (sp.class_) {
        case 'player':
          final player = Player(position: Vector2(sp.x, sp.y));
          add(player);

          add(Player(position: Vector2(sp.x + 50, sp.y + 50)));
          break;
        default:
      }
    }

    return super.onLoad();
  }
}
