import 'answer.dart';

enum QuestionType { SINGLE_CHOICE, MULTI_CHOICE, TEXT }

class Question {
  final String id;
  String title;
  List<String> choices;
  List<int> goodChoiceIndexes; // indexes of correct choices
  QuestionType type;

  Question({
    required this.id,
    required this.title,
    this.choices = const [],
    this.goodChoiceIndexes = const [],
    this.type = QuestionType.SINGLE_CHOICE,
  });

  /// Return true if the provided Answer is correct
  bool isCorrect(Answer a) {
    if (type == QuestionType.TEXT) {
      if (a.freeText == null) return false;
      return a.freeText!.trim().toLowerCase() ==
          (goodChoiceIndexes.isNotEmpty ? choices[goodChoiceIndexes.first].trim().toLowerCase() : '');
    }

    // for choice-based answers compare selectedChoiceIndexes
    final selected = a.selectedChoiceIndexes ?? [];
    // compare as sets
    final correct = Set<int>.from(goodChoiceIndexes);
    final selSet = Set<int>.from(selected);
    return correct.length == selSet.length && correct.containsAll(selSet);
  }
}
