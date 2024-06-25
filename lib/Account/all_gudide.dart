import 'package:dllylas/Config/property.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';



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
            Tab(text: 'FAQs'.tr),
            Tab(text: 'What\'s New'.tr),
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

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<Map<String, String>> faqs = [
    {
      'title': 'General',
      'question': 'What is Flutter?',
      'answer':
          'Flutter is an open-source UI software development kit created by Google. It is used to develop applications for Android, iOS, Linux, macOS, Windows, Google Fuchsia, and the web from a single codebase.'
    },
    {
      'title': 'General',
      'question': 'What programming language does Flutter use?',
      'answer':
          'Flutter uses the Dart programming language, also developed by Google.'
    },
    {
      'title': 'General',
      'question': 'Is Flutter free to use?',
      'answer':
          'Yes, Flutter is free and open-source. Flutter supports hot reload, which allows you to instantly see changes.'
    },
    {
      'title': 'Installation',
      'question': 'How do I install Flutter?',
      'answer':
          'You can install Flutter by following the installation instructions on the official Flutter website.'
    },
    {
      'title': 'Installation',
      'question': 'What are the system requirements for Flutter?',
      'answer':
          'The system requirements vary depending on your operating system. For detailed requirements, refer to the official documentation.'
    },
    {
      'title': 'Development',
      'question': 'Can I use Flutter with my existing project?',
      'answer':
          'Flutter is best suited for new projects. However, you can integrate Flutter into existing applications incrementally.'
    },
    {
      'title': 'Development',
      'question': 'What IDEs can I use with Flutter?',
      'answer':
          'You can use Android Studio, IntelliJ IDEA, and Visual Studio Code with Flutter. Flutter also has plugins for these IDEs to enhance development experience.'
    },
    {
      'title': 'Performance',
      'question': 'Does Flutter support hot reload?',
      'answer':
          'Yes, Flutter supports hot reload, which allows you to instantly see the results of your changes without restarting your app.'
    },
    {
      'title': 'Performance',
      'question': 'How does Flutter perform compared to native apps?',
      'answer':
          'Flutter is designed to provide high performance on both Android and iOS. Its engine is optimized for running complex UIs at 60 FPS and above.'
    },
    {
      'title': 'Features',
      'question': 'Does Flutter have access to native device features?',
      'answer':
          'Yes, Flutter provides a rich set of plugins to access native device features. You can also create your own plugins to access custom features.'
    },
    {
      'title': 'Learning Resources',
      'question': 'Where can I find Flutter tutorials?',
      'answer':
          'There are many resources available to learn Flutter, including the official Flutter documentation.'
    },
  ];

  late List<Map<String, String>> filteredFaqs;
  TextEditingController searchController = TextEditingController();
  late List<bool> _isTileExpanded;

  @override
  void initState() {
    super.initState();
    filteredFaqs = faqs;
    searchController.addListener(filterFaqs);
    _isTileExpanded = List<bool>.filled(faqs.length, false);
  }

  void filterFaqs() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredFaqs = faqs.where((faq) {
        return faq['question']!.toLowerCase().contains(query) ||
            faq['answer']!.toLowerCase().contains(query);
      }).toList();
      _isTileExpanded = List<bool>.filled(filteredFaqs.length, false);
    });
  }

  double getHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }

  double getWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: getHeight(context, 4)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: mainColorBlack.withOpacity(0.1)),
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontFamily: mainFontnormal,
                    color: mainColorBlack.withOpacity(0.8),
                    fontSize: 16,
                  ),
                  prefixIcon: Icon(
                    Ionicons.search_outline,
                    color: mainColorBlack,
                    size: 22,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(height: getHeight(context, 4)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
              child: ListView.builder(
                itemCount: filteredFaqs.length,
                itemBuilder: (context, index) {
                  bool showTitle = true;
                  if (index > 0 &&
                      filteredFaqs[index]['title'] ==
                          filteredFaqs[index - 1]['title']) {
                    showTitle = false;
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showTitle)
                        Text(
                          filteredFaqs[index]['title']!,
                          style: TextStyle(
                            color: mainColorGrey,
                            fontSize: 18,
                            fontFamily: mainFontbold,
                          ),
                        ),
                      ExpansionTile(
                        leading: Icon(
                          Ionicons.shield_checkmark_outline,
                          color: mainColorBlack,
                          size: 22,
                        ),
                        childrenPadding: EdgeInsets.symmetric(
                            vertical: getHeight(context, 2)),
                        backgroundColor: mainColorGrey.withOpacity(0.05),
                        title: Text(
                          filteredFaqs[index]['question']!,
                          style: TextStyle(
                            color: mainColorBlack,
                            fontSize: 14,
                            fontFamily: mainFontbold,
                          ),
                        ),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              filteredFaqs[index]['answer']!,
                              style: TextStyle(
                                color: mainColorBlack,
                                fontSize: 14,
                                fontFamily: mainFontnormal,
                              ),
                            ),
                          ),
                        ],
                        onExpansionChanged: (bool expanded) {
                          setState(() {
                            _isTileExpanded[index] = expanded;
                          });
                        },
                      ),
                      if (!_isTileExpanded[index])
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 4)),
                          child: const Divider(thickness: 1),
                        ),
                      SizedBox(height: getHeight(context, 2)),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}


class Update {
  final String title;
  final String description;
  final DateTime date;

  Update({required this.title, required this.description, required this.date});
}

List<Update> updates = [
  Update(
    title: "New Feature: Dark Mode",
    description: "We've added a new dark mode to help reduce eye strain at night.",
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
