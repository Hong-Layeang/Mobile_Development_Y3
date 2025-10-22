import 'package:test/test.dart';
import 'package:my_first_project/domain/quiz.dart';

void main() {
  
  test('Question has UUID', () {
    Question q = Question(
      title: "Test?",
      choices: ["A", "B"],
      goodChoice: "A"
    );
    
    expect(q.id, isNotEmpty);
    expect(q.id.length, equals(36)); // UUID length
  });

  test('Question can have custom ID', () {
    Question q = Question(
      id: "custom-id",
      title: "Test?",
      choices: ["A", "B"],
      goodChoice: "A"
    );
    
    expect(q.id, equals("custom-id"));
  });

  test('Answer references question by ID', () {
    Question q = Question(
      id: "q1",
      title: "Test?",
      choices: ["A", "B"],
      goodChoice: "A"
    );
    
    Answer a = Answer(
      questionId: "q1",
      answerChoice: "A"
    );
    
    expect(a.questionId, equals("q1"));
    expect(a.isGood(q), isTrue);
  });

  test('Submission with all correct answers', () {
    Question q1 = Question(
      id: "q1",
      title: "2 + 2 = ?",
      choices: ["3", "4", "5"],
      goodChoice: "4",
      points: 10
    );
    
    Question q2 = Question(
      id: "q2",
      title: "Capital of France?",
      choices: ["Paris", "London", "Rome"],
      goodChoice: "Paris",
      points: 50
    );
    
    List<Question> questions = [q1, q2];
    
    Answer a1 = Answer(questionId: "q1", answerChoice: "4");
    Answer a2 = Answer(questionId: "q2", answerChoice: "Paris");
    
    Submission submission = Submission(
      playerName: "Alice",
      answers: [a1, a2]
    );
    
    expect(submission.getScoreInPercentage(questions), equals(100));
    expect(submission.getScore(questions), equals(60));
  });

  test('Multiple players with IDs', () {
    Question q1 = Question(
      id: "q1",
      title: "2 + 2 = ?",
      choices: ["3", "4", "5"],
      goodChoice: "4",
      points: 10
    );
    
    Question q2 = Question(
      id: "q2",
      title: "Capital of France?",
      choices: ["Paris", "London", "Rome"],
      goodChoice: "Paris",
      points: 50
    );
    
    Quiz quiz = Quiz(questions: [q1, q2]);
    
    // Alice plays
    Answer a1_alice = Answer(questionId: "q1", answerChoice: "4");
    Answer a2_alice = Answer(questionId: "q2", answerChoice: "Paris");
    Submission alice = Submission(
      playerName: "Alice",
      answers: [a1_alice, a2_alice]
    );
    quiz.addSubmission(alice);
    
    // Bob plays
    Answer a1_bob = Answer(questionId: "q1", answerChoice: "3");
    Answer a2_bob = Answer(questionId: "q2", answerChoice: "Paris");
    Submission bob = Submission(
      playerName: "Bob",
      answers: [a1_bob, a2_bob]
    );
    quiz.addSubmission(bob);
    
    expect(quiz.submissions.length, equals(2));
    expect(alice.getScore([q1, q2]), equals(60));
    expect(bob.getScore([q1, q2]), equals(50));
  });

  test('Quiz can find question by ID', () {
    Question q1 = Question(id: "q1", title: "Test 1", choices: ["A"], goodChoice: "A");
    Question q2 = Question(id: "q2", title: "Test 2", choices: ["B"], goodChoice: "B");
    
    Quiz quiz = Quiz(questions: [q1, q2]);
    
    expect(quiz.getQuestionById("q1"), equals(q1));
    expect(quiz.getQuestionById("q2"), equals(q2));
    expect(quiz.getQuestionById("q999"), isNull);
  });

  test('Quiz can find submission by ID', () {
    Question q = Question(title: "Test", choices: ["A"], goodChoice: "A");
    Quiz quiz = Quiz(questions: [q]);
    
    Submission sub = Submission(
      id: "sub-123",
      playerName: "Alice",
      answers: []
    );
    quiz.addSubmission(sub);
    
    expect(quiz.getSubmissionById("sub-123"), equals(sub));
    expect(quiz.getSubmissionById("sub-999"), isNull);
  });

  test('Question toJson and fromJson', () {
    Question original = Question(
      id: "q1",
      title: "Test Question",
      choices: ["A", "B", "C"],
      goodChoice: "B",
      points: 25
    );
    
    Map<String, dynamic> json = original.toJson();
    Question restored = Question.fromJson(json);
    
    expect(restored.id, equals(original.id));
    expect(restored.title, equals(original.title));
    expect(restored.choices, equals(original.choices));
    expect(restored.goodChoice, equals(original.goodChoice));
    expect(restored.points, equals(original.points));
  });

  test('Answer toJson and fromJson', () {
    Answer original = Answer(
      id: "a1",
      questionId: "q1",
      answerChoice: "Paris"
    );
    
    Map<String, dynamic> json = original.toJson();
    Answer restored = Answer.fromJson(json);
    
    expect(restored.id, equals(original.id));
    expect(restored.questionId, equals(original.questionId));
    expect(restored.answerChoice, equals(original.answerChoice));
  });

  test('Quiz toJson and fromJson', () {
    Quiz original = Quiz(
      id: "quiz-1",
      questions: [
        Question(id: "q1", title: "Test", choices: ["A", "B"], goodChoice: "A", points: 10),
        Question(id: "q2", title: "Test2", choices: ["C", "D"], goodChoice: "C", points: 20),
      ]
    );
    
    Map<String, dynamic> json = original.toJson();
    Quiz restored = Quiz.fromJson(json);
    
    expect(restored.id, equals(original.id));
    expect(restored.questions.length, equals(2));
    expect(restored.questions[0].id, equals("q1"));
    expect(restored.questions[1].id, equals("q2"));
  });
}