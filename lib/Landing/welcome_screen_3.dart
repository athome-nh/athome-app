import 'package:flutter/material.dart';
import '../Config/property.dart';

import 'package:cached_network_image/cached_network_image.dart';

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
              width: getWidth(context, 80),
              height: getHeight(context, 100),
              child: CachedNetworkImage(
                  imageUrl: mainImageLogo1, fit: BoxFit.fitWidth),
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
              child: CachedNetworkImage(
                imageUrl: 'assets/images/003_welcome_3.png',
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
                      fontFamily: spedaBold,
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
                        fontFamily: Speda,
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
              onTap: () {},
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
                      fontFamily: spedaBold,
                      fontSize: 16,
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
