class PlayerState {
  PlayerState({
    this.health = 100,
    required this.isMe,
    required this.xPosition,
    required this.yPosition,
  });

  bool isMe;
  late double health;
  late double xPosition;
  late double yPosition;
}
