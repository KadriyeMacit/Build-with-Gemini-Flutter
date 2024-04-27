import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_gemini_sample/model/chat_enum.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({super.key, required this.content});
  final Content content;

  @override
  Widget build(BuildContext context) {
    final bool isModel = content.role == ChatAuth.model.name;
    final String title = isModel ? "Gemini AI" : "Kadriye";

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.black),
              textAlign: content.role == ChatAuth.model.name
                  ? TextAlign.start
                  : TextAlign.end,
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: isModel ? 24 : 0, left: !isModel ? 24 : 0),
          child: Card(
            elevation: 0,
            color: isModel
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Markdown(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                data:
                    content.parts?.lastOrNull?.text ?? "Can not generate data!",
                styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
                    textTheme: const TextTheme(
                        bodyMedium:
                            TextStyle(fontSize: 16, color: Colors.white)))),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
