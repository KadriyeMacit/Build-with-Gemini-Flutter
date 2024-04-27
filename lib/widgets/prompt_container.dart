import 'package:flutter/material.dart';

class PromptContainer extends StatelessWidget {
  const PromptContainer({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
          ),
        ),
      ),
    );
  }
}
