import "package:flutter/material.dart";
import "package:flutter_gemini/flutter_gemini.dart";
import "package:flutter_gemini_sample/model/chat_enum.dart";
import "package:flutter_gemini_sample/widgets/input_container.dart";
import "package:flutter_gemini_sample/widgets/message_container.dart";
import "package:lottie/lottie.dart";

class SectionChat extends StatefulWidget {
  const SectionChat({super.key});

  @override
  State<SectionChat> createState() => _SectionChatState();
}

class _SectionChatState extends State<SectionChat> {
  final controller = TextEditingController();
  final gemini = Gemini.instance;
  bool _loading = false;
  final List<Content> chats = [];

  bool get loading => _loading;
  set loading(bool set) => setState(() => _loading = set);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: chats.isNotEmpty
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    reverse: true,
                    child: ListView.builder(
                      itemBuilder: (context, index) =>
                          MessageContainer(content: chats[index]),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: chats.length,
                      reverse: false,
                    ),
                  ),
                )
              : Lottie.asset("assets/lottie/hello.json"),
        ),
        if (loading) Lottie.asset("assets/lottie/points.json", width: 150),
        InputContainer(
          hintText: "Send a message",
          controller: controller,
          onSend: _onSend,
        ),
      ],
    );
  }

  void _onSend() {
    if (controller.text.isNotEmpty) {
      final searchedText = controller.text;
      chats.add(
        Content(
          role: ChatAuth.user.name,
          parts: [Parts(text: searchedText)],
        ),
      );
      controller.clear();
      loading = true;

      gemini.chat(chats).then((value) {
        chats.add(
          Content(
            role: ChatAuth.model.name,
            parts: [Parts(text: value?.output)],
          ),
        );
        loading = false;
      });
    }
  }
}
