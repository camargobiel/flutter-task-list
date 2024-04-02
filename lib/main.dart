import 'package:flutter/material.dart';

void main() {
  runApp(const TaskList());
}

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: Column(
          children: [
            Text("batata"),
          ],
        ),
      ),
    );
  }
}
