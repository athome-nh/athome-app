import 'package:flutter/material.dart';
import '../Config/property.dart';
import 'login_screen.dart';
import 'welcome_screen_1.dart';
import 'welcome_screen_3.dart';

class WelcomeScreenTwo extends StatefulWidget {
  const WelcomeScreenTwo({super.key});

  @override
  State<WelcomeScreenTwo> createState() => _WelcomeScreenTwoState();
}

class _WelcomeScreenTwoState extends State<WelcomeScreenTwo> {
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
              margin: EdgeInsets.only(bottom: getHeight(context, 3),),
              width: getWidth(context, 80),
              height: getHeight(context, 100),
              child: Image.asset(
              mainImageLogo1,
              fit:BoxFit.fitWidth

            ),
            ),
          ),


          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.symmetric(vertical:getHeight(context, 2),),
              width: getWidth(context, 100),
              height: getHeight(context, 100),
              child: Image.asset(
              'assets/images/003_welcome_2.png',
            ),
            ),
          ),


          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.symmetric(vertical:getHeight(context, 2),),
              width: getWidth(context, 100),
              height: getHeight(context, 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
              "Learn From the Best",
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
                "We will guide you with the best tutors and experts in Kurdistan/Iraq",
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
            child: Container(
              margin: EdgeInsets.symmetric(vertical:getHeight(context, 2),),
              width: getWidth(context, 100),
              height: getHeight(context, 100),
              child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context, 3),),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                      GestureDetector(
                         onTap: () {
                           Navigator.push(context,MaterialPageRoute( 
                             builder: (context) =>const PhoneScreen(),
                             ),
                             );
                               },
                    child: Container(
                        width: getWidth(context, 25),
                        height: getHeight(context, 5),
                        decoration: BoxDecoration(
                            color: mainColorLightGrey,
                            borderRadius: BorderRadius.circular(25),
                            ),
                        child: Center(
                          child: Text(
                                'SKIP',
                                style: TextStyle(
                                  fontFamily: mainFontMontserrat6,
                                  fontSize: 16,
                                  color: mainColorBlack,
                                ),
                              ),
                        ),
                      ),
                  ),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      // Circle One             
                      GestureDetector(
                         onTap: () {
                           Navigator.push(context,MaterialPageRoute( 
                             builder: (context) =>const WelcomeScreenOne(),
                             ),
                             );
                               },
                        child: Container(
                          width: getWidth(context, 3),
                          height: getHeight(context, 3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: mainColorBlack
                          ),
                          margin:EdgeInsets.symmetric(horizontal: getWidth(context, 1),),
                        ),
                      ),

                      // Circle two            
                      GestureDetector(
                         onTap: () {},
                        child: Container(
                          width: getWidth(context, 3),
                          height: getHeight(context, 3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: mainColorRed
                          ),
                          margin:EdgeInsets.symmetric(horizontal: getWidth(context, 1),),
                        ),
                      ),

                      // Circle Three             
                      GestureDetector(
                         onTap: () {
                           Navigator.push(context,MaterialPageRoute( 
                             builder: (context) =>const WelcomeScreenThree(),
                             ),
                             );
                               },
                        child: Container(
                          width: getWidth(context, 3),
                          height: getHeight(context, 3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: mainColorBlack
                          ),
                          margin:EdgeInsets.symmetric(horizontal: getWidth(context, 1),),
                        ),
                      ),
            
                    ],
                  ),
                  
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute( 
                    builder: (context) =>const WelcomeScreenThree(),
                    ),
                    );
                      
                    },
                    child: Container(
                      width: getWidth(context, 25),
                      height: getHeight(context, 5),
                      decoration: BoxDecoration(
                          color: mainColorRed,
                          borderRadius: BorderRadius.circular(25),
                          ),
                      child: Center(
                        child: Text(
                              'NEXT',
                              style: TextStyle(
                                fontFamily: mainFontMontserrat6,
                                fontSize: 16,
                                color: mainColorWhite,
                              ),
                            ),
                      ),
                    ),
                  ),
            
                  
                ],
              ),
            ),
            ),
          ),
        ],
      ),
    );
  }
}
