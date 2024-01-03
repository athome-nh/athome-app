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
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Privacy Policy for Dlly Las Grocery App',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Your Privacy is Important to Us',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'At Dlly Las Grocery App, we respect your privacy and are committed to protecting your personal data. This privacy policy explains how we collect, use, and share your personal data when you use our grocery application.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Easy Access to Privacy Policy',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'You can easily access this privacy policy within the app and on the mobile application store. It\'s important that you read this policy carefully to understand how we handle your personal information.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Information We Collect',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'We collect the following personal information:',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(
                    '• Account Information: Name, phone number, delivery address, Age and Gender'),
                Text(
                    '• Order Information: Order history, items purchased, payment information'),
                Text('• Device Information: Device type, operating system'),
                SizedBox(height: 16.0),
                Text(
                  'How We Use Your Information',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'We use your personal information for the following purposes:',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text('• Processing and fulfilling your grocery orders'),
                Text('• Providing customer support'),
                Text('• Improving our app and services'),
                Text(
                    '• Sending you notifications about offers and order status'),
                SizedBox(height: 16.0),
                Text(
                  'Sharing Your Information',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Rest assured, your personal data will always be super secure. We do not share it with any third-party companies or services. Only our trusted delivery partners receive limited information for order fulfillment:',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(
                    'Delivery driver: They receive your name, phone number, and delivery address to ensure smooth delivery, and subtotal payment to understand the order value and confirm receipt.'),
                SizedBox(height: 16.0),
                Text(
                  'Your Privacy Choices',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'You have the following choices regarding your personal information:',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text('• Access and update your information'),
                Text(
                    '• Withdraw your consent to certain uses of your information'),
                Text(
                    '• Delete your information: you can easily delete all your personal information.'),
                SizedBox(height: 16.0),
                Text(
                  'Data Security',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'We prioritize the security of your information. We implement industry-standard security measures to protect against unauthorized access, alteration, disclosure, or destruction of your personal data.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text('• We do not sell any personal data.'),
                Text(
                    '• We only use location information with your consent and for the purpose of delivering your groceries.'),
                Text(
                    '• We only disclose personal data when necessary to provide the service or when required by applicable laws.'),
                SizedBox(height: 16.0),
                Text(
                  'Permissions',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                    '• Location permission: We request your location permission to provide features like store locator and delivery tracking. You can disable location permission in your device settings.'),
                Text(
                    '• Storage permission: We request your permission to access your device storage to upload your optional profile picture to your account.'),
                Text(
                    '• Notification permission: We request notification permission to send you order updates and delivery notifications. You can manage notification settings in your device settings.'),
                SizedBox(height: 16.0),
                Text(
                  'Effective Date',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text('This privacy policy is effective as of [3.jan.2024].'),
                SizedBox(height: 16.0),
                Text(
                  'Changes to Privacy Policy',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                    'We may update this privacy policy from time to time. If we make any material changes, we will notify you through the app.'),
                SizedBox(height: 16.0),
                Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                    'If you have any questions about this privacy policy, please contact us at [Info@Dllylas.com].'),
              ],
            ),
          ),
        ));
  }
}
