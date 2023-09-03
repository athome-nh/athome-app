import 'package:flutter/material.dart';

import 'package:athome/configuration.dart';
import 'package:athome/home/CheckOut.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColorWhite,
      appBar: AppBar(
        title: Text(
          "My Cart",
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.only(top: 8.0),
              child: Container(
                height: getHeight(context, 50),
                child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            width: getWidth(context, 90),
                            height: getHeight(context, 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: getHeight(context, 10),
                                    height: getHeight(context, 14),
                                    decoration: BoxDecoration(
                                        color: Color(0xffF2F2F2),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/images/408.png",
                                        width: getHeight(context, 13),
                                        height: getHeight(context, 13),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: getWidth(context, 40),
                                        child: Text(
                                          "Nutriholland number 3 ",
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: mainColorGrey,
                                              fontFamily: mainFontMontserrat6,
                                              fontSize: 13),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "200,000 IQD",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: mainColorGrey,
                                                fontFamily: mainFontMontserrat4,
                                                fontSize: 10),
                                          ),
                                          SizedBox(
                                            width: getWidth(context, 1),
                                          ),
                                          Text(
                                            "100,500 IQD",
                                            style: TextStyle(
                                                color: mainColorRed,
                                                fontFamily: mainFontMontserrat4,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "info:3Kg",
                                        style: TextStyle(
                                            color: mainColorGrey,
                                            fontFamily: mainFontMontserrat4,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: getWidth(context, 20),
                                    height: getHeight(context, 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: mainColorWhite,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Container(
                                                width: getWidth(context, 6),
                                                height: getHeight(context, 3),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: mainColorGrey
                                                            .withOpacity(0.5)),
                                                    color: mainColorGrey),
                                                child: Icon(Icons.add,
                                                    color: mainColorWhite,
                                                    size:
                                                        getHeight(context, 2))),
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
                                                width: getWidth(context, 6),
                                                height: getHeight(context, 3),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: mainColorGrey
                                                            .withOpacity(0.5)),
                                                    color: mainColorGrey),
                                                child: Icon(Icons.delete,
                                                    color: mainColorWhite,
                                                    size:
                                                        getHeight(context, 2))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                    child: TextField(
                      maxLines: 2,
                      cursorColor: mainColorRed,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            color: mainColorGrey,
                            fontFamily: mainFontMontserrat6,
                            fontSize: 14),
                        labelText: "Delivery Instrusctions",
                        hintText: 'Type Notes here',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: mainColorGrey,
                            strokeAlign: 2, // Change this to the color you want
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                mainColorGrey, // Change this to the color you want
                          ),
                        ),
                      ),
                    )),
                      SizedBox(height: getHeight(context, 1),),
                Padding(
                   padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                  child: Divider(color: mainColorGrey.withOpacity(0.2), thickness: 1),
                ),
                  SizedBox(height: getHeight(context, 1),),
                Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sub Total",
                        style: TextStyle(
                            color: mainColorGrey,
                            fontFamily: mainFontMontserrat4,
                            fontSize: 13),
                      ),
                      Text(
                        textAlign: TextAlign.end,
                        "20,000 IQD",
                        style: TextStyle(
                            color: mainColorGrey,
                            fontFamily: mainFontMontserrat6,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getHeight(context, 1),),
                  Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Cost",
                        style: TextStyle(
                            color: mainColorGrey,
                            fontFamily: mainFontMontserrat4,
                            fontSize: 13),
                      ),
                      Text(
                        textAlign: TextAlign.end,
                        "20,000 IQD",
                        style: TextStyle(
                            color: mainColorGrey,
                            fontFamily: mainFontMontserrat6,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                  SizedBox(height: getHeight(context, 1),),
                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                  child: Divider(color: mainColorGrey.withOpacity(0.2), thickness: 1),
                ),
                   SizedBox(height: getHeight(context, 1),),
                  Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                         textAlign: TextAlign.start,
                        "Total",
                        style: TextStyle(
                            color: mainColorGrey,
                            fontFamily: mainFontMontserrat4,
                            fontSize: 13),
                      ),
                      Text(
                        textAlign: TextAlign.end,
                        "60,000 IQD",
                        style: TextStyle(
                            color: mainColorGrey,
                            fontFamily: mainFontMontserrat6,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
           SizedBox(height: getHeight(context, 3),),
                 Padding(
                 padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                   child: TextButton(
                        onPressed: () {

                                                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckOut()),
                              );
                        },
                       
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                            color: mainColorWhite,
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColorRed,
                          fixedSize:
                              Size(getWidth(context, 85), getHeight(context, 6)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                 ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
