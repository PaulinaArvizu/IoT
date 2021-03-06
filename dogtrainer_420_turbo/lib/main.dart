import 'package:flutter/material.dart';
import 'package:dogtrainer_420_turbo/home/navigation.dart';
import 'package:dogtrainer_420_turbo/mqtt/state/MQTTAppState.dart';
import 'package:provider/provider.dart';

import 'theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DogTrainer 420 Turbo',
        theme: theme,
        home: ChangeNotifierProvider<MQTTAppState>(
          create: (_) => MQTTAppState(),
          child: Navigation(),
        ));
  }
}
