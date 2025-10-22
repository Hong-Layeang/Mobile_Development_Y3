import 'quiz.dart';
import 'question.dart';
import 'answer.dart';

void main() {
  // create a quiz
  final quiz = Quiz(id: 'qz1', title: 'Simple Quiz');

  // question 1
  final q1 = Question(
    id: 'q1',
    title: 'What is 2+2?',
    choices: ['3', '4', '5'],
    goodChoiceIndexes: [1],
    type: QuestionType.SINGLE_CHOICE,
  );

  // question 2 (multi)
  final q2 = Question(
    id: 'q2',
    title: 'Select prime numbers',
    choices: ['2', '3', '4', '5'],
    goodChoiceIndexes: [0,1,3],
    type: QuestionType.MULTI_CHOICE,
  );

  quiz.addQuestion(q1);
  quiz.addQuestion(q2);

  // add answers
  final a1 = Answer(id: 'a1', questionId: 'q1', selectedChoiceIndexes: [1]);
  final a2 = Answer(id: 'a2', questionId: 'q2', selectedChoiceIndexes: [0,1,3]);

  quiz.addAnswer(a1);
  quiz.addAnswer(a2);

  // compute score by matching answers to questions
  int correct = 0;
  for (var ans in quiz.answers) {
    final question = quiz.questions.firstWhere((q) => q.id == ans.questionId);
    if (question.isCorrect(ans)) correct++;
  }

  print('Score: $correct / ${quiz.questions.length}');
}
