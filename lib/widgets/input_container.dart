import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  const InputContainer(
      {super.key,
      required this.controller,
      this.onSend,
      this.onClickAsset,
      this.hintText});

  final TextEditingController controller;
  final VoidCallback? onSend, onClickAsset;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (onClickAsset != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: IconButton(
                onPressed: onClickAsset,
                icon: const Icon(Icons.image_search, size: 32),
              ),
            ),
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 6,
              cursorColor: Theme.of(context).colorScheme.inversePrimary,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  hintText: hintText ?? "Enter a prompt",
                  border: InputBorder.none),
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FloatingActionButton(
              onPressed: onSend,
              elevation: 1,
              child: const Icon(Icons.send_rounded, size: 32),
            ),
          )
        ],
      ),
    );
  }
}
