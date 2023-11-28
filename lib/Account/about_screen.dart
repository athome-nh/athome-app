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
          style: TextStyle(
            fontFamily: mainFontnormal,
            color: mainColorGrey,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: mainColorWhite,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: mainColorRed,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: getHeight(context, 10),
                ),
                child: Image.asset(
                  'assets/images/002_logo_1.png',
                  width: getWidth(context, 60),
                  height: getHeight(context, 20),
                ),
              ),
              SizedBox(
                height: getHeight(context, 10),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 6)),
                child: Text(
                  "WelcomeToAthomeOnlineMarketApplication!".tr,
                  style: TextStyle(
                      // height: 1.5,
                      color: mainColorGrey,
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
                      color: mainColorGrey,
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
                      color: mainColorGrey,
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
                      color: mainColorGrey,
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
                      color: mainColorGrey,
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
                      color: mainColorGrey,
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
                      color: mainColorGrey,
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
                      color: mainColorGrey,
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