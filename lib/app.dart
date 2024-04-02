import 'package:flutter/material.dart';
import 'package:task_list/pages/new-task.dart';
import 'package:task_list/pages/register.dart';
import 'package:task_list/pages/tasks.dart';

import 'pages/login.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.deepPurple,
      ),
      routes: {
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
        "/tasks": (context) => const TasksPage(),
        "/new-task": (context) => const NewTaskPage(),
      },
      initialRoute: "/login",
    );
  }
}
