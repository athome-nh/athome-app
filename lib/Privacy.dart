import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Privacy Policy'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privacy Policy for Dlly Las Grocery App',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Effective Date: 24/12/2023',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '1. Introduction\n'
                  'Welcome to Dlly Las, your trusted grocery app! This Privacy Policy is designed to help you understand '
                  'how we collect, use, and safeguard your personal information when you use our mobile application. '
                  'By downloading, installing, or using the Dlly Las app, you agree to the practices described in this Privacy Policy.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '2. Information We Collect\n'
                  'To provide you with the best grocery shopping experience, we collect the following information when '
                  'you create an account:\n'
                  'Name: To personalize your experience and address you appropriately.\n'
                  'City: To assist with delivery location selection.\n'
                  'Age and Gender: To better understand our user demographics and tailor our services accordingly.\n'
                  'The type of your cell phone: for solving all the errors that we face them from all devices',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '3. Permissions\n'
                  'Location: We request access to your device\'s location to help you select the delivery location accurately '
                  'and provide you with the most efficient delivery service.\n'
                  'Storage: We seek permission to access your device\'s storage for uploading and storing your profile '
                  'image, enhancing your personalized experience.\n'
                  'Notification: We request permission to send you notifications related to order updates, promotions, and '
                  'important information.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '4. Use of Information\n'
                  'We use the collected information to:\n'
                  '• Create and manage your account.\n'
                  '• Facilitate order processing and delivery.\n'
                  '• Personalize your experience.\n'
                  '• Send relevant notifications and updates.\n'
                  '• Improve our services and address user preferences.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '5. Order Cancellation\n'
                  'Users have the right to cancel their orders before the order picker begins the picking process. Once the '
                  'order is being picked, cancellation may not be possible. Users can initiate the cancellation process '
                  'through the app.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '6. Data Security\n'
                  'We prioritize the security of your information. We implement industry-standard security measures to '
                  'protect against unauthorized access, alteration, disclosure, or destruction of your personal data.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '7. Third-Party Services\n'
                  'We may engage third-party services for analytics, payment processing, and delivery. These entities are '
                  'obligated to protect your information and adhere to applicable data protection laws.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '8. Changes to Privacy Policy\n'
                  'We reserve the right to update our Privacy Policy to reflect changes in our practices. Users will be '
                  'notified of any significant changes. It is advisable to review the Privacy Policy periodically.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '9. Contact Us\n'
                  'If you have any questions, concerns, or feedback regarding our Privacy Policy, please contact us at '
                  '[info@dllylas.com].\n'
                  'Thank you for choosing Dlly Las for your grocery needs!',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
