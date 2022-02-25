import 'package:flutter/material.dart';

class HeroTestPage extends StatelessWidget {
  const HeroTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: "hero test tag",
              child: Text(
                "AnimatedWidget",
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              child: const Text("test hero"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
