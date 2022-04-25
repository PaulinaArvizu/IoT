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
    /*
    final MQTTManager manager = MQTTManager(host:'test.mosquitto.org',topic:'flutter/amp/cool',identifier:'ios');
    manager.initializeMQTTClient();

     */
    return MaterialApp(
        title: 'DogTrainer 420 Turbo',
        theme: theme,
        home: ChangeNotifierProvider<MQTTAppState>(
          builder: (_) => MQTTAppState(),
          child: Navigation(),
        ));
  }
}
