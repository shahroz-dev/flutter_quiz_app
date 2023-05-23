import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/question_screen.dart';
import 'package:quiz_app/result_screen.dart';
import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  // Widget? activeScreen; //initially it is null
  // //the type of activeScreen variable is set as widget so that it can get any screen type

  // void switchScreen() {
  //   setState(() {
  //     activeScreen = const QuestionScreen();
  //   });
  // }

  // @override
  // void initState() {
  //   //initState() is a method of class State, which called only once and we use it for one-time initializations.
  //   //To initialize data that need to execute before build()
  //   //we passed active screen function as an argument so that it can be used change state and to call build method
  //   activeScreen = StartScreen(switchScreen);
  //   super.initState();
  // }

  /* 
  There are three extremely important (stateful) widget lifecycle methods you should be aware of:
  initState(): Executed by Flutter when the StatefulWidget's State object is initialized
  build(): Executed by Flutter when the Widget is built for the first time AND after setState() was called
  dispose(): Executed by Flutter right before the Widget will be deleted (e.g., because it was displayed conditionally)
  */

  //You can also avoid initState() method by doing initialization in the build() method using ternary expression.
  List<String> selectedAnswer = [];
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void restartQuiz() {
    setState(() {
      selectedAnswer = [];
      activeScreen = 'question-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswer.add(answer);

    if (selectedAnswer.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'question-screen') {
      screenWidget = QuestionScreen(onSelectAnswer: chooseAnswer);
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswer,
        restartQuiz: restartQuiz,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(183, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
