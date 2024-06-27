import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Update {
  final String title;
  final String description;
  final DateTime date;

  Update({required this.title, required this.description, required this.date});
}

List<Update> updates = [
  Update(
    title: "New Feature: Dark Mode",
    description:
        "We've added a new dark mode to help reduce eye strain at night.",
    date: DateTime(2024, 5, 20),
  ),
  Update(
    title: "Improved Performance",
    description: "App startup time is now 50% faster!",
    date: DateTime(2024, 4, 15),
  ),
  Update(
    title: "Bug Fixes",
    description: "Fixed various bugs reported by users to improve stability.",
    date: DateTime(2024, 3, 10),
  ),
  Update(
    title: "Enhanced Security",
    description: "Implemented new security protocols to keep your data safe.",
    date: DateTime(2024, 2, 5),
  ),
  Update(
    title: "User Interface Overhaul",
    description: "Revamped the UI for a more modern and intuitive experience.",
    date: DateTime(2024, 1, 25),
  ),
  Update(
    title: "New Language Support",
    description: "Added support for Spanish and French languages.",
    date: DateTime(2023, 12, 20),
  ),
  Update(
    title: "Social Media Integration",
    description: "You can now link your social media accounts with the app.",
    date: DateTime(2023, 11, 15),
  ),
];

class UpdatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: updates.length,
        itemBuilder: (context, index) {
          return UpdateCard(update: updates[index]);
        },
      ),
    );
  }
}

class UpdateCard extends StatelessWidget {
  final Update update;

  UpdateCard({required this.update});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              update.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              update.description,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              // 'Date: ${update.date.toLocal()}'.split(' ')[0],
              "Date: 2024 / 12 / 23",
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
