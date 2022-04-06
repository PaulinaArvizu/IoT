import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _nameController = TextEditingController();
  bool _isButtonActive = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<String> trickList = ["Sit", "Lay down", "Stay"];

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: Center(
        child: SingleChildScrollView(
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
                  itemCount: trickList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _cardFormat(trickList[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "fab1",
            onPressed: () => {},
            child: const Icon(Icons.favorite), //Icon(Icons.cookie),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: "fab2",
            // backgroundColor: const Color(0xff4D8D6E),
            onPressed: () => _openNewCommandDialog(),
            child: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardFormat(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            color: const Color(0xffF76363),
            onPressed: () => _openDeleteDialog(title),
          ),
        ),
      ),
    );
  }

  _openNewCommandDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('New Command'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _isButtonActive = value.isNotEmpty;
                      // _isButtonActive = !_isButtonActive;
                    });
                  },
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  setState(() {
                    if (_isButtonActive) Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  _openDeleteDialog(String trick) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Delete "$trick?"'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: const Text('Delete'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}
