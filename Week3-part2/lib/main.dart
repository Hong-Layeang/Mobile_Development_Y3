import 'data/quiz_file_provider.dart';
import 'domain/quiz.dart';
import 'ui/quiz_console.dart';

void main() {
  // Create repository
  QuizFileProvider repository = QuizFileProvider(filePath: 'questions.json');

  // Load quiz from file
  Quiz quiz;
  
  try {
    quiz = repository.readQuiz();
    print('Quiz loaded successfully!\n');
  } catch (e) {
    print('Error loading quiz: $e');
    print('Creating a default quiz instead...\n');
    
    // Fallback: create default quiz
    quiz = Quiz(
      questions: [
        Question(
          title: "Capital of France?",
          choices: ["Paris", "London", "Rome"],
          goodChoice: "Paris",
          points: 10
        ),
        Question(
          title: "2 + 2 = ?",
          choices: ["2", "4", "5"],
          goodChoice: "4",
          points: 50
        ),
      ]
    );
  }

  // Start quiz console
  QuizConsole console = QuizConsole(quiz: quiz);
  console.startQuiz();

  // Save quiz with all submissions when done
  try {
    repository.writeQuiz(quiz);
  } catch (e) {
    print('Error saving quiz: $e');
  }
}