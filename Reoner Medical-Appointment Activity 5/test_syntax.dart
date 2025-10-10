// Simple syntax test file
import 'package:flutter/material.dart';

void main() {
  print('Syntax test - all files should compile correctly');
}

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Test'),
      ),
    );
  }
}
