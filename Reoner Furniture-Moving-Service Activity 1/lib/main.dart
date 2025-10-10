import 'package:flutter/material.dart';

import 'views/home/home_material.dart';
import 'views/home/home_cupertino.dart';

void main() => runApp(const FurnitureMovingApp());

class FurnitureMovingApp extends StatelessWidget {
  const FurnitureMovingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Furniture Moving Service',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const RootSwitcher(),
    );
  }
}

/// Toggles between Material and Cupertino versions of the same UI
class RootSwitcher extends StatefulWidget {
  const RootSwitcher({super.key});

  @override
  State<RootSwitcher> createState() => _RootSwitcherState();
}

class _RootSwitcherState extends State<RootSwitcher> {
  bool useCupertino = false;

  @override
  Widget build(BuildContext context) {
    if (useCupertino) {
      return HomeCupertino(onTogglePlatform: _togglePlatform);
    }
    return HomeMaterial(onTogglePlatform: _togglePlatform);
  }

  void _togglePlatform() {
    setState(() {
      useCupertino = !useCupertino;
    });
  }
}
