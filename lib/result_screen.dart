import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/question_summary.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  final List<String> chosenAnswers;
  final void Function() restartQuiz;

  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.restartQuiz,
  });

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i]
      });
    }
    return summary;
  }

  //Object are flexible type that can hold any value

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestion = questions.length;
    final numCorrectQuestion = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You Answered $numCorrectQuestion out of $numTotalQuestion questions correctly!',
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 253, 237, 254),
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              QuestionSummary(summaryData: getSummaryData()),
              const SizedBox(
                height: 30,
              ),
              TextButton.icon(
                onPressed: restartQuiz,
                icon: const Icon(Icons.refresh_outlined),
                label: Text(
                  'Restart Quiz!',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                style: TextButton.styleFrom(
                  iconColor: Colors.white,
                ),
              )
            ],
          ),
        ));
  }
}
