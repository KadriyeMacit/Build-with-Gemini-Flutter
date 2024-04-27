import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_gemini_sample/widgets/input_container.dart';
import 'package:flutter_gemini_sample/widgets/prompt_container.dart';
import 'package:flutter_gemini_sample/widgets/section_body.dart';

class SectionTextInput extends StatefulWidget {
  const SectionTextInput({super.key});

  @override
  State<SectionTextInput> createState() => _SectionTextInputState();
}

class _SectionTextInputState extends State<SectionTextInput> {
  final controller = TextEditingController();
  final gemini = Gemini.instance;
  String? searchedText, result;
  bool _loading = false;

  bool get loading => _loading;
  set loading(bool set) => setState(() => _loading = set);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (searchedText != null)
          PromptContainer(text: searchedText.toString()),
        SectionBody(
          isLoading: loading,
          result: result,
          loadingAsset: "assets/lottie/search.json",
          asset: "assets/lottie/ask.json",
        ),
        InputContainer(controller: controller, onSend: _onSend),
      ],
    );
  }

  void _onSend() {
    if (controller.text.isNotEmpty) {
      searchedText = controller.text;
      controller.clear();
      loading = true;

      gemini.text(searchedText!).then((value) {
        result = value?.content?.parts?.last.text;
        loading = false;
      });
    }
  }
}
