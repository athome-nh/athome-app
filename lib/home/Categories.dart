import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:athome/Config/property.dart';
import 'package:athome/Home/itemCategories.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          title: Text(
            "All Categories",
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
          bottom: TabBar(
            labelColor: mainColorGrey,
            labelStyle: TextStyle(
                fontSize: 14, fontFamily: mainFontMontserrat4, color: mainColorGrey),
            // Change the color of the selected tab indicator
            indicatorColor: mainColorRed,
            tabs: [
              Tab(
                text: 'Categories',
              ),
              Tab(text: 'Favorite'),
            ],
          ),

          // Change the color of the unselected tab labels
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: getWidth(context, 90),
                        height: getHeight(context, 5),
                        decoration: BoxDecoration(
                            color: Color(0xffF2F2F2),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(context, 4)),
                              child: Icon(
                                Ionicons.search_outline,
                                color: mainColorGrey.withOpacity(0.45),
                                size: 30,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: TextField(
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: mainColorGrey.withOpacity(0.45),
                                      fontFamily: mainFontMontserrat4),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Search",
                                      hintStyle: TextStyle(color: mainColorGrey.withOpacity(0.45))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 2),
                    ),
                    Container(
                      height: getHeight(context, 90),
                      width: getWidth(context, 95),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, // Number of columns
                        ),
                        itemCount: 40, // Number of items in the grid
                        itemBuilder: (BuildContext context, int index) {
                          // Build each grid item here
                          return Container(
                            child: Column(
                              children: <Widget>[
                               GestureDetector(
                                              onTap: () {
                                                        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => itemCategories()),
            );
                                              },
                                  child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          100), // Adjust the corner radius
                                    ),
                                    child: Container(
                                      width: getHeight(context, 8),
                                      height: getHeight(context, 8),
                                      decoration: BoxDecoration(
                                          color: Color(0xffF2F2F2),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/images/790.png",
                                          width: getHeight(context, 6),
                                          height: getHeight(context, 6),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Grocery",
                                  style: TextStyle(
                                      color: mainColorGrey,
                                      fontFamily: mainFontMontserrat4,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
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
                              padding:  EdgeInsets.symmetric(horizontal: getWidth(context, 2)),
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
                                              onTap: () {
                                           
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Container(
                                                    width: getHeight(context, 5),
                                                    height: getHeight(context, 5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      border: Border.all(
                                                          color: mainColorGrey
                                                              .withOpacity(0.5)),
                                                    ),
                                                    child: Icon(Icons.add,
                                                        color: mainColorGrey,
                                                        size: getHeight(
                                                            context, 3))),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            width: getHeight(context, 8),
                                            height: getHeight(context, 3),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                //  topLeft: Radius.circular(20.0),
                                                topRight: Radius.circular(20.0),
                                                // bottomLeft: Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(20.0),
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
            ],
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
      ),
    );
  }
}
