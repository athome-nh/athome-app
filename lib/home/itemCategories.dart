import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:athome/Config/property.dart';

class itemCategories extends StatefulWidget {
  const itemCategories({super.key});

  @override
  State<itemCategories> createState() => _itemCategoriesState();
}

class _itemCategoriesState extends State<itemCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColorWhite,
      appBar: AppBar(
        title: Text(
          "Baby",
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                 width: getWidth(context, 95),
                height: getHeight(context, 3),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 2)),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: getHeight(context, 9),
                          height: getHeight(context, 2),
                          decoration: BoxDecoration(
                              color: mainColorRed,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              "Grocery",
                              style: TextStyle(
                                  color: mainColorWhite,
                                  fontFamily: mainFontMontserrat6,
                                  fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: getHeight(context, 2),),
              Container(
                height: getHeight(context, 90),
                width: getWidth(context, 95),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: getWidth(context, 0.5),
                    mainAxisSpacing: getHeight(context, 2),
                    childAspectRatio: getHeight(context, 0.09),
                  ),

                  itemCount: 20, // Number of items in the grid
                  itemBuilder: (BuildContext context, int index) {
                    // Build each grid item here
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 2)),
                      child: Container(
                        // decoration: BoxDecoration(border: Border.all()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      width: getHeight(context, 20),
                                      height: getHeight(context, 20),
                                      decoration: BoxDecoration(
                                          color: Color(0xffF2F2F2),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/images/408.png",
                                          width: getHeight(context, 18),
                                          height: getHeight(context, 18),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                            width: getHeight(context, 5),
                                            height: getHeight(context, 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                  color: mainColorGrey
                                                      .withOpacity(0.5)),
                                            ),
                                            child: Icon(Icons.add,
                                                color: mainColorGrey,
                                                size: getHeight(context, 3))),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                    width: getHeight(context, 8),
                                    height: getHeight(context, 3),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        //  topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                        // bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(20.0),
                                      ),
                                      color: mainColorRed,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "30\%",
                                          style: TextStyle(
                                              color: mainColorWhite,
                                              fontFamily: mainFontMontserrat4,
                                              fontSize: 12),
                                        ),
                                        Icon(Icons.discount_rounded,
                                            color: mainColorWhite, size: 15),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: getHeight(context, 1),
                            ),
                            Container(
                              width: getHeight(context, 20),
                              child: Text(
                                "Nutriholland number 3 ",
                                maxLines: 2,
                                style: TextStyle(
                                    color: mainColorGrey,
                                    fontFamily: mainFontMontserrat6,
                                    fontSize: 14),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                width: getHeight(context, 19),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "200,000 IQD",
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: mainColorGrey,
                                          fontFamily: mainFontMontserrat4,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      "100,500 IQD",
                                      style: TextStyle(
                                          color: mainColorRed,
                                          fontFamily: mainFontMontserrat4,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
       floatingActionButton: Visibility(
        
          visible: true,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), 
          ),
          onPressed: () {
           
          },
          child: Icon(Ionicons.cart_sharp,size: getHeight(context, 5),), 
          backgroundColor: mainColorRed,
              ),
              
        ),
    );
  }
}
