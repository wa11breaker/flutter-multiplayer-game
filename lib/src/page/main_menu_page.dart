import 'package:flutter/material.dart';
import 'package:game/src/page/game_page.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    void start() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const GameWrapperPage(),
        )
      );
    }

    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: start,
                child: const Text("Start"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
