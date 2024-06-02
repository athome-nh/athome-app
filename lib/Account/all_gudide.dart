import 'package:dllylas/Account/faq_page.dart';
import 'package:dllylas/Account/new_update.dart';
import 'package:dllylas/Config/property.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class GudidePage extends StatefulWidget {
  @override
  _GudidePageState createState() => _GudidePageState();
}

class _GudidePageState extends State<GudidePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Guide".tr,
          style: TextStyle(
              color: mainColorBlack, fontSize: 16, fontFamily: mainFontbold),
        ),

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),

        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'FAQs'),
            Tab(text: 'What\'s New'),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          FAQScreen(),
          UpdatesPage(),
        ],
      ),
      
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Page'),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings Page'),
    );
  }
}
