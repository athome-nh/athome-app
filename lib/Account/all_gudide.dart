// Import necessary packages and libraries
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

// GuidePage is a StatefulWidget that manages the guide sections (FAQs and Updates)
class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> with SingleTickerProviderStateMixin {
  // Controller to manage tab selection
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize TabController with 2 tabs
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the TabController when the widget is disposed
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
            Tab(text: 'FAQs'.tr), // Tab for FAQs
            Tab(text: 'What\'s New'.tr), // Tab for Updates
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FAQScreen(), // Screen for FAQs
          UpdatesPage(), // Screen for Updates
        ],
      ),
    );
  }
}

// FAQScreen is a StatefulWidget that displays the frequently asked questions
class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  // List of FAQs to display
  final List<FAQ> faqs = [
    FAQ(
        title: 'Title_FAQ_1'.tr,
        question: 'Question_FAQ_1'.tr,
        answer: 'Answer_FAQ_1'.tr),
    FAQ(
        title: 'Title_FAQ_1'.tr,
        question: 'Question_FAQ_2'.tr,
        answer: 'Answer_FAQ_2'.tr),
    FAQ(
        title: 'Title_FAQ_1'.tr,
        question: 'Question_FAQ_3'.tr,
        answer: 'Answer_FAQ_3'.tr),
    FAQ(
        title: 'Title_FAQ_2'.tr,
        question: 'Question_FAQ_4'.tr,
        answer: 'Answer_FAQ_4'.tr),
    FAQ(
        title: 'Title_FAQ_2'.tr,
        question: 'Question_FAQ_5'.tr,
        answer: 'Answer_FAQ_5'.tr),
    FAQ(
        title: 'Title_FAQ_3'.tr,
        question: 'Question_FAQ_6'.tr,
        answer: 'Answer_FAQ_6'.tr),
    FAQ(
        title: 'Title_FAQ_3'.tr,
        question: 'Question_FAQ_7'.tr,
        answer: 'Answer_FAQ_7'.tr),
    FAQ(
        title: 'Title_FAQ_4'.tr,
        question: 'Question_FAQ_8'.tr,
        answer: 'Answer_FAQ_8'.tr),
    FAQ(
        title: 'Title_FAQ_4'.tr,
        question: 'Question_FAQ_9'.tr,
        answer: 'Answer_FAQ_9'.tr),
    FAQ(
        title: 'Title_FAQ_5'.tr,
        question: 'Question_FAQ_10'.tr,
        answer: 'Answer_FAQ_10'.tr),
    FAQ(
        title: 'Title_FAQ_6'.tr,
        question: 'Question_FAQ_11'.tr,
        answer: 'Answer_FAQ_11'.tr),
  ];

  // List of filtered FAQs based on search query
  late List<FAQ> filteredFaqs;
  // Controller for the search input
  TextEditingController searchController = TextEditingController();
  // List to track which FAQ tiles are expanded
  late List<bool> _isTileExpanded;

  @override
  void initState() {
    super.initState();
    // Initialize filtered FAQs with all FAQs
    filteredFaqs = faqs;
    // Add a listener to the search controller to filter FAQs
    searchController.addListener(filterFaqs);
    // Initialize list to track expansion state of each FAQ tile
    _isTileExpanded = List<bool>.filled(faqs.length, false);
  }

  // Function to filter FAQs based on the search query
  void filterFaqs() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredFaqs = faqs
          .where((faq) =>
              faq.question.toLowerCase().contains(query) ||
              faq.answer.toLowerCase().contains(query))
          .toList();
      // Update expansion state list based on filtered FAQs
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
              hintText: 'Search'.tr, // Placeholder text for search
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
              // Determine whether to show the FAQ section title
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
                    // Update the expanded state when the tile is expanded or collapsed
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
    // Dispose of the search controller when the widget is disposed
    searchController.dispose();
    super.dispose();
  }
}

// UpdatesPage is a StatelessWidget that displays a list of updates
class UpdatesPage extends StatelessWidget {
  // List of updates to display
  final List<Update> updates = [
    Update(
        title: 'Title_Update_1',
        description: 'Description_Update_1',
        date: DateTime(2024, 5, 20)),
    Update(
        title: 'Title_Update_2',
        description: 'Description_Update_2',
        date: DateTime(2024, 4, 15)),
    Update(
        title: 'Title_Update_3',
        description: 'Description_Update_3',
        date: DateTime(2024, 3, 10)),
    Update(
        title: 'Title_Update_4',
        description: 'Description_Update_4',
        date: DateTime(2024, 2, 5)),
    Update(
        title: 'Title_Update_5',
        description: 'Description_Update_5',
        date: DateTime(2024, 1, 25)),
    Update(
        title: 'Title_Update_6',
        description: 'Description_Update_6',
        date: DateTime(2023, 12, 20)),
    Update(
        title: 'Title_Update_7',
        description: 'Description_Update_7',
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
              Text(
                  'Date'.tr +
                      ': ' +
                      '${updates[index].date.toLocal()}'.split(' ')[0],
                  style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }
}

// FAQ model class to represent an individual FAQ
class FAQ {
  final String title;
  final String question;
  final String answer;

  FAQ({required this.title, required this.question, required this.answer});
}

// Update model class to represent an individual update
class Update {
  final String title;
  final String description;
  final DateTime date;

  Update({required this.title, required this.description, required this.date});
}