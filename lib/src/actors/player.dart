import 'dart:async';

import 'package:flame/components.dart';
import 'package:game/src/game.dart';

enum PlayerState {
  idle,
  running,
  jumping,
  falling,
  hit,
  appearing,
  disappearing
}

class Player extends SpriteAnimationGroupComponent with HasGameRef<AppGame> {
  Player({position}) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runAnimation;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimation();
    return super.onLoad();
  }

  void _loadAllAnimation() {
    idleAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('characters/character-1/idle sheet-Sheet.png'),
      SpriteAnimationData.sequenced(
        amount: 18,
        stepTime: 0.05,
        textureSize: Vector2.all(80),
      ),
    );

    runAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('characters/character-1/idle sheet-Sheet.png'),
      SpriteAnimationData.sequenced(
        amount: 18,
        stepTime: 0.05,
        textureSize: Vector2.all(80),
      ),
    );

    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runAnimation,
    };
    current = PlayerState.idle;
  }
}
