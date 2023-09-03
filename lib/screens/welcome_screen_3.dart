import 'package:flutter/material.dart';
import '../configuration.dart';
import 'login_screen.dart';

class WelcomeScreenThree extends StatefulWidget {
  const WelcomeScreenThree({super.key});

  @override
  State<WelcomeScreenThree> createState() => _WelcomeScreenThreeState();
}

class _WelcomeScreenThreeState extends State<WelcomeScreenThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColorWhite,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColorWhite,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: mainColorRed,
            )),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(
                bottom: getHeight(context, 3),
              ),
              width: getWidth(context, 100),
              height: getHeight(context, 100),
              child: Image.asset(
                mainImageLogo1,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: getHeight(context, 2),
              ),
              width: getWidth(context, 100),
              height: getHeight(context, 100),
              child: Image.asset(
                'assets/images/003_welcome_3.png',
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: getHeight(context, 2),
              ),
              width: getWidth(context, 100),
              height: getHeight(context, 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your Pocket's Friend",
                    style: TextStyle(
                      fontFamily: mainFontMontserrat6,
                      fontSize: getHeight(context, 3),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                      getHeight(context, 2),
                    ),
                    child: Text(
                      "Learn whatever you want, whenever or wherever you are.",
                      style: TextStyle(
                        fontFamily: mainFontMontserrat4,
                        fontSize: getHeight(context, 2),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: getHeight(context, 2),
                ),
                width: getWidth(context, 50),
                height: getHeight(context, 100),
                decoration: BoxDecoration(
                  color: mainColorRed,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    'Get Start',
                    style: TextStyle(
                      fontFamily: mainFontMontserrat6,
                      fontSize: 20,
                      color: mainColorWhite,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
