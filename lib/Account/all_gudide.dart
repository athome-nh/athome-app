import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage>
    with SingleTickerProviderStateMixin {
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
        title: Text("Guide".tr,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
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
  final List<FAQ> faqs = [
    FAQ(
        title: 'General',
        question: 'What is Flutter?',
        answer:
            'Flutter is an open-source UI software development kit created by Google.'),
    FAQ(
        title: 'General',
        question: 'What programming language does Flutter use?',
        answer: 'Flutter uses the Dart programming language.'),
    FAQ(
        title: 'General',
        question: 'Is Flutter free to use?',
        answer: 'Yes, Flutter is free and open-source.'),
    FAQ(
        title: 'Installation',
        question: 'How do I install Flutter?',
        answer:
            'You can install Flutter by following the instructions on the official website.'),
    FAQ(
        title: 'Installation',
        question: 'What are the system requirements for Flutter?',
        answer:
            'Refer to the official documentation for detailed requirements.'),
    FAQ(
        title: 'Development',
        question: 'Can I use Flutter with my existing project?',
        answer:
            'You can integrate Flutter into existing applications incrementally.'),
    FAQ(
        title: 'Development',
        question: 'What IDEs can I use with Flutter?',
        answer:
            'You can use Android Studio, IntelliJ IDEA, and Visual Studio Code with Flutter.'),
    FAQ(
        title: 'Performance',
        question: 'Does Flutter support hot reload?',
        answer: 'Yes, Flutter supports hot reload.'),
    FAQ(
        title: 'Performance',
        question: 'How does Flutter perform compared to native apps?',
        answer: 'Flutter provides high performance on both Android and iOS.'),
    FAQ(
        title: 'Features',
        question: 'Does Flutter have access to native device features?',
        answer:
            'Yes, Flutter provides plugins to access native device features.'),
    FAQ(
        title: 'Learning Resources',
        question: 'Where can I find Flutter tutorials?',
        answer:
            'There are many resources available, including the official documentation.'),
  ];

  late List<FAQ> filteredFaqs;
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
      filteredFaqs = faqs
          .where((faq) =>
              faq.question.toLowerCase().contains(query) ||
              faq.answer.toLowerCase().contains(query))
          .toList();
      _isTileExpanded = List<bool>.filled(filteredFaqs.length, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Ionicons.search_outline),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredFaqs.length,
            itemBuilder: (context, index) {
              bool showTitle = index == 0 ||
                  filteredFaqs[index].title != filteredFaqs[index - 1].title;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showTitle)
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(filteredFaqs[index].title,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ExpansionTile(
                    leading: Icon(Ionicons.shield_checkmark_outline),
                    title: Text(filteredFaqs[index].question,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(filteredFaqs[index].answer))
                    ],
                    onExpansionChanged: (expanded) =>
                        setState(() => _isTileExpanded[index] = expanded),
                  ),
                  if (!_isTileExpanded[index]) Divider(thickness: 1),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

class UpdatesPage extends StatelessWidget {
  final List<Update> updates = [
    Update(
        title: 'New Feature: Dark Mode',
        description:
            'We\'ve added a new dark mode to help reduce eye strain at night.',
        date: DateTime(2024, 5, 20)),
    Update(
        title: 'Improved Performance',
        description: 'App startup time is now 50% faster!',
        date: DateTime(2024, 4, 15)),
    Update(
        title: 'Bug Fixes',
        description:
            'Fixed various bugs reported by users to improve stability.',
        date: DateTime(2024, 3, 10)),
    Update(
        title: 'Enhanced Security',
        description:
            'Implemented new security protocols to keep your data safe.',
        date: DateTime(2024, 2, 5)),
    Update(
        title: 'User Interface Overhaul',
        description:
            'Revamped the UI for a more modern and intuitive experience.',
        date: DateTime(2024, 1, 25)),
    Update(
        title: 'New Language Support',
        description: 'Added support for Spanish and French languages.',
        date: DateTime(2023, 12, 20)),
    Update(
        title: 'Social Media Integration',
        description:
            'You can now link your social media accounts with the app.',
        date: DateTime(2023, 11, 15)),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: updates.length,
      itemBuilder: (context, index) => Card(
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(updates[index].title,
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              Text(updates[index].description,
                  style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 10.0),
              Text('Date: ${updates[index].date.toLocal()}'.split(' ')[0],
                  style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQ {
  final String title;
  final String question;
  final String answer;

  FAQ({required this.title, required this.question, required this.answer});
}

class Update {
  final String title;
  final String description;
  final DateTime date;

  Update({required this.title, required this.description, required this.date});
}
