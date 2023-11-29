import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Config/property.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About Us".tr,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: getHeight(context, 5),
                ),
                child: Image.asset(
                  'assets/images/Logo-Type-2.png',
                  width: getWidth(context, 80),
                ),
              ),
              SizedBox(
                height: getHeight(context, 5),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 6)),
                child: Text(
                  "WelcomeToAthomeOnlineMarketApplication!".tr,
                  style: TextStyle(
                      // height: 1.5,
                      color: mainColorBlack,
                      fontFamily: mainFontnormal,
                      fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 6)),
                child: Text(
                  "WideSelectionOfProductsOurOnlineSupermarket".tr,
                  style: TextStyle(
                      // height: 1.5,
                      color: mainColorBlack,
                      fontFamily: mainFontnormal,
                      fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 6)),
                child: Text(
                  "EasyToUseInterfaceOurUserFriendly".tr,
                  style: TextStyle(
                      // height: 1.5,
                      color: mainColorBlack,
                      fontFamily: mainFontnormal,
                      fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 6)),
                child: Text(
                  "SecurePaymentWePrioritizeTheSecurity".tr,
                  style: TextStyle(
                      // height: 1.5,
                      color: mainColorBlack,
                      fontFamily: mainFontnormal,
                      fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 6)),
                child: Text(
                  "PromotionsAndDealsKeep".tr,
                  style: TextStyle(
                      // height: 1.5,
                      color: mainColorBlack,
                      fontFamily: mainFontnormal,
                      fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 6)),
                child: Text(
                  "CustomerSupportIfYouHaveAnyQuestions".tr,
                  style: TextStyle(
                      // height: 1.5,
                      color: mainColorBlack,
                      fontFamily: mainFontnormal,
                      fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 6)),
                child: Text(
                  "FeedbackAndImprovementWeValueYourFeedback".tr,
                  style: TextStyle(
                      // height: 1.5,
                      color: mainColorBlack,
                      fontFamily: mainFontnormal,
                      fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 6)),
                child: Text(
                  "ThankYouForChoosingOurAthome".tr,
                  style: TextStyle(
                      // height: 1.5,
                      color: mainColorBlack,
                      fontFamily: mainFontnormal,
                      fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: getHeight(context, 5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
