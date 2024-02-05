import 'package:flutter/material.dart';
import '../presentation/ui/character_screen.dart';

class Application extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test app',
      home: CharactersScreen(),
    );
  }
}
