import 'package:course/controller/counter_controller.dart';
import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final counterController = CounterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Counter App"),
      ),
      body: Center(
        child: Text(
          counterController.value.toString(),
          style: const TextStyle(
            fontSize: 60,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterController.increment();
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
