import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lottie/lottie.dart';

class SectionBody extends StatelessWidget {
  const SectionBody(
      {super.key,
      required this.isLoading,
      required this.asset,
      required this.result,
      required this.loadingAsset});
  final bool isLoading;
  final String asset;
  final String? result;
  final String loadingAsset;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: isLoading
          ? Lottie.asset(loadingAsset, height: 250, width: 200)
          : result != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Markdown(data: result!),
                )
              : Lottie.asset(asset),
    );
  }
}
