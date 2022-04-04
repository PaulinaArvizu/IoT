import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff4D8D6E),
        onPressed: () => _openDialog(context),
        tooltip: 'Increment',
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.10,
              child: Center(
                child: Text(
                  'My Tricks',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.07,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.68,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return _cardFormat(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _cardFormat(int index) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
    child: Card(
      child: ListTile(
        title: Text(
          "Truco $index",
          style: const TextStyle(color: Colors.black),
        ),
        trailing: const Icon(
          Icons.delete,
          color: Color(0xffF76363),
        ),
      ),
    ),
  );
}

void _openDialog(BuildContext context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('New Command'),
      content: const Text('AlertDialog description'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
