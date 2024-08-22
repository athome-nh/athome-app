// Importing required packages and files
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/check_out.dart';
import 'package:dllylas/model/cartpast.dart';
import 'package:dllylas/model/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:dllylas/Config/property.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Config/athome_functions.dart';
import '../home/nav_switch.dart';
import '../main.dart';

// StatefulWidget for displaying past order items
class OrederItems extends StatefulWidget {
  const OrederItems({super.key}); // Constructor for OrederItems widget

  @override
  State<OrederItems> createState() => _OrederItemsState(); // Create state for OrederItems
}

// State class for OrederItems
class _OrederItemsState extends State<OrederItems> {
  @override
  Widget build(BuildContext context) {
    // Accessing cart provider to manage cart state
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    // Accessing product provider to get product data
    final productrovider = Provider.of<productProvider>(context, listen: true);

    // Retrieving list of products based on cart item IDs
    List<ProductModel> CardItemshow =
        productrovider.getProductsByIds(cartProvider.ListIdPast());

    // Building the UI with appropriate text direction based on language
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl, // Set text direction based on language
      child: Scaffold(
        backgroundColor: mainColorWhite, // Background color of the scaffold
        appBar: AppBar(
          title: Text(
            "Past Order".tr, // Translated title for the app bar
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to previous screen
              },
              icon: Icon(
                Icons.arrow_back_ios, // Icon for back navigation
              )),
        ),
        body: cartProvider.cartItemsPast.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListView.builder(
                    itemCount: cartProvider.cartItemsPast.length, // Number of items in the cart
                    itemBuilder: (BuildContext context, int index) {
                      // Retrieve cart item and product details
                      final cartitemQ = cartProvider.cartItemsPast[index];
                      final cartitem =
                          productrovider.getoneProductById(cartitemQ.product);

                      return Dismissible(
                        key: Key(cartitem.id.toString()), // Unique key for dismissible widget
                        direction: DismissDirection.startToEnd, // Direction for dismiss action
                        onDismissed: (direction) {
                          // Action to perform when item is dismissed
                          String name = lang == "en"
                              ? cartitem.nameEn.toString() // Get product name in English
                              : lang == "ar"
                                  ? cartitem.nameAr.toString() // Get product name in Arabic
                                  : cartitem.nameKu.toString(); // Get product name in Kurdish
                          cartProvider.deleteitemPast(cartitemQ.product); // Remove item from cart
                          CardItemshow = productrovider
                              .getProductsByIds(cartProvider.ListIdPast()); // Update list of products
                          ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Hide any currently visible snack bar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Delete".tr + " " + name, // Display snack bar with delete message
                              ),
                            ),
                          );
                        },
                        background: Container(
                          color: Colors.red, // Background color when swiping item
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(
                                Icons.delete,
                                color: mainColorWhite, // Color of delete icon
                              ),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: getWidth(context, 2),
                                  right: getWidth(context, 4)),
                              child: Row(
                                children: [
                                  // Product image
                                  Container(
                                    width: getWidth(context, 20),
                                    height: getWidth(context, 20),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              mainColorBlack.withOpacity(0.1)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            dotenv.env['imageUrlServer']! +
                                                cartitem.coverImg!, // URL of the product image
                                        filterQuality: FilterQuality.low,
                                        width: getWidth(context, 15),
                                        height: getWidth(context, 15),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: getWidth(context, 2),
                                  ),
                                  // Product details
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: getWidth(context, 40),
                                        child: Text(
                                          lang == "en"
                                              ? cartitem.nameEn.toString() // Product name in English
                                              : lang == "ar"
                                                  ? cartitem.nameAr.toString() // Product name in Arabic
                                                  : cartitem.nameKu.toString(), // Product name in Kurdish
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: mainColorBlack,
                                              fontFamily: mainFontbold,
                                              fontSize: 14),
                                        ),
                                      ),
                                      SizedBox(
                                        height: getHeight(context, 1),
                                      ),
                                      SizedBox(
                                        width: getWidth(context, 40),
                                        child: Text(
                                          lang == "en"
                                              ? cartitem.contentsEn.toString() // Product content in English
                                              : lang == "ar"
                                                  ? cartitem.contentsAr
                                                      .toString() // Product content in Arabic
                                                  : cartitem.contentsKu
                                                      .toString(), // Product content in Kurdish
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: mainColorGrey
                                                  .withOpacity(0.5),
                                              fontFamily: mainFontbold,
                                              fontSize: 11),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Product price
                                          Text(
                                            addCommasToPrice(
                                                cartitem.price2! > -1
                                                    ? cartitem.price2! // Price with offer if available
                                                    : cartitem.price!), // Regular price
                                            maxLines: 1,
                                            style: TextStyle(
                                                decoration:
                                                    checkOferPrice(cartitem)
                                                        ? TextDecoration
                                                            .lineThrough
                                                        : TextDecoration.none,
                                                color: checkOferPrice(cartitem)
                                                    ? mainColorRed // Color for offer price
                                                    : Colors.green, // Color for regular price
                                                fontFamily:
                                                    checkOferPrice(cartitem)
                                                        ? mainFontnormal
                                                        : mainFontbold,
                                                fontSize: 14),
                                          ),
                                          checkOferPrice(cartitem)
                                              ? const Text("/") // Slash if there's an offer price
                                              : const SizedBox(),
                                          checkOferPrice(cartitem)
                                              ? Text(
                                                  addCommasToPrice(
                                                      cartitem.offerPrice!), // Offer price
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontFamily: mainFontbold,
                                                      fontSize: 14),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  // Quantity controls
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
                                          onTap: checkProductStock(cartitem,
                                                      cartitemQ.quantity) ||
                                                  checkProductLimit(cartitem,
                                                      cartitemQ.quantity)
                                              ? null // Disable button if stock is insufficient or limit reached
                                              : () {
                                                  final cartItem = CartItemPast(
                                                      product:
                                                          cartitemQ.product);
                                                  cartProvider
                                                      .plusToCartPast(cartItem); // Increase quantity in cart
                                                },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: checkProductStock(
                                                                cartitem,
                                                                cartitemQ
                                                                    .quantity) ||
                                                            checkProductLimit(
                                                                cartitem,
                                                                cartitemQ
                                                                    .quantity)
                                                        ? mainColorGrey
                                                            .withOpacity(0.5)
                                                        : Colors.green)),
                                            child: Icon(Icons.add,
                                                color: checkProductStock(
                                                            cartitem,
                                                            cartitemQ
                                                                .quantity) ||
                                                        checkProductLimit(
                                                            cartitem,
                                                            cartitemQ.quantity)
                                                    ? mainColorGrey
                                                        .withOpacity(0.5)
                                                    : Colors.green,
                                                size: getHeight(context, 2.5)),
                                          ),
                                        ),
                                        Text(
                                          cartitemQ.quantity.toString(), // Display current quantity
                                          style: TextStyle(
                                              color: mainColorGrey,
                                              fontFamily: mainFontnormal,
                                              fontSize: 18),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            final cartItem = CartItemPast(
                                                product: cartitemQ.product);
                                            cartProvider
                                                .removeFromCartPast(cartItem); // Decrease item quantity
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: mainColorRed)),
                                            child: Icon(Icons.remove,
                                                color: mainColorRed,
                                                size: getHeight(context, 2.5)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider() // Divider between items
                          ],
                        ),
                      );
                    }),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: getWidth(context, 60),
                      height: getWidth(context, 50),
                      child: Image.asset("assets/Victors/cart_empty.png"), // Empty cart image
                    ),
                    Text(
                      "Your cart is empty".tr, // Message when cart is empty
                      style: TextStyle(
                          fontFamily: mainFontnormal,
                          color: mainColorBlack,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
        bottomNavigationBar: productrovider.nointernetCheck
            ? noInternetWidget(context) // Widget to show when there's no internet
            : cartProvider.cartItemsPast.isNotEmpty
                ? Container(
                    height: getHeight(context, 20),
                    decoration: BoxDecoration(
                      color: mainColorWhite,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: getHeight(context, 3),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 4)),
                          child: Divider(
                              color: mainColorGrey.withOpacity(0.2),
                              thickness: 1), // Divider above total price
                        ),

                        SizedBox(
                          height: getHeight(context, 1),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                textAlign: TextAlign.start,
                                "Total".tr, // Total price label
                                style: TextStyle(
                                    color: mainColorBlack,
                                    fontFamily: mainFontbold,
                                    fontSize: 20),
                              ),
                              Text(
                                textAlign: TextAlign.end,
                                addCommasToPrice(cartProvider
                                    .calculateTotalPricePast(CardItemshow)), // Display total price
                                style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: mainFontbold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: getHeight(context, 2),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  if (await noInternet(context)) { // Check for internet connection
                                    return;
                                  }
                                  cartProvider.addPastToCart(
                                      cartProvider.cartItemsPast); // Add past items to cart

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CheckOut(
                                            cartProvider
                                                .calculateTotalPricePast(
                                                    CardItemshow))), // Navigate to checkout page
                                  ).then((value) {
                                    cartProvider.clearCart(); // Clear cart after checkout
                                  });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: mainColorRed,
                                  fixedSize: Size(getWidth(context, 40),
                                      getHeight(context, 6)),
                                ),
                                child: Text(
                                  "Re order".tr, // Reorder button
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (await noInternet(context)) { // Check for internet connection
                                    return;
                                  }

                                  cartProvider.addPastToCart(
                                      cartProvider.cartItemsPast); // Add past items to cart
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NavSwitch()), // Navigate to add more items
                                  );
                                  cartProvider.clearCartPast(); // Clear past cart items
                                },
                                style: TextButton.styleFrom(
                                  fixedSize: Size(getWidth(context, 40),
                                      getHeight(context, 6)),
                                ),
                                child: Text(
                                  "Add More Items".tr, // Add more items button
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(), // Empty SizedBox when there are no items
      ),
    );
  }
}
