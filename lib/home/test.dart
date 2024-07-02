import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    return Scaffold(
      body: Center(
        child: Container(
          width: 180,
          height: 225,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: mainColorWhite,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 50,
                  spreadRadius: 7,
                  offset: Offset(0, 2))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: 180,
                decoration: BoxDecoration(
                  color: Color(0xFFfde8e3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: GestureDetector(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                              fit: BoxFit.contain,
                              dotenv.env['imageUrlServer']! +
                                  productrovider.products.first.coverImg!),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 0,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: mainColorRed,
                    //       borderRadius: BorderRadius.circular(16),
                    //     ),
                    //     child: Text("25%"),
                    //   ),
                    // ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: mainColorWhite),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite,
                                color: mainColorRed,
                              ))),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 1,
                      productrovider.products.first.nameEn!,
                      style: TextStyle(
                          fontSize: 12,
                          color: mainColorBlack,
                          fontFamily: mainFontbold),
                    ),
                    Text(
                      productrovider.products.first.contentsEn!,
                      style: TextStyle(
                          fontSize: 9,
                          color: mainColorBlack.withOpacity(0.5),
                          fontFamily: mainFontnormal),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          addCommasToPrice(
                              productrovider.products.first.price!),
                          style: TextStyle(
                              fontSize: 16,
                              color: mainColorBlack,
                              fontFamily: mainFontbold),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: mainColorGrey,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  topLeft: Radius.circular(15))),
                          child: Icon(
                            Icons.add,
                            color: mainColorWhite,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
