import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/primary_button.dart';

/// Stateless Hello World screen
class HelloPage extends StatelessWidget {
  final bool cupertino;
  const HelloPage({super.key, this.cupertino = false});

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Hello, World!'),
          const SizedBox(height: 12),
          PrimaryButton(label: 'Say Hi', onPressed: () {} , cupertino: cupertino),
        ],
      ),
    );

    if (cupertino) {
      return CupertinoPageScaffold(child: content);
    }
    return Scaffold(body: content);
  }
}

