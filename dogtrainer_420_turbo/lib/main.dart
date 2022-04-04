import 'package:dogtrainer_420_turbo/home/navigation.dart';
import 'package:dogtrainer_420_turbo/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DogTrainer 420 Turbo',
      theme: theme,
      home: const Navigation(),
    );
  }
}
