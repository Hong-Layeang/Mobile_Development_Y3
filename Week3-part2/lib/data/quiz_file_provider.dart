import 'dart:io';
import 'dart:convert';
import '../domain/quiz.dart';

class QuizFileProvider {
  final String filePath;

  QuizFileProvider({required this.filePath});

  // READ Quiz from JSON file
  Quiz readQuiz() {
    final file = File(filePath);
    
    if (!file.existsSync()) {
      throw Exception('File not found: $filePath');
    }
    
    final content = file.readAsStringSync();
    final data = jsonDecode(content) as Map<String, dynamic>;
    
    // Use the fromJson factory method
    return Quiz.fromJson(data);
  }

  // WRITE Quiz to JSON file
  void writeQuiz(Quiz quiz) {
    final file = File(filePath);
    
    // Convert quiz to JSON
    final jsonData = quiz.toJson();
    
    // Convert to pretty JSON string
    final jsonString = JsonEncoder.withIndent('  ').convert(jsonData);
    
    // Write to file
    file.writeAsStringSync(jsonString);
    
    print('Quiz saved to $filePath');
  }

  // Check if file exists
  bool fileExists() {
    return File(filePath).existsSync();
  }
}