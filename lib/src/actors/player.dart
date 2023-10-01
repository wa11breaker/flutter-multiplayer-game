import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:game/src/game.dart';

enum PlayerState { idle, running }

enum PlayerDirection { left, right, top, bottom, idel }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<AppGame>, KeyboardHandler {
  Player({position}) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runAnimation;

  int horizontalInput = 0;
  int verticalInput = 0;

  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimation();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);

    final isUpKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp);

    final isDownKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyS) ||
        keysPressed.contains(LogicalKeyboardKey.arrowDown);

    if (isLeftKeyPressed) {
      horizontalInput = -1;
    } else if (isRightKeyPressed) {
      horizontalInput = 1;
    } else {
      horizontalInput = 0;
    }

    if (isUpKeyPressed) {
      verticalInput = -1;
    } else if (isDownKeyPressed) {
      verticalInput = 1;
    } else {
      verticalInput = 0;
    }

    super.onKeyEvent(event, keysPressed);
    return false;
  }

  void _updatePlayerMovement(double dt) {
    double dirX = 0.0;
    double dirY = 0.0;

    double _mSpeed = moveSpeed;
    if (horizontalInput.abs() == 1 && verticalInput.abs() == 1) {
      _mSpeed = moveSpeed / 1.5;
    }

    dirX += horizontalInput * _mSpeed;
    dirY += verticalInput * _mSpeed;

    velocity = Vector2(dirX, dirY);
    position += velocity * dt;
  }

  void _loadAllAnimation() {
    idleAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('texture/TX Player.png'),
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 0.05,
        textureSize: Vector2(32, 64),
      ),
    );

    animations = {
      PlayerState.idle: idleAnimation,
    };
    current = PlayerState.idle;
  }
}
