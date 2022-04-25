import 'package:flutter/material.dart';
import 'package:dogtrainer_420_turbo/home/home_page.dart';
import 'package:provider/provider.dart';
import 'package:dogtrainer_420_turbo/mqtt/state/MQTTAppState.dart';
import 'package:dogtrainer_420_turbo/mqtt/MQTTManager.dart';
import 'dart:io' show Platform;

import 'info.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentPageIndex = 0;
  final _pagesList = [
    HomePage(),
    Info(),
  ];

  final String _host = "broker.mqttdashboard.com";
  final String _topic = "dogtrainer";
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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: height * 0.10,
        // backgroundColor: background,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              "https://air-marketing-assets.s3.amazonaws.com/blog/logo-db/dog-icon/dog-icon-png-1.png",
              height: width * 0.10,
            ),
            const SizedBox(width: 5),
            Text(
              "DogTrainer 420 Turbo",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: width * 0.06,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.power_settings_new,
              color: Colors.white,
            ),
            onPressed: state == MQTTAppConnectionState.disconnected
                ? _configureAndConnect
                : state == MQTTAppConnectionState.connected
                    ? _disconnect
                    : null, //
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pagesList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (int index) => setState(() => _currentPageIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Information',
          ),
        ],
      ),
    );
  }

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
}
