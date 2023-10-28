import 'package:athome/Config/my_widget.dart';
import 'package:athome/Network/Network.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/landing/splash_screen.dart';
import 'package:athome/model/location/location.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:athome/Config/property.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Config/athome_functions.dart';
import '../main.dart';
import 'nav_switch.dart';
import 'track_order.dart';

// ignore: must_be_immutable
class CheckOut extends StatefulWidget {
  int id = 0;
  CheckOut({super.key, required this.id});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController NoteController = TextEditingController();
  bool waitingcheckout = false;
  @override
  Widget build(BuildContext context) {
    String orderCode = "";

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final productrovider = Provider.of<productProvider>(context, listen: false);
    Locationuser location = productrovider.getonelocationById(widget.id);
    List<ProductModel> CardItemshow =
        productrovider.getProductsByIds(cartProvider.ListId());
    final total = cartProvider.calculateTotalPrice(CardItemshow);

    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          title: Text(
            "Checkout",
            style: TextStyle(
                color: mainColorGrey, fontFamily: mainFontnormal, fontSize: 24),
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: getWidth(context, 100),
                    height: getHeight(context, 13),
                    decoration: BoxDecoration(
                      color: mainColorWhite,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: getWidth(context, 4),
                          right: getWidth(context, 4),
                          top: getWidth(context, 1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delivery Address".tr,
                            style: TextStyle(
                                color: mainColorGrey,
                                fontFamily: mainFontnormal,
                                fontSize: 13),
                          ),
                          SizedBox(
                            height: getHeight(context, 1.5),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    textAlign: TextAlign.end,
                                    "${location.type!} Number ${location.number}",
                                    style: TextStyle(
                                        color: mainColorGrey,
                                        fontFamily: mainFontbold,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    textAlign: TextAlign.end,
                                    location.area!,
                                    style: TextStyle(
                                        color: mainColorGrey,
                                        fontFamily: mainFontbold,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              // TextButton(
                              //   onPressed: () {},
                              //   child: Text(
                              //     "Change".tr,
                              //     style: TextStyle(
                              //         color: mainColorRed,
                              //         fontFamily: mainFontbold,
                              //         fontSize: 14),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context, 2),
                    child: Container(
                      color: const Color(0xffF2F2F2),
                    ),
                  ),
                  Container(
                    width: getWidth(context, 100),
                    height: getHeight(context, 30),
                    decoration: BoxDecoration(
                      color: mainColorWhite,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: getWidth(context, 4),
                          right: getWidth(context, 4),
                          top: getHeight(context, 3)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pyment Method".tr,
                            style: TextStyle(
                                color: mainColorGrey,
                                fontFamily: mainFontnormal,
                                fontSize: 13),
                          ),
                          SizedBox(
                            height: getHeight(context, 2),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: getHeight(context, 5),
                              width: getWidth(context, 90),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffF2F2F2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Cash on delivery".tr,
                                      style: TextStyle(
                                          color: mainColorGrey,
                                          fontFamily: mainFontnormal,
                                          fontSize: 12),
                                    ),
                                    Icon(
                                      Icons.circle,
                                      color: mainColorRed,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(context, 2),
                          ),
                          GestureDetector(
                            onTap: () {
                              toastShort("Coming soon");
                            },
                            child: Container(
                              height: getHeight(context, 5),
                              width: getWidth(context, 90),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffF2F2F2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset("assets/images/fib.png"),
                                    Icon(
                                      Icons.circle_outlined,
                                      color: mainColorRed,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getHeight(context, 2),
                          ),
                          GestureDetector(
                            onTap: () {
                              toastShort("Coming soon");
                            },
                            child: Container(
                              height: getHeight(context, 5),
                              width: getWidth(context, 90),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffF2F2F2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset("assets/images/fast.png"),
                                    Icon(
                                      Icons.circle_outlined,
                                      color: mainColorRed,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(context, 2),
                    child: Container(
                      color: const Color(0xffF2F2F2),
                    ),
                  ),
                  Container(
                    width: getWidth(context, 100),
                    height: getHeight(context, 20),
                    decoration: BoxDecoration(
                      color: mainColorWhite,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: getWidth(context, 4),
                          right: getWidth(context, 4),
                          top: getHeight(context, 4)),
                      child: Column(
                        children: [
// Todo: (jegr) / aw textfielda pash nosini text w done dagrtn la keyboard textaka nayetaa now textfieldaka
                          TextFormField(
                            maxLines: 4,
                            controller: NoteController,
                            cursorColor: mainColorGrey,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {},
                            validator: (value) {
                              return null;
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color:
                                      mainColorGrey, // Customize border color
                                  width: 1.0, // Customize border width
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: mainColorGrey.withOpacity(
                                      0.5), // Customize border color
                                  width: 1.0, // Customize border width
                                ),
                              ),
                              labelText: "Note",
                              labelStyle: TextStyle(
                                  color: mainColorGrey.withOpacity(0.8),
                                  fontSize: 24,
                                  fontFamily: mainFontbold),
                              hintText: "Add your note",

                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: getWidth(context, 100),
                    height: getHeight(context, 24),
                    decoration: BoxDecoration(
                      color: mainColorGrey,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: getWidth(context, 4),
                          right: getWidth(context, 4),
                          top: getHeight(context, 3)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context, 4)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  textAlign: TextAlign.start,
                                  "Total",
                                  style: TextStyle(
                                      color: mainColorWhite,
                                      fontFamily: mainFontbold,
                                      fontSize: 22),
                                ),
                                Text(
                                  textAlign: TextAlign.end,
                                  addCommasToPrice(total),
                                  style: TextStyle(
                                      color: mainColorRed,
                                      fontFamily: mainFontbold,
                                      fontSize: 22),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context, 4)),
                            child: Divider(
                                color: mainColorWhite.withOpacity(0.7),
                                thickness: 3),
                          ),
                          SizedBox(
                            height: getHeight(context, 4),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context, 4)),
                            child: TextButton(
                              onPressed: waitingcheckout
                                  ? null
                                  : () {
                                      setState(() {
                                        waitingcheckout = true;
                                      });

                                      // productrovider.notifyListeners();
                                      String data = "";
                                      for (var element in cartProvider.cartItems) {
                                        ProductModel Item = productrovider
                                            .getoneProductById(element.product);
                                        String price = Item.price2! > -1
                                            ? Item.price2!.toString()
                                            : Item.price.toString();
                                        data += "!&${Item.id},,,${Item.purchasePrice},,,$price,,,${Item.offerPrice},,,${element.quantity}";
                                      }

                                      var data2 = {
                                        "customerid": userdata["id"],
                                        "total": total,
                                        "location": location.id!,
                                        "order_data": data.substring(2),
                                        "note": NoteController.text,
                                      };
                                      Network(false)
                                          .postData("order", data2, context)
                                          .then((value) {
                                        if (value != "") {
                                          if (value["code"] == "201") {
                                            setState(() {
                                              waitingcheckout = false;
                                            });

                                            getOnlineTimestamp().then((hour) {
                                              if (hour > 7 && hour < 23) {
                                                showModalBottomSheet(
                                                  context: context,
                                                  isDismissible: false,
                                                  enableDrag: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                      height: getHeight(
                                                          context, 90),
                                                      color: mainColorWhite,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    getWidth(
                                                                        context,
                                                                        4)),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons
                                                                  .shopping_cart_outlined,
                                                              color:
                                                                  mainColorRed,
                                                              size: getHeight(
                                                                  context, 20),
                                                            ),
                                                            Text(
                                                                "Thank You!".tr,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 24,
                                                                  color:
                                                                      mainColorGrey,
                                                                  fontFamily:
                                                                      mainFontnormal,
                                                                )),
                                                            Text(
                                                                "for yor order"
                                                                    .tr,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color:
                                                                      mainColorGrey,
                                                                  fontFamily:
                                                                      mainFontnormal,
                                                                )),
                                                            SizedBox(
                                                              height: getHeight(
                                                                  context, 1),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "Order Number: "
                                                                      .tr,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color:
                                                                          mainColorRed,
                                                                      fontFamily:
                                                                          mainFontbold),
                                                                ),
                                                                Text(
                                                                  value["data"],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color:
                                                                          mainColorGrey,
                                                                      fontFamily:
                                                                          mainFontbold),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: getHeight(
                                                                  context, 1),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          getWidth(
                                                                              context,
                                                                              4)),
                                                              child: Text(
                                                                "Your Order is now being processed. We will let you know once the order is picked from the outlet. Check the status of your Order"
                                                                    .tr,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color:
                                                                      mainColorGrey,
                                                                  fontFamily:
                                                                      mainFontnormal,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: getHeight(
                                                                  context, 2),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                horizontal:
                                                                    getWidth(
                                                                        context,
                                                                        4),
                                                              ),
                                                              child: TextButton(
                                                                onPressed: () {
                                                                  cartProvider
                                                                      .clearCart();
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => TrackOrder(
                                                                            value["data"],
                                                                            value["id"].toString(),
                                                                            value["total"].toString(),
                                                                            value["time"].toString())),
                                                                  ).then(
                                                                      (value) {
                                                                    cartProvider
                                                                        .clearCart();
                                                                    Navigator
                                                                        .pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const NavSwitch()),
                                                                    );
                                                                  });
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      mainColorRed,
                                                                  fixedSize: Size(
                                                                      getWidth(
                                                                          context,
                                                                          85),
                                                                      getHeight(
                                                                          context,
                                                                          6)),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  "Track My Order"
                                                                      .tr,
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        mainColorWhite,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                cartProvider
                                                                    .clearCart();

                                                                Navigator
                                                                    .pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const NavSwitch()),
                                                                ); // Close the bottom sheet
                                                              },
                                                              child: Text(
                                                                "Back to Home"
                                                                    .tr,
                                                                style: TextStyle(
                                                                    color:
                                                                        mainColorGrey,
                                                                    fontFamily:
                                                                        mainFontnormal,
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) {
                                                  cartProvider.clearCart();
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const NavSwitch()),
                                                  );
                                                });
                                              } else {
                                                alert(context).then((value) {
                                                  cartProvider.clearCart();
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const NavSwitch()),
                                                  );
                                                });
                                              }
                                            });

                                          } else {
                                            setState(() {
                                              waitingcheckout = false;
                                            });
                                          }
                                        } else {
                                          setState(() {
                                            waitingcheckout = false;
                                          });
                                        }
                                      });
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColorRed,
                                fixedSize: Size(getWidth(context, 85),
                                    getHeight(context, 6)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Text(
                                "Send Order",
                                style: TextStyle(
                                  color: mainColorWhite,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              waitingcheckout ? WaitingWiget(context) : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Future<void> alert(
    BuildContext context,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context2, state) {
          return AlertDialog(
              backgroundColor: mainColorGrey,
              contentPadding: const EdgeInsets.all(0),
              content: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: ClipRect(
                  child: Container(
                    width: getWidth(context, 90),
                    height: getHeight(context, 30),
                    decoration: BoxDecoration(
                        color: mainColorGrey.withOpacity(0.1),
                        border: Border.all(
                            color: mainColorWhite.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.all(10),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: getHeight(context, 30),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(),
                            Text(
                              "sorry we do not have delivery at this time we send you this order tomorrow as soon as.and you can cancel the order till Accept by admin ",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: mainColorWhite.withOpacity(0.7),
                                fontFamily: mainFontnormal,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(),
                            const SizedBox(),
                            const SizedBox(),
                            const SizedBox(),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColorRed,
                                fixedSize: const Size(70, 35),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                "Ok".tr,
                                style: TextStyle(
                                    fontSize: 18, fontFamily: mainFontnormal),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ));
        });
      },
    );
  }
}
