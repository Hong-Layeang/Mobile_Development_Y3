import 'dart:io';

import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('=== Welcome to the Quiz ===\n');

    while (true) {
      stdout.write('Enter player name (or press Enter to quit): ');
      String? playerName = stdin.readLineSync();

      if (playerName == null || playerName.trim().isEmpty) {
        print('\nThank you for playing!');
        break;
      }

      List<Answer> playerAnswers = [];
      
      print('\n--- ${playerName}, let\'s start! ---\n');

      for (var question in quiz.questions) {
        print('Question: ${question.title} (${question.points} points)');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();

        if (userInput != null && userInput.isNotEmpty) {
          // Create answer with question ID instead of question object
          Answer answer = Answer(
            questionId: question.id,  // Use ID now
            answerChoice: userInput
          );
          playerAnswers.add(answer);
        }

        print('');
      }

      Submission submission = Submission(
        playerName: playerName,
        answers: playerAnswers,
      );
      quiz.addSubmission(submission);

      int earnedPoints = submission.getScore(quiz.questions);
      int totalPoints = quiz.getTotalPossiblePoints();
      int percentage = submission.getScoreInPercentage(quiz.questions);
      
      print('--- Quiz Finished ---');
      print('$playerName\'s score: $earnedPoints points / $totalPoints ($percentage% correct)\n');

      _displayAllScores();
      
      print('');
    }
  }

  void _displayAllScores() {
    print('--- All Player Scores ---');
    
    if (quiz.submissions.isEmpty) {
      print('No scores yet.');
      return;
    }

    for (var submission in quiz.submissions) {
      int earnedPoints = submission.getScore(quiz.questions);
      int totalPoints = quiz.getTotalPossiblePoints();
      int percentage = submission.getScoreInPercentage(quiz.questions);
      
      print('${submission.playerName}: $earnedPoints points / $totalPoints ($percentage% correct)');
    }
    print('');
  }
}