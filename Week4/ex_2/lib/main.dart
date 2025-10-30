import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Container Insets BoxDecoration',
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Colors.grey[100],
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(40.0),
            // this is the lighter-blue frame
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              // inner card (stronger blue) with rounded corners
              width: 300,
              height: 420,
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const Center(
                child: Text(
                  'CADT STUDENTS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
