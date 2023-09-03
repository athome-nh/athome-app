import 'package:flutter/material.dart';

import '../configuration.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColorWhite,
      appBar: AppBar(
        title: Text(
          "My Order",
          style: TextStyle(
              color: mainColorGrey, fontFamily: mainFontMontserrat1, fontSize: 20),
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
      body: Center(
        child: ListView.builder( itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return 
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrderScreen()),
                      );
                    },
                    child: Container(
                      width: getWidth(context, 90),
                      height: getHeight(context, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),),
                      child: Card(
                        elevation: 5,
                         color: mainColorWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                             ),
                             
                        child: ListTile(
                          trailing: Icon(Icons.arrow_forward_ios,color: mainColorRed,),
                          leading: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              width: getWidth(context, 13),
                              height: getHeight(context, 18),
                              decoration: BoxDecoration(
                                color: mainColorLightGrey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Icon(Icons.shopping_cart,color: mainColorRed,size: 30,)),
                          ),
                                    title:  Text(
                                        "Order ID : 123456789",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: mainFontMontserrat1,
                                            color: mainColorGrey),
                                      ), 
                                      subtitle:     Text(
                                    "Order ID : 123456789",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: mainFontMontserrat1,
                                        color: mainColorGrey),
                                  ),
                                  ),
                      ),
                    ),
                  ),
                );
        
                
                }),
      ),
    );
  }
}