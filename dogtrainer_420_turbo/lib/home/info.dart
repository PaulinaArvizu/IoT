import 'package:dogtrainer_420_turbo/mqtt/state/MQTTAppState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Info extends StatefulWidget {
  const Info({Key key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MQTTAppState>(context);
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Text(
              'Info',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: width * 0.07,
              ),
            ),
            const SizedBox(height: 30),
            newRow("Last used:", appState.getDate),
            // const SizedBox(height: 10),
            // newRow("Last trick:", "Sit"),
          ],
        ),
      ),
    );
  }

  Row newRow(String header, String content) {
    return Row(
      children: [
        const SizedBox(width: 20),
        Text(
          header,
          style: const TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          content,
          style: const TextStyle(
            fontFamily: 'Raleway',
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
