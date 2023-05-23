class QuizQuestion {
  final String text;
  final List<String> answers;

  const QuizQuestion(this.text, this.answers);

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(
        answers); //copies a list so that we can do shuffled version of that list
    shuffledList.shuffle(); //shuffle() change this list inplace.
    return shuffledList;
  }
}
