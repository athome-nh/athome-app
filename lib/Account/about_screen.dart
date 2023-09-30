import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          "About Us",
          style: TextStyle(
              color: mainColorGrey,
              fontFamily: mainFontMontserrat4,
              fontSize: 20),
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
                child: CachedNetworkImage(
                  imageUrl: mainImageLogo1,
                  width: getWidth(context, 80),
                ),
              ),
              SizedBox(
                height: getHeight(context, 10),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 6)),
                child: Text(
                  "Welcome to athome online market application! We're here to provide you with a convenient and efficient way to shop for your groceries and have them delivered right to your doorstep. Our platform is designed to enhance your shopping experience and make grocery shopping hassle-free. Here's a brief overview of what our application offers:"
                      .tr,
                  style: TextStyle(
                      // height: 1.5,
                      color: mainColorGrey,
                      fontFamily: mainFontMontserrat4,
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
                  "Wide Selection of Products: Our online supermarket offers a vast range of products, from fresh produce to pantry essentials, household items, personal care products, and more. You can browse through various categories and find everything you need in one place."
                      .tr,
                  style: TextStyle(
                      // height: 1.5,
                      color: mainColorGrey,
                      fontFamily: mainFontMontserrat4,
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
                  "Easy-to-Use Interface: Our user-friendly interface is designed to make your shopping experience smooth and enjoyable. You can easily search for products, add them to your cart, and proceed to checkout with just a few clicks."
                      .tr,
                  style: TextStyle(
                      // height: 1.5,
                      color: mainColorGrey,
                      fontFamily: mainFontMontserrat4,
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
                  "Secure Payment: We prioritize the security of your payment information. Our application uses secure payment gateways to ensure that your transactions are protected."
                      .tr,
                  style: TextStyle(
                      // height: 1.5,
                      color: mainColorGrey,
                      fontFamily: mainFontMontserrat4,
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
                  "Promotions and Deals: Keep an eye out for special promotions, discounts, and deals available on our platform. We want to help you save while you shop."
                      .tr,
                  style: TextStyle(
                      // height: 1.5,
                      color: mainColorGrey,
                      fontFamily: mainFontMontserrat4,
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
                  "Customer Support: If you have any questions or need assistance, our dedicated customer support team is here to help. You can reach out to us through the application, and we'll promptly address your concerns."
                      .tr,
                  style: TextStyle(
                      // height: 1.5,
                      color: mainColorGrey,
                      fontFamily: mainFontMontserrat4,
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
                  "Feedback and Improvement: We value your feedback. Your suggestions help us enhance our application and services. We're always looking for ways to improve and provide you with the best possible experience."
                      .tr,
                  style: TextStyle(
                      // height: 1.5,
                      color: mainColorGrey,
                      fontFamily: mainFontMontserrat4,
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
                  "Thank you for choosing our athome for your grocery shopping needs. We look forward to serving you and making your shopping experience convenient, enjoyable, and stress-free. Happy shopping!"
                      .tr,
                  style: TextStyle(
                      // height: 1.5,
                      color: mainColorGrey,
                      fontFamily: mainFontMontserrat4,
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
