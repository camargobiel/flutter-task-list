import 'package:flutter/material.dart';
import 'package:task_list/app.dart';
import 'package:firebase_core/firebase_core.dart';

const firebaseConfig = FirebaseOptions(
  apiKey: "AIzaSyABTV1wAA-SghD-Fi448KKJ5Hc9rWjrTtA",
  authDomain: "task-app-flutter-b4c3c.firebaseapp.com",
  databaseURL: "https://task-app-flutter-b4c3c-default-rtdb.firebaseio.com",
  projectId: "task-app-flutter-b4c3c",
  storageBucket: "task-app-flutter-b4c3c.appspot.com",
  messagingSenderId: "690450558486",
  appId: "1:690450558486:web:a744f30e7f77a644fc4f37",
  measurementId: "G-WCFCPE1L54",
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);
  runApp(const App());
}
