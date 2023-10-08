import 'dart:convert';

import 'package:flame/extensions.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PlayerState {
  PlayerState({
    this.health = 100,
    required this.isMe,
    required this.position,
  });

  bool isMe;
  late double health;
  late Vector2 position;

  late WebSocketChannel channel;
  bool connected = false;

  void init() {
    if (connected) return;

    print('conecting...');
    try {
      channel = IOWebSocketChannel.connect("ws://localhost:8080/ws");
      connected = true;
      print('WS connected');
    } catch (e) {
      print(e.toString());
    }
  }

  void updatePosition(Vector2 updatedPostion) {
    if (!connected) return;
    final data = {
      "x": updatedPostion.x,
      "y": updatedPostion.y,
    };
    position = updatedPostion;
    channel.sink.add(json.encode(data));
  }
}
