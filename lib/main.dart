import 'package:Hodomojo/HomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hodomojo Demo',
      home: mainScreen(),
    );
  }

  // This class defines the AppBar, which stays constant
  // throughout the app. It also initializes the first screen
  // named 'HomeScreen'.
  Scaffold mainScreen()
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent[100],
        title: Center(
          child: Text(
            'HODOMOJO',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.teal[900],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: HomeScreen(),
      ),
    );
  }
}

