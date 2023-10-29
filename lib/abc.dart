import 'dart:math';
import 'package:athome/Config/athome_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

 

class abc extends StatefulWidget {
  @override
  _abcState createState() => _abcState();
}

class _abcState extends State<abc> {


  
  final _random = Random();
  String _randomText = '';
  final RegExp regex = RegExp(r'^[a-zA-Z0-9!@#\$%^&*,.?":]{33}$'); // Define your regular expression pattern here

  String generateRandomText() { 

  String code_2;
 
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*(),.?":';
    final length = 33; // Adjust the length to match your regex pattern

    String randomText;
    do {
      randomText = String.fromCharCodes(Iterable.generate(
        length,
        (_) => characters.codeUnitAt(_random.nextInt(characters.length)),
      ));
    } while (!regex.hasMatch(randomText));

    return randomText;
  }

  void _generateRandomText() {
    setState(() {
      _randomText = generateRandomText();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Text Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Random Text (Matching Regex):',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              _randomText,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateRandomText,
              child: Text('Generate Random Text'),
            ),
          ],
        ),
      ),
    );
  }
}
