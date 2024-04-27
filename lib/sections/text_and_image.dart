import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_gemini_sample/widgets/input_container.dart';
import 'package:flutter_gemini_sample/widgets/prompt_container.dart';
import 'package:flutter_gemini_sample/widgets/section_body.dart';
import 'package:image_picker/image_picker.dart';

class SectionTextAndImageInput extends StatefulWidget {
  const SectionTextAndImageInput({super.key});

  @override
  State<SectionTextAndImageInput> createState() =>
      _SectionTextAndImageInputState();
}

class _SectionTextAndImageInputState extends State<SectionTextAndImageInput> {
  final ImagePicker picker = ImagePicker();
  final controller = TextEditingController();
  final gemini = Gemini.instance;
  String? searchedText, result;
  bool _loading = false;

  Uint8List? selectedImage;

  bool get loading => _loading;
  set loading(bool set) => setState(() => _loading = set);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selectedImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(
                    selectedImage!,
                    fit: BoxFit.cover,
                    height: 220,
                    width: double.infinity,
                  ),
                ),
              const SizedBox(height: 10),
              if (searchedText != null)
                PromptContainer(text: searchedText.toString()),
              SectionBody(
                isLoading: loading,
                result: result,
                loadingAsset: "assets/lottie/image.json",
                asset: "assets/lottie/ask.json",
              ),
            ],
          ),
        ),
        InputContainer(
          controller: controller,
          onClickAsset: _onClickAsset,
          onSend: _onSend,
        ),
      ],
    );
  }

  void _onSend() {
    if (controller.text.isNotEmpty && selectedImage != null) {
      searchedText = controller.text;
      controller.clear();
      loading = true;

      gemini.textAndImage(text: searchedText!, images: [selectedImage!]).then(
          (value) {
        result = value?.content?.parts?.last.text;
        loading = false;
      });
    }
  }

  void _onClickAsset() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);

    if (photo != null) {
      photo.readAsBytes().then((value) => setState(() {
            selectedImage = value;
          }));
    }
  }
}
