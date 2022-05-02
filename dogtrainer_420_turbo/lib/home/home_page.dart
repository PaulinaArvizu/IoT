import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogtrainer_420_turbo/mqtt/state/MQTTAppState.dart';
import 'package:dogtrainer_420_turbo/mqtt/MQTTManager.dart';
import 'dart:io' show Platform;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _host = "broker.mqttdashboard.com";
  final String _topic = "dogtrainer";
  TextEditingController _nameController = TextEditingController();
  bool _isButtonActive = false;

  MQTTAppState currentAppState;
  MQTTManager manager;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MQTTAppState>(context);
    // Keep a reference to the app state.
    currentAppState = appState;
    MQTTAppConnectionState state = currentAppState.getAppConnectionState;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List<String> trickList = ["Sit", "Lay down", "Stay"];

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(_prepareStateMessageFrom(
                  currentAppState.getAppConnectionState)),
              state == MQTTAppConnectionState.disconnected
                  ? IconButton(
                      icon: Icon(Icons.power_off),
                      onPressed: _configureAndConnect,
                    )
                  : state == MQTTAppConnectionState.connected
                      ? IconButton(
                          icon: Icon(Icons.power),
                          onPressed: _disconnect,
                        )
                      : Text(''),
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
            onPressed: () => _publishMessage("turn on"),
            child: Icon(Icons.camera_alt),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: "fab2",
            onPressed: state == MQTTAppConnectionState.connected
                ? () {
                    _publishMessage("release treat");
                    appState.updateDate();
                  }
                : null,
            child: Icon(Icons.favorite),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: "fab3",
            onPressed: () => _openNewCommandDialog(),
            child: Icon(Icons.add),
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                IconButton(
                  tooltip: "Record",
                  onPressed: () {},
                  icon: const Icon(Icons.mic),
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
              TextButton(
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

  // Utility functions
  void _configureAndConnect() {
    String osPrefix = "Flutter_iOS";
    if (Platform.isAndroid) {
      osPrefix = "Flutter_Android";
    }
    manager = MQTTManager(
        host: _host,
        topic: _topic,
        identifier: osPrefix,
        state: currentAppState);
    manager.initializeMQTTClient();
    manager.connect();
  }

  void _disconnect() {
    manager.disconnect();
  }

  String _prepareStateMessageFrom(MQTTAppConnectionState state) {
    switch (state) {
      case MQTTAppConnectionState.connected:
        return "Connected";
      case MQTTAppConnectionState.connecting:
        return "Connecting";
      case MQTTAppConnectionState.disconnected:
        return "Disconnected";
    }
    return "error";
  }

  void _publishMessage(String text) {
    manager.publish(text);
  }
}
