
import 'package:course/model/quiz.dart';

class QuizesViewmodel {
  List<Test> _list = [];

  List<Test> get list {
    return [..._list];
  }
}
