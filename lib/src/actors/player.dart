import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game/src/game.dart';

enum PlayerState { idle, running }

enum PlayerDirection { left, right, top, bottom, idel }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<AppGame>, KeyboardHandler {
  Player({position}) : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runAnimation;

  PlayerDirection playerDirection = PlayerDirection.idel;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  bool isFacingLeft = false;

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

    if (isLeftKeyPressed && isRightKeyPressed) {
      playerDirection = PlayerDirection.idel;
    } else if (isLeftKeyPressed) {
      playerDirection = PlayerDirection.left;
    } else if (isRightKeyPressed) {
      playerDirection = PlayerDirection.right;
    } else if (isUpKeyPressed) {
      playerDirection = PlayerDirection.top;
    } else if (isDownKeyPressed) {
      playerDirection = PlayerDirection.bottom;
    } else {
      playerDirection = PlayerDirection.idel;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  void _updatePlayerMovement(double dt) {
    double dirX = 0.0;
    double dirY = 0.0;

    switch (playerDirection) {
      case PlayerDirection.left:
        current = PlayerState.running;
        dirX -= moveSpeed;
        if (!isFacingLeft) {
          flipHorizontallyAroundCenter();
          isFacingLeft = true;
        }
        break;
      case PlayerDirection.right:
        dirX += moveSpeed;
        if (isFacingLeft) {
          flipHorizontallyAroundCenter();
          isFacingLeft = false;
        }
        break;
      case PlayerDirection.top:
        dirY -= moveSpeed;
        break;
      case PlayerDirection.bottom:
        dirY += moveSpeed;
        break;
      case PlayerDirection.idel:
        current = PlayerState.idle;
        break;

      default:
        break;
    }

    velocity = Vector2(dirX, dirY);
    position += velocity * dt;
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
