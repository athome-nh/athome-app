import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Vouchers'),
          bottom: TabBar(
            tabs: [
              Tab(text: "Active"),
              Tab(text: "Used"),
              Tab(text: "Expired"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ActiveTab(),
            UsedTab(),
            ExpiredTab(),
          ],
        ),
      ),
    );
  }
}

class ActiveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No Active Design'),
    );
  }
}

class UsedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No Used Design'),
    );
  }
}

class ExpiredTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No Expired Design'),
    );
  }
}