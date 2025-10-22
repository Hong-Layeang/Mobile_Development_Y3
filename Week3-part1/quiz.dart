import 'question.dart';
import 'answer.dart';

class Quiz {
  final String id;
  String title;
  String description;
  final List<Question> questions = [];
  final List<Answer> _answers = []; // stored answers for an attempt

  Quiz({required this.id, required this.title, this.description = ''});

  void addQuestion(Question q) {
    questions.add(q);
  }

  void addAnswer(Answer answer) {
    _answers.add(answer);
  }

  /// Compute score as number of correct answers
  int getScore() {
    int score = 0;
    for (var ans in _answers) {
      if (ans.isCorrect()) score++;
    }
    return score;
  }

  void clearAnswers() => _answers.clear();

  List<Answer> get answers => List.unmodifiable(_answers);
}
