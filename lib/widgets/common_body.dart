import 'package:flutter/material.dart';

class CommonBody extends StatelessWidget {
  const CommonBody({super.key, required this.screen, required this.title});
  final Widget screen;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(title),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
        child: screen,
      ),
    );
  }
}
