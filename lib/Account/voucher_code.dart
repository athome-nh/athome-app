import 'package:dllylas/Config/property.dart';
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
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.confirmation_num_outlined),
          title: Text('Active Title  ${index + 1}'),
          subtitle: Text('Details or Subtitle ${index + 1}'),
        );
      },
    );
  }
}


class UsedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, 
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.confirmation_num_outlined),
          title: Text('Used Title ${index + 1}'),
          subtitle: Text('Details or Subtitle ${index + 1}'),
        );
      },
    );
  }
}

class ExpiredTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.confirmation_num_outlined),
          title: Text('Expired Title ${index + 1}'),
          subtitle: Text('Details or Subtitle ${index + 1}'),
        );
      },
    );
  }
}