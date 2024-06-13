import 'package:course/model/task2.dart';

class CounterController {
  final Counter _counter = Counter(0);

  int get value {
    return _counter.value;
  }

  void increment() {
    _counter.value++;
  }
}
