class Answer {
  final String id;
  final String questionId;
  final List<int>? selectedChoiceIndexes; // for choice questions
  final String? freeText; // for text questions
  final DateTime submittedAt;

  Answer({
    required this.id,
    required this.questionId,
    this.selectedChoiceIndexes,
    this.freeText,
    DateTime? submittedAt,
  }) : submittedAt = submittedAt ?? DateTime.now();

  bool isCorrect() {
    // needs Question context to compute; placeholder false
    throw StateError('Answer.isCorrect requires a Question context to evaluate.');
  }
}
