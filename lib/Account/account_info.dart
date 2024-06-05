
import 'package:flutter/material.dart';

class LanguageSelector extends StatefulWidget {
  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Selector'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showLanguageSelectionDialog(context);
          },
          child: Text('Select Language'),
        ),
      ),
    );
  }

  void _showLanguageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile<String>(
                title: Text('English'),
                value: 'English',
                groupValue: selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value!;
                  });
                  // You can add your language change logic here
                },
              ),
              RadioListTile<String>(
                title: Text('Arabic'),
                value: 'Arabic',
                groupValue: selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value!;
                  });
                  // You can add your language change logic here
                },
              ),
              RadioListTile<String>(
                title: Text('Kurdish'),
                value: 'Kurdish',
                groupValue: selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value!;
                  });
                  // You can add your language change logic here
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Perform any action here, like updating the language
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  
  }
}
