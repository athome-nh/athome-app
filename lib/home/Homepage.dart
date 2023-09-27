import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:athome/Config/Values.dart';
import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/local_data.dart';
import 'package:athome/Home/AllItem.dart';
import 'package:athome/Home/itemCategories.dart';

import 'package:athome/Switchscreen.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';

import 'package:athome/landing/login_page.dart';
import 'package:athome/main.dart';
import 'package:athome/model/cart.dart';
import 'package:athome/model/category_model/category_model.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:athome/model/sub_category/sub_category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:athome/Config/property.dart';

import 'package:athome/Home/Categories.dart';
import 'package:athome/Home/ItemDeatil.dart';
import 'package:athome/Home/Notfication.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

// ignore: camel_case_types
class Home_SC extends StatefulWidget {
  const Home_SC({super.key});

  @override
  State<Home_SC> createState() => _Home_SCState();
}

// ignore: camel_case_types
class _Home_SCState extends State<Home_SC> {
  var collectionData = {
    "items": [
      {
        "id": 1,
        "name": "Apples",
        "price": 2000,
        "bestsell": false,
        "highlight": true,
        "discount": false,
        "content": "600 ml",
        "description":
            "Example text A common form of Lorem ipsum reads: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequa.",
        "quantity": 5,
        "category": 1,
        "image_url":
            "https://www.pngall.com/wp-content/uploads/4/Grocery-PNG-Free-Download.png"
      },
      {
        "id": 2,
        "name": "Milk",
        "content": "700 ml",
        "description":
            "Example text A common form of Lorem ipsum reads: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequa.",
        "quantity": 2,
        "bestsell": false,
        "highlight": false,
        "discount": true,
        "price": 4000,
        "category": 2,
        "image_url":
            "https://www.pngall.com/wp-content/uploads/4/Grocery-Transparent-Free-PNG.png"
      },
      {
        "id": 3,
        "name": "Bread",
        "content": "600 ml",
        "description":
            "Example text A common form of Lorem ipsum reads: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequa.",
        "quantity": 1,
        "bestsell": false,
        "highlight": false,
        "discount": true,
        "price": 5000,
        "category": 3,
        "image_url":
            "https://freepngimg.com/thumb/grocery/53730-5-grain-hd-download-free-image-thumb.png"
      },
      {
        "id": 4,
        "name": "Eggs",
        "content": "600 ml",
        "description":
            "Example text A common form of Lorem ipsum reads: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequa.",
        "quantity": 1,
        "bestsell": false,
        "highlight": false,
        "discount": true,
        "price": 7000,
        "category": 2,
        "image_url":
            "https://freepngimg.com/thumb/grocery/54005-1-grocery-image-png-file-hd-thumb.png"
      },
      {
        "id": 6,
        "name": "Eggs",
        "content": "600 ml",
        "description":
            "Example text A common form of Lorem ipsum reads: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequa.",
        "quantity": 1,
        "bestsell": false,
        "highlight": true,
        "discount": false,
        "price": 7000,
        "category": 2,
        "image_url":
            "https://www.pngplay.com/wp-content/uploads/7/Grocery-Bag-PNG-Clipart-Background.png"
      },
      {
        "id": 7,
        "name": "Eggs",
        "content": "600 ml",
        "description":
            "Example text A common form of Lorem ipsum reads: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequa.",
        "quantity": 1,
        "bestsell": false,
        "highlight": true,
        "discount": false,
        "price": 7000,
        "category": 2,
        "image_url":
            "https://www.pngplay.com/wp-content/uploads/7/Grocery-Items-PNG-HD-Quality.png"
      },
      {
        "id": 8,
        "name": "Eggs",
        "content": "600 ml",
        "description":
            "Example text A common form of Lorem ipsum reads: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequa.",
        "quantity": 1,
        "bestsell": true,
        "highlight": true,
        "discount": false,
        "price": 7000,
        "category": 2,
        "image_url":
            "https://freepngimg.com/thumb/grocery/41637-4-groceries-free-hd-image-thumb.png"
      },
      {
        "id": 9,
        "name": "MIR",
        "content": "600 ml",
        "description":
            "Example text A common form of Lorem ipsum reads: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequa.",
        "quantity": 1,
        "bestsell": true,
        "highlight": true,
        "discount": false,
        "price": 7000,
        "category": 2,
        "image_url":
            "https://freepngimg.com/thumb/grocery/54005-1-grocery-image-png-file-hd-thumb.png"
      },
      {
        "id": 5,
        "name": "MIRO",
        "content": "600 ml",
        "description":
            "Example text A common form of Lorem ipsum reads: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequa.",
        "quantity": 2,
        "bestsell": true,
        "highlight": false,
        "discount": false,
        "price": 8000,
        "category": 5,
        "image_url":
            "https://freepngimg.com/thumb/grocery/41629-3-groceries-png-download-free-thumb.png"
      }
    ],
    "cate": [
      {
        "id": 1,
        "name": "Fruits",
        "image_url":
            "https://www.pngmart.com/files/7/Groceries-PNG-Transparent.png"
      },
      {
        "id": 2,
        "name": "Dairy",
        "image_url":
            "https://www.pngmart.com/files/7/Groceries-PNG-Transparent.png"
      },
      {
        "id": 3,
        "name": "Bakery",
        "image_url":
            "https://www.pngmart.com/files/7/Groceries-PNG-Transparent.png"
      },
      {
        "id": 5,
        "name": "Vegetables",
        "image_url":
            "https://www.pngmart.com/files/7/Groceries-PNG-Transparent.png"
      }
    ],
    "subCate": [
      {
        "id": 1,
        "idcate": 2,
        "name": "Fruits",
      },
      {
        "id": 4,
        "idcate": 2,
        "name": "Dairy",
      },
      {
        "id": 5,
        "idcate": 3,
        "name": "Bakery",
      },
      {
        "id": 4,
        "idcate": 5,
        "name": "Dairy1",
      },
      {
        "id": 6,
        "idcate": 5,
        "name": "Dairy2",
      },
      {
        "id": 6,
        "idcate": 3,
        "name": "Dairy3",
      },
      {
        "id": 8,
        "idcate": 2,
        "name": "Dairy4",
      },
      {
        "id": 9,
        "idcate": 3,
        "name": "Dairy5",
      },
      {
        "id": 8,
        "idcate": 2,
        "name": "Vegetables",
      }
    ]
  };

  // late List<ProductModel> products = [];
  loadPostData() async {
    final directory = await getTemporaryDirectory();
    String path = "${directory.path}/dict.json";
    File f = File(path);
    if (f.existsSync()) {
      final jsonData = f.readAsStringSync();
      var data = json.decode(decryptAES(jsonData));
      return data;
    } else {
      var d = [];
      return d;
    }
  }

  getPost() async {
    // final String jsonString =
    //     await rootBundle.loadString('assets/images/example2.json');
    var jsonString = json.encode(collectionData);
    
    final directory = await getTemporaryDirectory();
    String path = "${directory.path}/dict.json";

    // Future.delayed(Duration(seconds: 2), () async {
    computeInBackground(jsonString, path);
    // });
  }

  late Isolate isolate;
  Future computeInBackground(String jsonString, String path) async {
    final ReceivePort receivePort = ReceivePort();
    final isolate = await Isolate.spawn(isolateFunction, {
      'sendPort': receivePort.sendPort,
      'jsonString': jsonString,
      'path': path,
    });

    receivePort.listen((data) {
      isolate.kill();
      print(data);
      if (!go) {
        update(context, data);
      }
    });

    // Terminate the isolate when done.
  }

  static Future isolateFunction(Map<String, dynamic> message) async {
    final SendPort sendPort = message['sendPort'];
    final String jsonString = message['jsonString'];
    final String path = message['path'];
    var jsonList = json.decode(jsonString);
    File f = File(path);
    f.writeAsStringSync(encryptAES(jsonString),
        flush: true, mode: FileMode.write);

    sendPort.send(jsonList);
  }

  update(BuildContext context, var data) {
    final productrovider = Provider.of<productProvider>(context, listen: false);

    productrovider.setProducts(
        (data['items'] as List).map((x) => ProductModel.fromMap(x)).toList());
    productrovider.setCategorys(
        (data['cate'] as List).map((x) => CategoryModel.fromMap(x)).toList());
    productrovider.setsubCategorys(
        (data['subCate'] as List).map((x) => SubCategory.fromMap(x)).toList());
  }

  bool go = false;
  @override
  void initState() {
    if (loadData) {
      loadPostData().then((data) {
        loadData = false;
        update(context, data);
        getPost();
      });
    } else {
      getPost();
    }
    if (loadData) {}
    super.initState();
  }

  @override
  void dispose() {
    go = true;
    super.dispose();
  }

  bool scroll = false;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final productrovider = Provider.of<productProvider>(context, listen: true);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Color(0xffF2F2F2),
        //   centerTitle: false,
        //   automaticallyImplyLeading: false,
        //   elevation: 0.0,
        //   title: Text(
        //     "AtHome Market".toUpperCase(),
        //     style: TextStyle(
        //         color: mainColorRed,
        //         fontSize: 18,
        //         fontWeight: FontWeight.w500,
        //         fontFamily: mainFontMontserrat4),
        //   ),
        //   actions: [
        //     Row(
        //       children: [
        //         IconButton(
        //           icon: Icon(
        //             Icons.notifications_none_outlined,
        //             color: mainColorRed,
        //             size: 30,
        //           ), // Another icon at the end (trailing)
        //           onPressed: () {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => NotficationScreen()),
        //             );
        //           },
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        body: SafeArea(
          child: CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_none_outlined,
                    color: mainColorRed,
                    size: 30,
                  ), // Another icon at the end (trailing)
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotficationScreen()),
                    );
                  },
                ),
              ],

              backgroundColor: Color(0xffF2F2F2),
              expandedHeight:
                  getHeight(context, 30), // Height of the app bar when expanded
              floating: false, // The app bar won't disappear on scroll
              pinned: true, // The app bar remains pinned at the top
              flexibleSpace: FlexibleSpaceBar(
                background: Center(
                  child: Stack(
                    // alignment: Alignment.bottomRight,
                    children: [
                      Image.asset(
                        "assets/images/banner.jpg",
                        // placeholder: (context, url) =>
                        //     Image.asset("assets/images/002_logo_1.png"),
                        // errorWidget: (context, url, error) =>
                        //     Image.asset("assets/images/002_logo_1.png"),
                        width: getWidth(context, 100),
                        height: getHeight(context, 100),
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: EdgeInsets.all(getHeight(context, 2)),
                        child: Align(
                          alignment: lang == "en"
                              ? Alignment.bottomLeft
                              : Alignment.bottomRight,
                          child: Container(
                            width: getWidth(context, 25),
                            height: getHeight(context, 4),
                            decoration: BoxDecoration(
                                color: mainColorRed,
                                borderRadius: BorderRadius.circular(50)),
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Order now".tr,
                                  style: TextStyle(
                                      color: mainColorWhite, fontSize: 14),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Container(
                    //   width: getWidth(context, 100),
                    //   height: getHeight(context, 25),
                    //   decoration: const BoxDecoration(
                    //     color: Color(0xffF2F2F2),
                    //   ),
                    //   child: Center(
                    //     child: Stack(
                    //       // alignment: Alignment.bottomRight,
                    //       children: [
                    //         Image.asset(
                    //           "assets/images/banner.jpg",
                    //           // placeholder: (context, url) =>
                    //           //     Image.asset("assets/images/002_logo_1.png"),
                    //           // errorWidget: (context, url, error) =>
                    //           //     Image.asset("assets/images/002_logo_1.png"),
                    //           width: getWidth(context, 100),
                    //           height: getHeight(context, 100),
                    //           fit: BoxFit.fill,
                    //         ),
                    //         Padding(
                    //           padding: EdgeInsets.all(getHeight(context, 2)),
                    //           child: Align(
                    //             alignment: Alignment.bottomLeft,
                    //             child: Container(
                    //               width: getWidth(context, 25),
                    //               height: getHeight(context, 4),
                    //               decoration: BoxDecoration(
                    //                   color: mainColorRed,
                    //                   borderRadius: BorderRadius.circular(50)),
                    //               child: TextButton(
                    //                   onPressed: () {},
                    //                   child: Text(
                    //                     "Order now",
                    //                     style: TextStyle(
                    //                         color: mainColorWhite, fontSize: 14),
                    //                   )),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 2)),
                          child: Text(
                            "Categories".tr,
                            style: TextStyle(
                                color: mainColorGrey,
                                fontSize: 16,
                                fontFamily: mainFontMontserrat6),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 2)),
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Categories()),
                                  );
                                },
                                child: Text(
                                  "View All".tr,
                                  style: TextStyle(
                                      color: mainColorRed,
                                      fontSize: 14,
                                      fontFamily: mainFontMontserrat4),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: mainColorRed,
                                size: 13,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: getHeight(context, 13),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productrovider.categores.length,
                        itemBuilder: (BuildContext context, int index) {
                          final cateItem = productrovider.categores[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context, 2)),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              itemCategories()),
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
                                        child: CachedNetworkImage(
                                          imageUrl: cateItem.imageUrl!,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                  "assets/images/002_logo_1.png"),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  "assets/images/002_logo_1.png"),
                                          width: getHeight(context, 5),
                                          height: getHeight(context, 5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: getHeight(context, 1),
                                ),
                                Text(
                                  cateItem.name!,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 2)),
                          child: Text(
                            "Discount".tr,
                            style: TextStyle(
                                color: mainColorGrey,
                                fontSize: 16,
                                fontFamily: mainFontMontserrat6),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 2)),
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  productrovider.settype("discount");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AllItem()),
                                  );
                                },
                                child: Text(
                                  "View All".tr,
                                  style: TextStyle(
                                      color: mainColorRed,
                                      fontSize: 14,
                                      fontFamily: mainFontMontserrat4),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: mainColorRed,
                                size: 13,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: getHeight(context, 25),
                      //  decoration: BoxDecoration(border: Border.all()),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            productrovider.getProductsByDiscount().length,
                        itemBuilder: (BuildContext context, int index) {
                          final product =
                              productrovider.getProductsByDiscount()[index];
                          final isItemInCart =
                              cartProvider.itemExistsInCart(product);
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context, 2)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ItemDeatil()),
                                            );
                                          },
                                          child: Container(
                                            width: getWidth(context, 32),
                                            height: getHeight(context, 14),
                                            decoration: BoxDecoration(
                                                //  border: Border.all(color: mainColorRed),
                                                color: Color(0xffF2F2F2),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Center(
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    product.imageUrl.toString(),
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                        "assets/images/002_logo_1.png"),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        "assets/images/002_logo_1.png"),
                                                width: getHeight(context, 13),
                                                height: getHeight(context, 13),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (!isLogin) {
                                                confirmAlertlogin(
                                                    context,
                                                    "Login Please".tr,
                                                    "You need to login first".tr);
                                                return;
                                              }
                                              final cartItem = CartItem(
                                                  product: product.id!);
                                              cartProvider.addToCart(cartItem);
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Container(
                                                width: getWidth(context, 8),
                                                height: getHeight(context, 4),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    border: Border.all(
                                                        color: mainColorGrey
                                                            .withOpacity(0.5)),
                                                    color: mainColorGrey),
                                                child: isItemInCart
                                                    ? Center(
                                                        child: Text(
                                                          cartProvider
                                                              .calculateQuantityForProduct(
                                                                  int.parse(product
                                                                      .id
                                                                      .toString()))
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  mainColorWhite),
                                                        ),
                                                      )
                                                    : Icon(Icons.add,
                                                        color: mainColorWhite,
                                                        size: getHeight(
                                                            context, 3))),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        width: getHeight(context, 6),
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
                                                  fontFamily:
                                                      mainFontMontserrat4,
                                                  fontSize: 12),
                                            ),
                                            Icon(Icons.discount_rounded,
                                                color: mainColorWhite,
                                                size: 15),
                                          ],
                                        )),
                                  ],
                                ),
                                Container(
                                  //decoration: BoxDecoration(border: Border.all()),
                                  width: getWidth(context, 32),
                                  height: getHeight(context, 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name.toString(),
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: mainColorGrey,
                                            fontFamily: mainFontMontserrat6,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        product.content.toString(),
                                        maxLines: 1,
                                        style: TextStyle(
                                            color:
                                                mainColorGrey.withOpacity(0.5),
                                            fontFamily: mainFontMontserrat6,
                                            fontSize: 9),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "200,000 IQD",
                                        maxLines: 1,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: mainColorGrey,
                                            fontFamily: mainFontMontserrat4,
                                            fontSize: 11),
                                      ),
                                      Text(
                                        "100,500 IQD",
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: mainColorRed,
                                            fontFamily: mainFontMontserrat6,
                                            fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 2)),
                          child: Text(
                            "Highlight".tr,
                            style: TextStyle(
                                color: mainColorGrey,
                                fontSize: 16,
                                fontFamily: mainFontMontserrat6),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 2)),
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  productrovider.settype("Highlight");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AllItem()),
                                  );
                                },
                                child: Text(
                                  "View All".tr,
                                  style: TextStyle(
                                      color: mainColorRed,
                                      fontSize: 14,
                                      fontFamily: mainFontMontserrat4),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: mainColorRed,
                                size: 13,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: getHeight(context, 25),
                      //  decoration: BoxDecoration(border: Border.all()),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            productrovider.getProductsByHighlight().length,
                        itemBuilder: (BuildContext context, int index) {
                          final product =
                              productrovider.getProductsByHighlight()[index];
                          final isItemInCart =
                              cartProvider.itemExistsInCart(product);
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context, 2)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ItemDeatil()),
                                        );
                                      },
                                      child: Container(
                                        width: getWidth(context, 32),
                                        height: getHeight(context, 14),
                                        decoration: BoxDecoration(
                                            //  border: Border.all(color: mainColorRed),
                                            color: Color(0xffF2F2F2),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Center(
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                product.imageUrl.toString(),
                                            placeholder: (context, url) =>
                                                Image.asset(
                                                    "assets/images/002_logo_1.png"),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    "assets/images/002_logo_1.png"),
                                            width: getHeight(context, 13),
                                            height: getHeight(context, 13),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (!isLogin) {
                                            confirmAlertlogin(
                                                context,
                                                "Login Please".tr,
                                                "You need to login first".tr);
                                            return;
                                          }
                                          final cartItem =
                                              CartItem(product: product.id!);
                                          cartProvider.addToCart(cartItem);
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Container(
                                            width: getWidth(context, 8),
                                            height: getHeight(context, 4),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    color: mainColorGrey
                                                        .withOpacity(0.5)),
                                                color: mainColorGrey),
                                            child: isItemInCart
                                                ? Center(
                                                    child: Text(
                                                      cartProvider
                                                          .calculateQuantityForProduct(
                                                              int.parse(product
                                                                  .id
                                                                  .toString()))
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              mainColorWhite),
                                                    ),
                                                  )
                                                : Icon(Icons.add,
                                                    color: mainColorWhite,
                                                    size:
                                                        getHeight(context, 3))),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  //decoration: BoxDecoration(border: Border.all()),
                                  width: getWidth(context, 32),
                                  height: getHeight(context, 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name.toString(),
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: mainColorGrey,
                                            fontFamily: mainFontMontserrat6,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        product.content.toString(),
                                        maxLines: 1,
                                        style: TextStyle(
                                            color:
                                                mainColorGrey.withOpacity(0.5),
                                            fontFamily: mainFontMontserrat6,
                                            fontSize: 9),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "200,000 IQD",
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: mainColorGrey,
                                            fontFamily: mainFontMontserrat6,
                                            fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 2)),
                      child: Container(
                        width: getWidth(context, 100),
                        height: getHeight(context, 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: CarouselSlider(
                            items: [
                              ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://images.unsplash.com/photo-1563636619-e9143da7973b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fG1pbGt8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
                                  placeholder: (context, url) => Image.asset(
                                      "assets/images/002_logo_1.png"),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          "assets/images/002_logo_1.png"),
                                  width: getWidth(context, 100),
                                  height: getHeight(context, 20),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              CachedNetworkImage(
                                imageUrl:
                                    "https://images.unsplash.com/photo-1563636619-e9143da7973b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fG1pbGt8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
                                placeholder: (context, url) =>
                                    Image.asset("assets/images/002_logo_1.png"),
                                errorWidget: (context, url, error) =>
                                    Image.asset("assets/images/002_logo_1.png"),
                                width: getWidth(context, 100),
                                height: getHeight(context, 20),
                                fit: BoxFit.fill,
                              ),
                              CachedNetworkImage(
                                imageUrl:
                                    "https://images.unsplash.com/photo-1563636619-e9143da7973b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fG1pbGt8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
                                placeholder: (context, url) =>
                                    Image.asset("assets/images/002_logo_1.png"),
                                errorWidget: (context, url, error) =>
                                    Image.asset("assets/images/002_logo_1.png"),
                                width: getWidth(context, 100),
                                height: getHeight(context, 20),
                                fit: BoxFit.fill,
                              ),
                            ],
                            options: CarouselOptions(
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              viewportFraction: 1.0,
                              enlargeCenterPage: true,
                              autoPlayInterval: Duration(seconds: 5),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 3000),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 2)),
                          child: Text(
                            "Best Seller".tr,
                            style: TextStyle(
                                color: mainColorGrey,
                                fontSize: 16,
                                fontFamily: mainFontMontserrat6),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 2)),
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  productrovider.settype("best");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AllItem()),
                                  );
                                },
                                child: Text(
                                  "View All",
                                  style: TextStyle(
                                      color: mainColorRed,
                                      fontSize: 14,
                                      fontFamily: mainFontMontserrat4),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: mainColorRed,
                                size: 13,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: getHeight(context, 25),
                      //  decoration: BoxDecoration(border: Border.all()),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            productrovider.getProductsByBestsell().length,
                        itemBuilder: (BuildContext context, int index) {
                          final product =
                              productrovider.getProductsByBestsell()[index];
                          final isItemInCart =
                              cartProvider.itemExistsInCart(product);
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context, 2)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ItemDeatil()),
                                        );
                                      },
                                      child: Container(
                                        width: getWidth(context, 32),
                                        height: getHeight(context, 14),
                                        decoration: BoxDecoration(
                                            //  border: Border.all(color: mainColorRed),
                                            color: Color(0xffF2F2F2),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Center(
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                product.imageUrl.toString(),
                                            placeholder: (context, url) =>
                                                Image.asset(
                                                    "assets/images/002_logo_1.png"),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    "assets/images/002_logo_1.png"),
                                            width: getHeight(context, 13),
                                            height: getHeight(context, 13),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (!isLogin) {
                                            confirmAlertlogin(
                                                context,
                                                "Login Please",
                                                "You need to login first");
                                            return;
                                          }
                                          final cartItem =
                                              CartItem(product: product.id!);
                                          cartProvider.addToCart(cartItem);
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Container(
                                            width: getWidth(context, 8),
                                            height: getHeight(context, 4),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    color: mainColorGrey
                                                        .withOpacity(0.5)),
                                                color: mainColorGrey),
                                            child: isItemInCart
                                                ? Center(
                                                    child: Text(
                                                      cartProvider
                                                          .calculateQuantityForProduct(
                                                              int.parse(product
                                                                  .id
                                                                  .toString()))
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              mainColorWhite),
                                                    ),
                                                  )
                                                : Icon(Icons.add,
                                                    color: mainColorWhite,
                                                    size:
                                                        getHeight(context, 3))),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  //decoration: BoxDecoration(border: Border.all()),
                                  width: getWidth(context, 32),
                                  height: getHeight(context, 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name.toString(),
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: mainColorGrey,
                                            fontFamily: mainFontMontserrat6,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        product.content.toString(),
                                        maxLines: 1,
                                        style: TextStyle(
                                            color:
                                                mainColorGrey.withOpacity(0.5),
                                            fontFamily: mainFontMontserrat6,
                                            fontSize: 9),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "200,000 IQD",
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: mainColorGrey,
                                            fontFamily: mainFontMontserrat6,
                                            fontSize: 11),
                                      ),
                                    ],
                                  ),
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
            )
          ]),
        ),
      ),
    );
  }

  // confirm Alert
  Future<void> confirmAlertlogin(
      BuildContext context, String title, String content) {
    return QuickAlert.show(
      context: context,
      confirmBtnColor: mainColorRed,
      type: QuickAlertType.info,
      title: title,
      text: content,
      confirmBtnText: "Login",
      onConfirmBtnTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterWithPhoneNumber()),
        );
      },
    );
  }
}
