import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/primary_button.dart';

/// Stateful counter screen
class CounterPage extends StatefulWidget {
  final bool cupertino;
  const CounterPage({super.key, this.cupertino = false});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0;

  void _increment() => setState(() => count++);

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Count: $count'),
          const SizedBox(height: 12),
          PrimaryButton(
            label: 'Increment',
            onPressed: _increment,
            cupertino: widget.cupertino,
          ),
        ],
      ),
    );

    if (widget.cupertino) {
      return CupertinoPageScaffold(child: content);
    }
    return Scaffold(body: content);
  }
}

