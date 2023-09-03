import 'package:flutter/material.dart';

import 'package:athome/configuration.dart';

class ItemDeatil extends StatefulWidget {
  const ItemDeatil({super.key});

  @override
  State<ItemDeatil> createState() => _ItemDeatilState();
}

class _ItemDeatilState extends State<ItemDeatil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColorWhite,
      appBar: AppBar(
        title: Text(
          "Single Oroduct",
          style: TextStyle(
              color: mainColorGrey, fontFamily: mainFontMontserrat4, fontSize: 24),
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
            )),

        // Change the color of the unselected tab labels
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Stack(
                  alignment: Alignment.topRight,
                children: [
                  Container(
                    width: getWidth(context, 90),
                    height: getHeight(context, 60),
                    decoration: BoxDecoration(
                        color: Color(0xffF2F2F2),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/408.png",
                          width: getHeight(context, 30),
                          height: getHeight(context, 30),
                        ),
                        Text(
                          "Melon Imported ",
                          style: TextStyle(
                              color: mainColorGrey,
                              fontFamily: mainFontMontserrat6,
                              fontSize: 24),
                        ),
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        Text(
                          "info:3Kg",
                          style: TextStyle(
                              color: mainColorGrey,
                              fontFamily: mainFontMontserrat4,
                              fontSize: 16),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(
                        //                  width: getWidth(context, 95),
                        //                 height: getHeight(context, 3),
                        //                 child: ListView.builder(
                        //                   scrollDirection: Axis.horizontal,
                        //                   itemCount: 15,
                        //                   itemBuilder: (BuildContext context, int index) {
                        //                     return Padding(
                        //                       padding: EdgeInsets.symmetric(
                        //   horizontal: getWidth(context, 2)),
                        //                       child: GestureDetector(
                        //                         onTap: () {},
                        //                         child: Container(
                        //   width: getHeight(context, 7),
                        //   height: getHeight(context, 2),
                        //   decoration: BoxDecoration(
                        //       color: mainColorRed,
                        //       borderRadius: BorderRadius.circular(15)),
                        //   child: Center(
                        //     child: Text(
                        //       "5Kg",
                        //       style: TextStyle(
                        //           color: mainColorWhite,
                        //           fontFamily: mainFontMontserrat6,
                        //           fontSize: 13),
                        //     ),
                        //   ),
                        //                         ),
                        //                       ),
                        //                     );
                        //                   },
                        //                 ),
                        //               ),
                        // ),
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        Container(
                          width: getWidth(context, 30),
                          height: getHeight(context, 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: mainColorWhite,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                      width: getHeight(context, 4),
                                      height: getHeight(context, 4),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(
                                              color:
                                                  mainColorGrey.withOpacity(0.5)),
                                          color: mainColorGrey),
                                      child: Icon(Icons.add,
                                          color: mainColorWhite,
                                          size: getHeight(context, 3))),
                                ),
                              ),
                              Text(
                                "1",
                                style: TextStyle(
                                    color: mainColorGrey,
                                    fontFamily: mainFontMontserrat4,
                                    fontSize: 18),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                      width: getHeight(context, 4),
                                      height: getHeight(context, 4),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(
                                              color:
                                                  mainColorGrey.withOpacity(0.5)),
                                          color: mainColorGrey),
                                      child: Icon(Icons.delete,
                                          color: mainColorWhite,
                                          size: getHeight(context, 3))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Place Order',
                            style: TextStyle(
                                color: mainColorGrey,
                                fontSize: 18,
                                fontFamily: mainFontMontserrat4),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffF2F2F2),
                            fixedSize:
                                Size(getWidth(context, 65), getHeight(context, 5)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(color: mainColorRed, width: 1.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Add To Cart',
                            style: TextStyle(
                                color: mainColorWhite,
                                fontSize: 18,
                                fontFamily: mainFontMontserrat4),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColorRed,
                            fixedSize:
                                Size(getWidth(context, 65), getHeight(context, 5)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(color: mainColorRed, width: 1.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                 GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding:  EdgeInsets.all(10.0),
                                    child: Icon(Icons.favorite,
                                        color: mainColorGrey,
                                        size: getWidth(context, 15)),
                                  ),
                                ),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(context, 3),
            ),
            Container(
              width: getWidth(context, 90),
              height: getHeight(context, 25),
              decoration: BoxDecoration(
                  color: Color(0xffF2F2F2),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: getWidth(context, 7)),
                child: Padding(
                  padding: const EdgeInsets.only(top:15.0),
                  child: Text(
                    "Welcome to athome online market application! We're here to provide you with a convenient and efficient way to shop for your groceries and have them delivered right to your doorstep. Our platform is designed to enhance your shopping experience and make grocery shopping hassle-free. Here's a brief overview of what our application offers:",
                    style: TextStyle(
                       height: 1.5,
                        color: mainColorGrey,
                        fontFamily: mainFontMontserrat4,
                        fontSize: 14),
                        textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
