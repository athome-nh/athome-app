import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Home/AllItem.dart';
import 'package:athome/Home/itemCategories.dart';
import 'package:athome/Network/Network.dart';
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
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: camel_case_types
class Home_SC extends StatefulWidget {
  const Home_SC({super.key});

  @override
  State<Home_SC> createState() => _Home_SCState();
}

// ignore: camel_case_types
class _Home_SCState extends State<Home_SC> {
  var collectionData = {
    "category": [
      {
        "id": 1,
        "nameEN": "Kitchen",
        "nameAR": "مطبخ",
        "nameKU": "چێشتخانە",
        "img":
            "http://192.168.0.124/storage/Category/6XrNlx5weN07dtCtM5WVlWR45LwUy0bZAgrRy18P.png"
      },
      {
        "id": 2,
        "nameEN": "Dairy Product",
        "nameAR": "منتج البان",
        "nameKU": "بەرهەمی شیری",
        "img":
            "http://192.168.0.124/storage/Category/HPChItZ3kAOu77WmJpjlJVWW2NrgJxa07T1u00gu.png"
      },
      {
        "id": 3,
        "nameEN": "baby",
        "nameAR": "الأطفال",
        "nameKU": "منداڵان",
        "img":
            "http://192.168.0.124/storage/Category/DYHqMUVN77mv0fgzl1y2kQ8AX3PIKzEEWE122V1b.png"
      }
    ],
    "subCategory": [
      {"id": 1, "nameEN": "Rice", "nameAR": "ارز", "nameKU": "برنجەکان"},
      {"id": 2, "nameEN": "oil", "nameAR": "زیت", "nameKU": "زەیتەکان"},
      {"id": 3, "nameEN": "ghee", "nameAR": "دهن", "nameKU": "ڕۆنەکان"},
      {"id": 4, "nameEN": "Flour", "nameAR": "طحین", "nameKU": "ئاردەکان"},
      {
        "id": 5,
        "nameEN": "Tomato Paste",
        "nameAR": "معجون طماطة",
        "nameKU": "ئاوی تەماتەکان"
      },
      {"id": 6, "nameEN": "Burgul", "nameAR": "برغل", "nameKU": "ساوارەکان"},
      {
        "id": 7,
        "nameEN": "beans",
        "nameAR": "البقولیات",
        "nameKU": "پاقلەمەنیەکان"
      },
      {
        "id": 8,
        "nameEN": "Baby formula",
        "nameAR": "حلیب الأطفال",
        "nameKU": "شیری منداڵان"
      },
      {
        "id": 9,
        "nameEN": "Baby Diapers",
        "nameAR": "حفاضة الأطفال",
        "nameKU": "دایبی منداڵان"
      },
      {"id": 10, "nameEN": "Cerilac", "nameAR": "سریلاک", "nameKU": "سریلاک"},
      {
        "id": 11,
        "nameEN": "Milk Bottle",
        "nameAR": "زجاج حلیب",
        "nameKU": "شوشەی شیر"
      },
      {"id": 12, "nameEN": "Dogh", "nameAR": "عیران", "nameKU": "دۆ"},
      {"id": 13, "nameEN": "yogurt", "nameAR": "لبن", "nameKU": "ماست"},
      {"id": 14, "nameEN": "chesse", "nameAR": "جبنة", "nameKU": "پەنیر"},
      {"id": 15, "nameEN": "Milk", "nameAR": "حلیب", "nameKU": "شیر"}
    ],
    "products": [
      {
        "id": 1,
        "nameEN": "46t534`e",
        "nameAR": "wer",
        "nameKU": "frsrf",
        "contentsEN": "wer",
        "contentsAR": "999",
        "contentsKU": "wr",
        "descriptionEN": "wrw",
        "descriptionAR": "wrw",
        "descriptionKU": "wrw",
        "coverImg":
            "http://localhost/storage/Category/G5iNCWMy3CjkruFXx7SmTQR3hRhR0DtSDq46pDs2.png",
        "categoryId": 3,
        "SubCategoryId": 9,
        "purchase_price": 33,
        "price": 33,
        "price2": 0,
        "offer_price": 0,
        "order_limit": 33,
        "stock": 333,
        "highlight": 1,
        "bestSell": 0
      }
    ],
    "code": "200"
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
    // print(collectionData["subCategory"]);
    Network(false).getData("showData", context).then((value) async {
      if (value != "") {
        if (value["code"] != 200) {
          var jsonString = json.encode(value);

          final directory = await getTemporaryDirectory();
          String path = "${directory.path}/dict.json";

          computeInBackground(jsonString, path);
        } else {}
        // // Future.delayed(Duration(seconds: 2), () async {
        // });
      } else {}
    });
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

    productrovider.setProducts((data['products'] as List)
        .map((x) => ProductModel.fromMap(x))
        .toList());
    print(productrovider.products.length);
    productrovider.setCategorys((data['category'] as List)
        .map((x) => CategoryModel.fromMap(x))
        .toList());

    productrovider.setsubCategorys((data['subCategory'] as List)
        .map((x) => SubCategory.fromMap(x))
        .toList());
    setState(() {
      showitems = true;
    });
  }

  bool showitems = false;
  bool go = false;
  @override
  void initState() {
    if (loadData) {
      loadPostData().then((data) {
        loadData = false;

        if (data.toString() != "[]") {
          update(context, data);
        }

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
    showitems = productrovider.products.length > 0 ? true : false;
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
                    //   height: getHeight(context, 28),
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
                                  !showitems
                                      ? SizedBox()
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Categories()),
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
                      child: Visibility(
                        visible: showitems,
                        replacement: Skeletonizer(
                          enabled: true,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 2)),
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {},
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
                                              imageUrl: "cateItem",
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                      "assets/images/002_logo_1.png"),
                                              errorWidget: (context, url,
                                                      error) =>
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
                                      "cateItem",
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
                                      productrovider.setcatetype(cateItem.id!);
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
                                            imageUrl: cateItem.img!,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                                    "assets/images/002_logo_1.png"),
                                            errorWidget: (context, url,
                                                    error) =>
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
                                    lang == "en"
                                        ? cateItem.nameEn!
                                        : lang == "ar"
                                            ? cateItem.nameAr!
                                            : cateItem.nameKu!,
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
                                  if (showitems) {
                                    productrovider.settype("discount");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AllItem()),
                                    );
                                  }
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
                      height: getHeight(context, 28),
                      //  decoration: BoxDecoration(border: Border.all()),
                      child: Visibility(
                        visible: showitems,
                        replacement: Skeletonizer(
                          enabled: true,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 2)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: lang == "en"
                                          ? Alignment.bottomLeft
                                          : Alignment.bottomRight,
                                      children: [
                                        Stack(
                                          alignment: lang == "en"
                                              ? Alignment.topRight
                                              : Alignment.topLeft,
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
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl: "product",
                                                    placeholder: (context,
                                                            url) =>
                                                        Image.asset(
                                                            "assets/images/002_logo_1.png"),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            "assets/images/002_logo_1.png"),
                                                    width:
                                                        getHeight(context, 13),
                                                    height:
                                                        getHeight(context, 13),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Container(
                                                    width: getWidth(context, 8),
                                                    height:
                                                        getHeight(context, 4),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        border: Border.all(
                                                            color: mainColorGrey
                                                                .withOpacity(
                                                                    0.5)),
                                                        color: mainColorGrey),
                                                    child: false
                                                        ? Center(
                                                            child: Text(
                                                              "1",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color:
                                                                      mainColorWhite),
                                                            ),
                                                          )
                                                        : Icon(
                                                            Icons.add,
                                                            color:
                                                                mainColorWhite,
                                                            size: getHeight(
                                                                context, 1.5))),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            width: getHeight(context, 6),
                                            height: getHeight(context, 3),
                                            decoration: BoxDecoration(
                                              borderRadius: lang == "en"
                                                  ? BorderRadius.only(
                                                      //  topLeft: Radius.circular(20.0),
                                                      topRight:
                                                          Radius.circular(20.0),
                                                      // bottomLeft: Radius.circular(0.0),
                                                      bottomRight:
                                                          Radius.circular(20.0),
                                                    )
                                                  : BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20.0),
                                                      bottomLeft:
                                                          Radius.circular(20.0),
                                                    ),
                                              color: mainColorRed,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  calculatePercentageDiscount(
                                                      double.parse(
                                                          5.toString()),
                                                      double.parse(
                                                          6.toString())),
                                                  style: TextStyle(
                                                      color: mainColorWhite,
                                                      fontFamily:
                                                          mainFontMontserrat4,
                                                      fontSize: 12),
                                                ),
                                                Icon(Icons.discount_rounded,
                                                    color: mainColorWhite,
                                                    size: 12),
                                              ],
                                            )),
                                      ],
                                    ),
                                    Container(
                                      //decoration: BoxDecoration(border: Border.all()),
                                      width: getWidth(context, 32),
                                      height: getHeight(context, 13),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            lang == "en"
                                                ? "product"
                                                : lang == "ar"
                                                    ? "product"
                                                    : "product",
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
                                            lang == "en"
                                                ? "product"
                                                : lang == "ar"
                                                    ? "product"
                                                    : "product",
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: mainColorGrey
                                                    .withOpacity(0.5),
                                                fontFamily: mainFontMontserrat6,
                                                fontSize: 9),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            "product" + " IQD",
                                            maxLines: 1,
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: mainColorGrey,
                                                fontFamily: mainFontMontserrat4,
                                                fontSize: 11),
                                          ),
                                          Text(
                                            "product" + " IQD",
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
                                    alignment: lang == "en"
                                        ? Alignment.bottomLeft
                                        : Alignment.bottomRight,
                                    children: [
                                      Stack(
                                        alignment: lang == "en"
                                            ? Alignment.topRight
                                            : Alignment.topLeft,
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
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Center(
                                                child: CachedNetworkImage(
                                                  imageUrl: product.coverImg
                                                      .toString(),
                                                  placeholder: (context, url) =>
                                                      Image.asset(
                                                          "assets/images/002_logo_1.png"),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.asset(
                                                          "assets/images/002_logo_1.png"),
                                                  width: getHeight(context, 13),
                                                  height:
                                                      getHeight(context, 13),
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
                                                      "You need to login first"
                                                          .tr);
                                                  return;
                                                }
                                                final cartItem = CartItem(
                                                    product: product.id!);
                                                cartProvider
                                                    .addToCart(cartItem);
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Container(
                                                  width: getWidth(context, 8),
                                                  height: getHeight(context, 4),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      border: Border.all(
                                                          color: mainColorGrey
                                                              .withOpacity(
                                                                  0.5)),
                                                      color: mainColorGrey),
                                                  child: isItemInCart
                                                      ? Center(
                                                          child: Text(
                                                            cartProvider
                                                                .calculateQuantityForProduct(
                                                                    int.parse(
                                                                        product
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
                                            borderRadius: lang == "en"
                                                ? BorderRadius.only(
                                                    //  topLeft: Radius.circular(20.0),
                                                    topRight:
                                                        Radius.circular(20.0),
                                                    // bottomLeft: Radius.circular(0.0),
                                                    bottomRight:
                                                        Radius.circular(20.0),
                                                  )
                                                : BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.0),
                                                    bottomLeft:
                                                        Radius.circular(20.0),
                                                  ),
                                            color: mainColorRed,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                calculatePercentageDiscount(
                                                    double.parse(product.price!
                                                        .toString()),
                                                    double.parse(product
                                                        .offerPrice!
                                                        .toString())),
                                                style: TextStyle(
                                                    color: mainColorWhite,
                                                    fontFamily:
                                                        mainFontMontserrat4,
                                                    fontSize: 12),
                                              ),
                                              Icon(Icons.discount_rounded,
                                                  color: mainColorWhite,
                                                  size: 12),
                                            ],
                                          )),
                                    ],
                                  ),
                                  Container(
                                    //decoration: BoxDecoration(border: Border.all()),
                                    width: getWidth(context, 32),
                                    height: getHeight(context, 13),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang == "en"
                                              ? product.nameEn.toString()
                                              : lang == "ar"
                                                  ? product.nameAr.toString()
                                                  : product.nameKu.toString(),
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
                                          lang == "en"
                                              ? product.contentsEn.toString()
                                              : lang == "ar"
                                                  ? product.contentsAr
                                                      .toString()
                                                  : product.contentsKu
                                                      .toString(),
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: mainColorGrey
                                                  .withOpacity(0.5),
                                              fontFamily: mainFontMontserrat6,
                                              fontSize: 9),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          product.price!.toString() + " IQD",
                                          maxLines: 1,
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: mainColorGrey,
                                              fontFamily: mainFontMontserrat4,
                                              fontSize: 11),
                                        ),
                                        Text(
                                          product.offerPrice!.toString() +
                                              " IQD",
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
                                  if (showitems) {
                                    productrovider.settype("Highlight");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AllItem()),
                                    );
                                  }
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
                      height: getHeight(context, 28),
                      //  decoration: BoxDecoration(border: Border.all()),
                      child: Visibility(
                        visible: showitems,
                        replacement: Skeletonizer(
                          enabled: true,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 2)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: lang == "en"
                                          ? Alignment.bottomLeft
                                          : Alignment.bottomRight,
                                      children: [
                                        Stack(
                                          alignment: lang == "en"
                                              ? Alignment.topRight
                                              : Alignment.topLeft,
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                width: getWidth(context, 32),
                                                height: getHeight(context, 14),
                                                decoration: BoxDecoration(
                                                    //  border: Border.all(color: mainColorRed),
                                                    color: Color(0xffF2F2F2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl: "product",
                                                    placeholder: (context,
                                                            url) =>
                                                        Image.asset(
                                                            "assets/images/002_logo_1.png"),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            "assets/images/002_logo_1.png"),
                                                    width:
                                                        getHeight(context, 13),
                                                    height:
                                                        getHeight(context, 13),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Container(
                                                    width: getWidth(context, 8),
                                                    height:
                                                        getHeight(context, 4),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        border: Border.all(
                                                            color: mainColorGrey
                                                                .withOpacity(
                                                                    0.5)),
                                                        color: mainColorGrey),
                                                    child: false
                                                        ? Center(
                                                            child: Text(
                                                              "1",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color:
                                                                      mainColorWhite),
                                                            ),
                                                          )
                                                        : Icon(
                                                            Icons.add,
                                                            color:
                                                                mainColorWhite,
                                                            size: getHeight(
                                                                context, 1.5))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      //decoration: BoxDecoration(border: Border.all()),
                                      width: getWidth(context, 32),
                                      height: getHeight(context, 13),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            lang == "en"
                                                ? "product"
                                                : lang == "ar"
                                                    ? "product"
                                                    : "product",
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
                                            lang == "en"
                                                ? "product"
                                                : lang == "ar"
                                                    ? "product"
                                                    : "product",
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: mainColorGrey
                                                    .withOpacity(0.5),
                                                fontFamily: mainFontMontserrat6,
                                                fontSize: 9),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            "product" + " IQD",
                                            maxLines: 1,
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: mainColorGrey,
                                                fontFamily: mainFontMontserrat4,
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
                                    alignment: lang == "en"
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
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
                                                  product.coverImg.toString(),
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
                                    //decoration: BoxDecoration(border: Border.all()),
                                    width: getWidth(context, 32),
                                    height: getHeight(context, 13),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang == "en"
                                              ? product.nameEn.toString()
                                              : lang == "ar"
                                                  ? product.nameAr.toString()
                                                  : product.nameKu.toString(),
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
                                          lang == "en"
                                              ? product.contentsEn.toString()
                                              : lang == "ar"
                                                  ? product.contentsAr
                                                      .toString()
                                                  : product.contentsKu
                                                      .toString(),
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: mainColorGrey
                                                  .withOpacity(0.5),
                                              fontFamily: mainFontMontserrat6,
                                              fontSize: 9),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          product.price!.toString() + " IQD",
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
                                  if (showitems) {
                                    productrovider.settype("best");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AllItem()),
                                    );
                                  }
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
                      height: getHeight(context, 28),
                      //  decoration: BoxDecoration(border: Border.all()),
                      child: Visibility(
                        visible: showitems,
                        replacement: Skeletonizer(
                          enabled: true,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 2)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: lang == "en"
                                          ? Alignment.bottomLeft
                                          : Alignment.bottomRight,
                                      children: [
                                        Stack(
                                          alignment: lang == "en"
                                              ? Alignment.topRight
                                              : Alignment.topLeft,
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                width: getWidth(context, 32),
                                                height: getHeight(context, 14),
                                                decoration: BoxDecoration(
                                                    //  border: Border.all(color: mainColorRed),
                                                    color: Color(0xffF2F2F2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl: "product",
                                                    placeholder: (context,
                                                            url) =>
                                                        Image.asset(
                                                            "assets/images/002_logo_1.png"),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            "assets/images/002_logo_1.png"),
                                                    width:
                                                        getHeight(context, 13),
                                                    height:
                                                        getHeight(context, 13),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Container(
                                                    width: getWidth(context, 8),
                                                    height:
                                                        getHeight(context, 4),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        border: Border.all(
                                                            color: mainColorGrey
                                                                .withOpacity(
                                                                    0.5)),
                                                        color: mainColorGrey),
                                                    child: false
                                                        ? Center(
                                                            child: Text(
                                                              "1",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color:
                                                                      mainColorWhite),
                                                            ),
                                                          )
                                                        : Icon(
                                                            Icons.add,
                                                            color:
                                                                mainColorWhite,
                                                            size: getHeight(
                                                                context, 1.5))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      //decoration: BoxDecoration(border: Border.all()),
                                      width: getWidth(context, 32),
                                      height: getHeight(context, 13),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            lang == "en"
                                                ? "product"
                                                : lang == "ar"
                                                    ? "product"
                                                    : "product",
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
                                            lang == "en"
                                                ? "product"
                                                : lang == "ar"
                                                    ? "product"
                                                    : "product",
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: mainColorGrey
                                                    .withOpacity(0.5),
                                                fontFamily: mainFontMontserrat6,
                                                fontSize: 9),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            "product" + " IQD",
                                            maxLines: 1,
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: mainColorGrey,
                                                fontFamily: mainFontMontserrat4,
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
                                    alignment: lang == "en"
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
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
                                                  product.coverImg.toString(),
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
                                    //decoration: BoxDecoration(border: Border.all()),
                                    width: getWidth(context, 32),
                                    height: getHeight(context, 13),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang == "en"
                                              ? product.nameEn.toString()
                                              : lang == "ar"
                                                  ? product.nameAr.toString()
                                                  : product.nameKu.toString(),
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
                                          lang == "en"
                                              ? product.contentsEn.toString()
                                              : lang == "ar"
                                                  ? product.contentsAr
                                                      .toString()
                                                  : product.contentsKu
                                                      .toString(),
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: mainColorGrey
                                                  .withOpacity(0.5),
                                              fontFamily: mainFontMontserrat6,
                                              fontSize: 9),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          product.price!.toString() + " IQD",
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
