import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:intl/intl.dart';

class Info extends StatelessWidget {
  const Info({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            newRow(
              "Last used:", "today",
              // DateFormat('yyyy-MMM-dd – kk:mm').format(DateTime.now()),
            ),
            const SizedBox(height: 10),
            newRow("Last trick:", "Sit"),
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
