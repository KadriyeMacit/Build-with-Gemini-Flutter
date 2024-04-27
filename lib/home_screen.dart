import 'package:flutter/material.dart';
import 'package:flutter_gemini_sample/model/section_item.dart';
import 'package:flutter_gemini_sample/sections/chat.dart';
import 'package:flutter_gemini_sample/sections/text_and_image.dart';
import 'package:flutter_gemini_sample/sections/text_only.dart';
import 'package:flutter_gemini_sample/widgets/common_body.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _sections = <SectionItem>[
    SectionItem("Image detector", const SectionTextAndImageInput()),
    SectionItem("Chat to Gemini AI", const SectionChat()),
    SectionItem("Ask a question", const SectionTextInput()),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _sections.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(_sections[index].title),
                  onTap: () =>
                      _onTap(_sections[index].widget, _sections[index].title),
                ),
              ),
            );
          },
        ),
        Lottie.asset("assets/lottie/gemini.json")
      ],
    );
  }

  void _onTap(Widget screen, String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommonBody(screen: screen, title: title)));
  }
}
