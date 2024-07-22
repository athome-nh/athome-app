import 'package:animate_do/animate_do.dart';
import 'package:dllylas/home/DetailsPage.dart';
import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/all_item.dart';
import 'package:dllylas/landing/login_page.dart';
import 'package:dllylas/main.dart';
import 'package:dllylas/model/brandmodel/brandmodel.dart';
import 'package:dllylas/model/cart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget listItemsShimer(BuildContext context) {
  return SizedBox(
    height: getHeight(context, 20),
    // decoration: BoxDecoration(border: Border.all()),
    child: Skeletonizer(
      effect: ShimmerEffect.raw(colors: [
        mainColorGrey.withOpacity(0.1),
        mainColorWhite,
        // mainColorRed.withOpacity(0.1),
      ]),
      enabled: true,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: getWidth(context, 2),
          childAspectRatio: getWidth(context, 0.37),
        ),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          final randomColor = categoryColors[5];
          return Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: getWidth(context, 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: mainColorlightGrey,
                ),
                child: Padding(
                  padding: EdgeInsets.all(getWidth(context, 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Skeleton.keep(
                            child: Icon(
                          Icons.image_outlined,
                          color: mainColorGrey.withOpacity(0.2),
                          size: 100,
                        )),
                      ),
                      SizedBox(
                        height: getHeight(context, 1),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              addCommasToPrice(200),
                              maxLines: 1,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: mainColorBlack,
                                  fontFamily: mainFontbold,
                                  fontSize: 12),
                            ),
                            Text(
                              maxLines: 1,
                              "hello Baby",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: mainColorBlack,
                                  fontFamily: mainFontbold),
                            ),
                            Text(
                              maxLines: 1,
                              "500 ML",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: mainColorBlack.withOpacity(0.5),
                                  fontFamily: mainFontnormal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(0),
                  child: AnimatedContainer(
                    padding: EdgeInsets.all(4),
                    width: 30,
                    height: 30,
                    duration: Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                        color: mainColorGrey,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15))),
                    child: Skeleton.keep(
                      child: Icon(LineIcons.plus,
                          color: mainColorWhite, size: getHeight(context, 2.5)),
                    ),
                  ))
            ],
          );
        },
      ),
    ),
  );
}

Widget listItemsBigShimer(BuildContext context) {
  return Skeletonizer(
    effect: ShimmerEffect.raw(colors: [
      mainColorGrey.withOpacity(0.1),
      mainColorWhite,
      //mainColorRed.withOpacity(0.1),
    ]),
    enabled: true,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth(context, 2.5)),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          childAspectRatio: getWidth(context, 0.22),
        ),

        itemCount: 8, // Number of items in the grid
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  width: getWidth(context, 43),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: mainColorlightGrey,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(getWidth(context, 1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Skeleton.keep(
                              child: Icon(
                            Icons.image_outlined,
                            color: mainColorGrey.withOpacity(0.2),
                            size: 130,
                          )),
                        ),
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                addCommasToPrice(200),
                                maxLines: 1,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: mainColorBlack,
                                    fontFamily: mainFontbold,
                                    fontSize: 12),
                              ),
                              Text(
                                maxLines: 1,
                                "hello Baby",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: mainColorBlack,
                                    fontFamily: mainFontbold),
                              ),
                              Text(
                                maxLines: 1,
                                "500 ML",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: mainColorBlack.withOpacity(0.5),
                                    fontFamily: mainFontnormal),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(0),
                    child: AnimatedContainer(
                      padding: EdgeInsets.all(4),
                      width: 30,
                      height: 30,
                      duration: Duration(milliseconds: 400),
                      decoration: BoxDecoration(
                          color: mainColorGrey,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15))),
                      child: Skeleton.keep(
                        child: Icon(LineIcons.plus,
                            color: mainColorWhite,
                            size: getHeight(context, 2.5)),
                      ),
                    ))
              ],
            ),
          );
        },
      ),
    ),
  );
}

Widget listItemsSmall(BuildContext context, var data) {
  final productrovider = Provider.of<productProvider>(context, listen: true);
  final cartProvider = Provider.of<CartProvider>(context, listen: true);

  return SizedBox(
    height: getHeight(context, 20),

    //  decoration: BoxDecoration(border: Border.all()),
    child: Visibility(
      visible: productrovider.show,
      replacement: listItemsShimer(context),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: getWidth(context, 2),
          childAspectRatio: getWidth(context, 0.37),
        ),
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          final product = data[index];
          final isItemInCart = cartProvider.itemExistsInCart(product);
          int count = cartProvider
              .calculateQuantityForProduct(int.parse(product.id.toString()));

          return Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: getWidth(context, 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: mainColorlightGrey,
                ),
                child: Padding(
                  padding: EdgeInsets.all(getWidth(context, 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: isItemInCart
                              ? () {}
                              : () {
                                  productrovider.setidItem(product.id!);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                              color: 5,
                                            )),
                                  );
                                },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: dotenv.env['imageUrlServer']! +
                                  product.coverImg,
                              placeholder: (context, url) =>
                                  Image.asset("assets/images/Logo-Type-2.png"),
                              errorWidget: (context, url, error) =>
                                  Image.asset("assets/images/Logo-Type-2.png"),
                              width: getHeight(context, 10),
                              height: getHeight(context, 10),
                              filterQuality: FilterQuality.low,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 1),
                      ),
                      GestureDetector(
                        onTap: () {
                          productrovider.setidItem(product.id!);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                      color: 5,
                                    )),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              checkOferPrice(product)
                                  ? (product.price2! > -1
                                          ? product.price2!
                                          : product.price!)
                                      .toString()
                                  : addCommasToPrice(product.price2! > -1
                                      ? product.price2!
                                      : product.price!),
                              maxLines: 1,
                              style: TextStyle(
                                  decoration: checkOferPrice(product)
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: checkOferPrice(product)
                                      ? mainColorRed
                                      : mainColorBlack,
                                  fontFamily: checkOferPrice(product)
                                      ? mainFontnormal
                                      : mainFontbold,
                                  fontSize: checkOferPrice(product) ? 10 : 12),
                            ),
                            checkOferPrice(product)
                                ? Text(
                                    addCommasToPrice(product.offerPrice!),
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: green,
                                        fontFamily: mainFontbold,
                                        fontSize: 12),
                                  )
                                : const SizedBox(),
                            Text(
                              maxLines: 1,
                              lang == "en"
                                  ? product.nameEn.toString()
                                  : lang == "ar"
                                      ? product.nameAr.toString()
                                      : product.nameKu.toString(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: mainColorBlack,
                                  fontFamily: mainFontbold),
                            ),
                            Text(
                              maxLines: 1,
                              lang == "en"
                                  ? product.contentsEn.toString()
                                  : lang == "ar"
                                      ? product.contentsAr.toString()
                                      : product.contentsKu.toString(),
                              style: TextStyle(
                                  fontSize: 10,
                                  color: mainColorBlack.withOpacity(0.5),
                                  fontFamily: mainFontnormal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(0),
                  child: AnimatedContainer(
                    padding: EdgeInsets.all(4),
                    width: isItemInCart ? 110 : 30,
                    height: 30,
                    duration: Duration(milliseconds: 400),
                    decoration: isItemInCart
                        ? BoxDecoration(
                            color: mainColorGrey,
                            borderRadius: BorderRadius.all(Radius.circular(10)))
                        : BoxDecoration(
                            color: mainColorGrey,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15))),
                    child: isItemInCart
                        ? FlipInX(
                            delay: const Duration(milliseconds: 300),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    final cartItem =
                                        CartItem(product: product.id!);
                                    cartProvider.removeFromCart(cartItem);
                                  },
                                  child: Icon(Icons.remove,
                                      color: mainColorWhite,
                                      size: getHeight(context, 2.5)),
                                ),
                                Text(
                                  count.toString(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: mainColorWhite,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: checkProductStock(product, count) ||
                                          checkProductLimit(product, count)
                                      ? null
                                      : () {
                                          final cartItem =
                                              CartItem(product: product.id!);
                                          cartProvider.addToCart(cartItem);
                                        },
                                  child: Icon(LineIcons.plus,
                                      color: checkProductStock(
                                                  product, count) ||
                                              checkProductLimit(product, count)
                                          ? mainColorWhite.withOpacity(0.3)
                                          : mainColorWhite,
                                      size: getHeight(context, 2.5)),
                                ),
                              ],
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              if (!isLogin) {
                                loiginPopup(context);
                                return;
                              }
                              final cartItem = CartItem(product: product.id!);
                              cartProvider.addToCart(cartItem);
                            },
                            child: Icon(LineIcons.plus,
                                color: mainColorWhite,
                                size: getHeight(context, 2.5)),
                          ),
                  ))
            ],
          );
        },
      ),
    ),
  );
}

Widget listitemsBrands(BuildContext context, var data) {
  final productrovider = Provider.of<productProvider>(context, listen: true);

  return SizedBox(
      height: getHeight(context, 8),
      child: Visibility(
          visible: productrovider.show,
          replacement: listItemsShimer(context),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: getWidth(context, 2),
                childAspectRatio: getWidth(context, 0.26),
              ),
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final Brandmodel brand = data[index];

                return GestureDetector(
                  onTap: () {
                    productrovider.settype("brand");
                    productrovider.setidbrand(brand.id!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AllItem()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/testbrand.jpg",
                          fit: BoxFit.fill,
                        )

                        // CachedNetworkImage(
                        //   imageUrl: dotenv.env['imageUrlServer']! + brand.limg!,
                        //   placeholder: (context, url) =>
                        //       Image.asset("assets/images/Logo-Type-2.png"),
                        //   errorWidget: (context, url, error) =>
                        //       Image.asset("assets/images/Logo-Type-2.png"),
                        //   width: getHeight(context, 6),
                        //   height: getHeight(context, 6),
                        //   filterQuality: FilterQuality.low,
                        //  fit: BoxFit.fill,
                        // ),

                        ),
                  ),
                );
              })));
}

// all items
Widget listItemsShow(BuildContext context, var data) {
  final productrovider = Provider.of<productProvider>(context, listen: true);
  final cartProvider = Provider.of<CartProvider>(context, listen: true);
  return Visibility(
    visible: productrovider.show,
    replacement: listItemsBigShimer(context),
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        childAspectRatio: getWidth(context, 0.22),
      ),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        final product = data[index];
        final isItemInCart = cartProvider.itemExistsInCart(product);
        final isFavInCart = cartProvider.FavExistsInCart(product);
        int count = cartProvider
            .calculateQuantityForProduct(int.parse(product.id.toString()));
        return Center(
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: getWidth(context, 43),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: mainColorlightGrey,
                ),
                child: Padding(
                  padding: EdgeInsets.all(getWidth(context, 2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: isItemInCart
                              ? () {}
                              : () {
                                  productrovider.setidItem(product.id!);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                              color: 5,
                                            )),
                                  );
                                },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: dotenv.env['imageUrlServer']! +
                                  product.coverImg,
                              placeholder: (context, url) =>
                                  Image.asset("assets/images/Logo-Type-2.png"),
                              errorWidget: (context, url, error) =>
                                  Image.asset("assets/images/Logo-Type-2.png"),
                              width: getHeight(context, 15),
                              height: getHeight(context, 15),
                              filterQuality: FilterQuality.low,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(context, 1),
                      ),
                      GestureDetector(
                        onTap: () {
                          productrovider.setidItem(product.id!);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                      color: 5,
                                    )),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              checkOferPrice(product)
                                  ? (product.price2! > -1
                                          ? product.price2!
                                          : product.price!)
                                      .toString()
                                  : addCommasToPrice(product.price2! > -1
                                      ? product.price2!
                                      : product.price!),
                              maxLines: 1,
                              style: TextStyle(
                                  decoration: checkOferPrice(product)
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: checkOferPrice(product)
                                      ? mainColorRed
                                      : mainColorBlack,
                                  fontFamily: checkOferPrice(product)
                                      ? mainFontnormal
                                      : mainFontbold,
                                  fontSize: checkOferPrice(product) ? 11 : 13),
                            ),
                            checkOferPrice(product)
                                ? Text(
                                    addCommasToPrice(product.offerPrice!),
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: green,
                                        fontFamily: mainFontbold,
                                        fontSize: 13),
                                  )
                                : const SizedBox(),
                            Text(
                              maxLines: 1,
                              lang == "en"
                                  ? product.nameEn.toString()
                                  : lang == "ar"
                                      ? product.nameAr.toString()
                                      : product.nameKu.toString(),
                              style: TextStyle(
                                  fontSize: 13,
                                  color: mainColorBlack,
                                  fontFamily: mainFontbold),
                            ),
                            Text(
                              maxLines: 1,
                              lang == "en"
                                  ? product.contentsEn.toString()
                                  : lang == "ar"
                                      ? product.contentsAr.toString()
                                      : product.contentsKu.toString(),
                              style: TextStyle(
                                  fontSize: 11,
                                  color: mainColorBlack.withOpacity(0.5),
                                  fontFamily: mainFontnormal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(0),
                  child: AnimatedContainer(
                    padding: EdgeInsets.all(4),
                    width: isItemInCart ? 140 : 35,
                    height: 35,
                    duration: Duration(milliseconds: 400),
                    decoration: isItemInCart
                        ? BoxDecoration(
                            color: mainColorGrey,
                            borderRadius: BorderRadius.all(Radius.circular(10)))
                        : BoxDecoration(
                            color: mainColorGrey,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15))),
                    child: isItemInCart
                        ? FlipInX(
                            delay: const Duration(milliseconds: 300),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    final cartItem =
                                        CartItem(product: product.id!);
                                    cartProvider.removeFromCart(cartItem);
                                  },
                                  child: Icon(Icons.remove,
                                      color: mainColorWhite,
                                      size: getHeight(context, 2.5)),
                                ),
                                Text(
                                  count.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: mainColorWhite,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: checkProductStock(product, count) ||
                                          checkProductLimit(product, count)
                                      ? null
                                      : () {
                                          final cartItem =
                                              CartItem(product: product.id!);
                                          cartProvider.addToCart(cartItem);
                                        },
                                  child: Icon(LineIcons.plus,
                                      color: checkProductStock(
                                                  product, count) ||
                                              checkProductLimit(product, count)
                                          ? mainColorWhite.withOpacity(0.3)
                                          : mainColorWhite,
                                      size: getHeight(context, 2.5)),
                                ),
                              ],
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              if (!isLogin) {
                                loiginPopup(context);
                                return;
                              }
                              final cartItem = CartItem(product: product.id!);
                              cartProvider.addToCart(cartItem);
                            },
                            child: Icon(LineIcons.plus,
                                color: mainColorWhite,
                                size: getHeight(context, 2.5)),
                          ),
                  ))
            ],
          ),
        );
      },
    ),
  );
}

// here we check for internet availability
Future<bool> checkInternet(BuildContext context) async {
  bool retrive = false;
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult[0] == ConnectivityResult.none) {
    retrive = true;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          child: Text(
            'No internet connection, check your connection'.tr,
            style: TextStyle(
              color: mainColorWhite,
              fontFamily: "RK",
            ),
          ),
        ),
        backgroundColor: mainColorGrey,
      ),
    );
  } else {
    retrive = false;
  }
  return retrive;
}

Future noInternet(BuildContext context) {
  return checkInternet(context);
}

// SnackBar No Internet
SnackBar noInternetSnackBar = SnackBar(
  duration: const Duration(seconds: 4),
  content: Text(
    'You are offline, connect to a network.'.tr,
    style: TextStyle(fontFamily: mainFontnormal),
  ),
  backgroundColor: mainColorGrey,
);

// SnackBar Internet Back
SnackBar internetBackSnackBar = SnackBar(
  duration: const Duration(seconds: 3),
  content: Text(
    "You are online".tr + " ✅",
    style: TextStyle(fontFamily: mainFontnormal),
  ),
  backgroundColor: Colors.green,
);

Future toastShort(
  String message,
) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: mainColorRed.withOpacity(0.5),
      textColor: Colors.white,
      fontSize: 14.0);
}

Future toastLong(
  String message,
) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: mainColorRed.withOpacity(0.5),
      textColor: Colors.white,
      fontSize: 14.0);
}

Widget waitingWiget(BuildContext context) {
  return SizedBox(
    height: getWidth(context, 40),
    child: Image.asset("assets/images/LogoLoading.gif"),
  );
}

Widget waitingWiget2(BuildContext context) {
  return SizedBox(
    height: getWidth(context, 40),
    child: Image.asset("assets/images/LogoLoading.gif"),
  );
}

// Dialogbox ( Register )
Future<void> loiginPopup(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Directionality(
          textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
          child: Stack(
            alignment: lang == "en" ? Alignment.topLeft : Alignment.topRight,
            children: [
              //textcheck
              SizedBox(
                width: getWidth(context, 70),
                height: getHeight(context, 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/Victors/first.png",
                      width: getWidth(context, 40),
                      height: getWidth(context, 40),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Register First".tr,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                        color: mainColorBlack,
                        fontFamily: mainFontbold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterWithPhoneNumber()),
                        );
                      },
                      style: TextButton.styleFrom(
                        fixedSize:
                            Size(getWidth(context, 70), getHeight(context, 5)),
                      ),
                      child: Text(
                        "Register".tr,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: mainColorRed,
                        fixedSize:
                            Size(getWidth(context, 70), getHeight(context, 5)),
                      ),
                      child: Text(
                        "Cancel".tr,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
        ),
      );
    },
  );
}

// Page --> No Internet
noInternetWidget(BuildContext context) {
  return Directionality(
    textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/Dlly Las Logo White.png",
          width: getWidth(context, 30),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: getWidth(context, 100),
            height: getWidth(context, 100),
            child: Image.asset("assets/Victors/wifi.png"),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            "no internet".tr,
            style: TextStyle(fontFamily: mainFontnormal, fontSize: 18),
          ),
        ],
      )),
    ),
  );
}

// Page --> Login First
loginFirstContainer(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/Victors/first.png",
        ),
        SizedBox(
          height: getWidth(context, 12),
          width: getWidth(context, 75),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterWithPhoneNumber()),
              );
            },
            style: TextButton.styleFrom(
              fixedSize: Size(getWidth(context, 70), getHeight(context, 5)),
            ),
            child: Text(
              "Register".tr,
              style: TextStyle(
                  color: mainColorWhite,
                  fontSize: 22,
                  fontFamily: mainFontnormal),
            ),
          ),
        )
      ],
    ),
  );
}
