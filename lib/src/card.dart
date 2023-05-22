class Card {
  final String question;
  final String answer;

  const Card(this.question, this.answer);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Card &&
        other.question == question &&
        other.answer == answer;
  }

  @override
  int get hashCode => question.hashCode ^ answer.hashCode;

  @override
  String toString() => 'Question(question: $question, answer: $answer)';
}
