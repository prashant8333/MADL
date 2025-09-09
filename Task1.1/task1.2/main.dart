import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rating Demo',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: SafeArea(
          child: Center(
            child: RatingWidget(),
          ),
        ),
      ),
    );
  }
}

class RatingWidget extends StatefulWidget {
  const RatingWidget({super.key});

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int _rating = 0; // current rating (0 to 5)

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Row of stars
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < _rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 36,
              ),
              onPressed: () {
                setState(() {
                  _rating = index + 1; // set rating
                });
              },
            );
          }),
        ),
        const SizedBox(height: 16),
        Text(
          "Current Rating: $_rating / 5",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
