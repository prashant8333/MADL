import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RichText Toggle Demo',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ContentToggle(),
          ),
        ),
      ),
    );
  }
}

class ContentToggle extends StatefulWidget {
  const ContentToggle({super.key});

  @override
  State<ContentToggle> createState() => _ContentToggleState();
}

class _ContentToggleState extends State<ContentToggle> {
  bool _showFullText = false; // controls expanded/collapsed state

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: "Flutter is an amazing framework ",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              if (_showFullText)
                const TextSpan(
                  text:
                      "that allows developers to build cross-platform mobile, web, and desktop applications using a single codebase. It’s powered by Dart and provides beautiful UI components.",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            setState(() {
              _showFullText = !_showFullText; // toggle state
            });
          },
          child: Text(
            _showFullText ? "Read Less" : "Read More",
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
