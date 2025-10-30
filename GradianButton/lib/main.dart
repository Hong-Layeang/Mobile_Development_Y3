import 'package:flutter/material.dart';

void main() {

  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientButton("hello 1", start: Colors.blue, end: Colors.red),
              SizedBox(height: 10),
              GradientButton("hello 2", start: Colors.green, end: Colors.purple),
              SizedBox(height: 10),
              GradientButton("hello 3", start: Colors.orange, end: Colors.pink),
            ],
          ),
        ),
      ),
    ),
  );
}

// Custom GradientButton widget
class GradientButton extends StatelessWidget {
  final String text;
  final Color start;
  final Color end;

  const GradientButton(this.text, {super.key, required this.start, required this.end});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [start, end]),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () {
          print('$text pressed');
        },
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 35),
        )
      )
    );
  }
}