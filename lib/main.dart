import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_gemini_sample/home_screen.dart';
import 'package:flutter_gemini_sample/widgets/common_body.dart';

void main() {
  /// flutter run --dart-define=apiKey='Your Api Key'
  Gemini.init(
      apiKey: const String.fromEnvironment('apiKey'), enableDebugging: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Gemini',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const CommonBody(screen: HomeScreen(), title: "Gemini Sample"));
  }
}
