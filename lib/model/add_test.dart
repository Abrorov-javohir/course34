import 'package:course/model/quiz.dart';
// ignore: depend_on_referenced_packages

final List<Test> tests = [
  Test(
    id: 1,
    question: 'What is the capital of France?',
    options: ['Berlin', 'Madrid', 'Paris', 'Lisbon'],
    correctOptionIndex: 2,
  ),
  Test(
    id: 2,
    question: 'What is 2 + 2?',
    options: ['3', '4', '5', '6'],
    correctOptionIndex: 1,
  ),
    Test(
    id: 3,
    question: 'Who is the winner of the Champions League?',
    options: ['Real Madrid', 'Manchester City', 'Barcelona', 'Bayern Munich'],
    correctOptionIndex: 0,
  ),
];