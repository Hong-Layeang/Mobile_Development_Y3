import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Score Bar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScoreScreen(),
    );
  }
}

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  int flutterScore = 7;
  int dartScore = 4;
  int reactScore = 10;

  void incrementScore(String subject) {
    setState(() {
      switch (subject) {
        case 'Flutter':
          if (flutterScore < 10) flutterScore++;
          break;
        case 'Dart':
          if (dartScore < 10) dartScore++;
          break;
        case 'React':
          if (reactScore < 10) reactScore++;
          break;
      }
    });
  }

  void decrementScore(String subject) {
    setState(() {
      switch (subject) {
        case 'Flutter':
          if (flutterScore > 0) flutterScore--;
          break;
        case 'Dart':
          if (dartScore > 0) dartScore--;
          break;
        case 'React':
          if (reactScore > 0) reactScore--;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[300],
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScoreCard(
                subject: 'Flutter',
                score: flutterScore,
                color: Colors.green[600]!,
                onIncrement: () => incrementScore('Flutter'),
                onDecrement: () => decrementScore('Flutter'),
              ),
              const SizedBox(height: 20),
              ScoreCard(
                subject: 'Dart',
                score: dartScore,
                color: Colors.green[400]!,
                onIncrement: () => incrementScore('Dart'),
                onDecrement: () => decrementScore('Dart'),
              ),
              const SizedBox(height: 20),
              ScoreCard(
                subject: 'React',
                score: reactScore,
                color: Colors.green[800]!,
                onIncrement: () => incrementScore('React'),
                onDecrement: () => decrementScore('React'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScoreCard extends StatelessWidget {
  final String subject;
  final int score;
  final Color color;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ScoreCard({
    super.key,
    required this.subject,
    required this.score,
    required this.color,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'My score in $subject',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onDecrement,
                icon: const Icon(Icons.remove),
                iconSize: 24,
              ),
              const SizedBox(width: 40),
              IconButton(
                onPressed: onIncrement,
                icon: const Icon(Icons.add),
                iconSize: 24,
              ),
            ],
          ),
          const SizedBox(height: 15),
          ProgressBar(
            score: score,
            color: color,
          ),
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  final int score;
  final Color color;

  const ProgressBar({
    super.key,
    required this.score,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background container (border + background)
        Container(
          height: 40,
          width: 240,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey[400]!,
              width: 2,
            ),
          ),
        ),
        // Progress indicator
        Container(
          height: 40,
          width: 240 * (score / 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    );
  }
}
