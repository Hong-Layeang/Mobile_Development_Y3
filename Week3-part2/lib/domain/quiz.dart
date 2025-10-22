import 'package:uuid/uuid.dart';

class Question{
  final String id;
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int points;

  Question({
    String? id,
    required this.title, 
    required this.choices, 
    required this.goodChoice,
    this.points = 1
  }) : id = id ?? Uuid().v4();

  // Convert Question to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'choices': choices,
      'goodChoice': goodChoice,
      'points': points,
    };
  }

  // Create Question from JSON
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      title: json['title'],
      choices: List<String>.from(json['choices']),
      goodChoice: json['goodChoice'],
      points: json['points'] ?? 1,
    );
  }
}

class Answer{
  final String id;
  final String questionId;
  final String answerChoice;
  
  Answer({
    String? id,
    required this.questionId,
    required this.answerChoice
  }) : id = id ?? Uuid().v4();

  // Need Question object to check if good
  bool isGood(Question question){
    return this.answerChoice == question.goodChoice;
  }

  // Convert Answer to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionId': questionId,
      'answerChoice': answerChoice,
    };
  }

  // Create Answer from JSON
  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      questionId: json['questionId'],
      answerChoice: json['answerChoice'],
    );
  }
}

class Submission {
  final String id;
  final String playerName;
  final List<Answer> answers;
  final DateTime submittedAt;

  Submission({
    String? id,
    required this.playerName,
    required this.answers,
    DateTime? submittedAt,
  }) : id = id ?? Uuid().v4(),
       submittedAt = submittedAt ?? DateTime.now();

  int getScore(List<Question> questions) {
    int earnedPoints = 0;
    for (Answer answer in answers) {
      // Find the question by ID
      Question? question = questions.firstWhere(
        (q) => q.id == answer.questionId,
        orElse: () => questions.first, // Fallback
      );
      if (answer.isGood(question)) {
        earnedPoints += question.points;
      }
    }
    return earnedPoints;
  }

  int getScoreInPercentage(List<Question> questions) {
    int totalPossiblePoints = 0;
    for (var question in questions) {
      totalPossiblePoints += question.points;
    }
    
    if (totalPossiblePoints == 0) {
      return 0;
    }
    
    int earnedPoints = getScore(questions);
    return ((earnedPoints / totalPossiblePoints) * 100).toInt();
  }

  // Convert Submission to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'playerName': playerName,
      'answers': answers.map((a) => a.toJson()).toList(),
      'submittedAt': submittedAt.toIso8601String(),
    };
  }

  // Create Submission from JSON
  factory Submission.fromJson(Map<String, dynamic> json) {
    return Submission(
      id: json['id'],
      playerName: json['playerName'],
      answers: (json['answers'] as List)
          .map((a) => Answer.fromJson(a))
          .toList(),
      submittedAt: DateTime.parse(json['submittedAt']),
    );
  }
}

class Quiz{
  final String id;
  List<Question> questions;
  List<Submission> submissions = [];

  Quiz({
    String? id,
    required this.questions,
    List<Submission>? submissions,
  }) : id = id ?? Uuid().v4(),
       submissions = submissions ?? [];

  void addSubmission(Submission submission) {
    int existingIndex = submissions.indexWhere(
      (s) => s.playerName == submission.playerName
    );
    
    if (existingIndex != -1) {
      submissions[existingIndex] = submission;
    } else {
      submissions.add(submission);
    }
  }

  int getTotalPossiblePoints() {
    int total = 0;
    for (var question in questions) {
      total += question.points;
    }
    return total;
  }

  List<Submission> getAllSubmissions() {
    return List.unmodifiable(submissions);
  }

  // Get question by ID
  Question? getQuestionById(String questionId) {
    try {
      return questions.firstWhere((q) => q.id == questionId);
    } catch (e) {
      return null;
    }
  }

  // Get submission by ID
  Submission? getSubmissionById(String submissionId) {
    try {
      return submissions.firstWhere((s) => s.id == submissionId);
    } catch (e) {
      return null;
    }
  }

  // Convert Quiz to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questions': questions.map((q) => q.toJson()).toList(),
      'submissions': submissions.map((s) => s.toJson()).toList(),
    };
  }

  // Create Quiz from JSON
  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
      submissions: (json['submissions'] as List?)
          ?.map((s) => Submission.fromJson(s))
          .toList(),
    );
  }
}