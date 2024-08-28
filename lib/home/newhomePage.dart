// Import necessary packages and libraries
import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:dllylas/Account/reward.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Config/slideshow.dart';
import 'package:dllylas/Landing/splash_screen.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/Notifications/notification_page.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/Categories.dart';
import 'package:dllylas/home/DetailsPage.dart';
import 'package:dllylas/home/alBrands.dart';
import 'package:dllylas/home/all_item.dart';
import 'package:dllylas/home/item_categories.dart';
import 'package:dllylas/home/search_page.dart';
import 'package:dllylas/main.dart';
import 'package:dllylas/map/map_screen.dart';
import 'package:dllylas/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

// This is the homepage of the app, which is a StatefulWidget
class newhomePage extends StatefulWidget {
  const newhomePage({super.key});

  @override
  State<newhomePage> createState() => _newhomePageState();
}

class _newhomePageState extends State<newhomePage> {
  // Controller to manage page view scrolling
  final PageController _pageController = PageController(initialPage: 0);

  // State variables to track active and previous pages
  int _activePage = 1;
  int _oldPage = 0;

  // Controller for managing text input in feedback form
  TextEditingController feedbackController = TextEditingController();

  // Variable to store the selected rating, with nullable int type
  int? selectedRating;

  // State variable to control the expansion of UI elements (e.g., a feedback form)
  bool isExpanded = false;

  // Indicates if the app is waiting for feedback submission
  bool waitingFeedback = false;

  // List of ratings descriptions to display (for 1-5 stars)
  List<String> ratestar = ['Terrible', 'Poor', 'Fair', 'Good', 'Excellent'];

  // List to keep track of the internet connection status, default is no connection
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];

  // Connectivity instance to check the internet status
  final Connectivity _connectivity = Connectivity();

  // Subscription to monitor changes in the connectivity status
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  // This function checks if the internet is available, and then processes cart items
  Future<void> checkinternet() async {
    if (loaddata) {
      // Data already loaded, no need to proceed
    } else {
      // Access the providers for products and cart
      final productrovider =
          Provider.of<productProvider>(context, listen: false);
      final cartprovider = Provider.of<CartProvider>(context, listen: false);

      // Get the list of cart items
      List<CartItem> mycart = cartprovider.cartItems;

      // Loop through cart items and check if they still exist in the product list
      for (var item in mycart) {
        final existingItemIndex = productrovider.products.indexWhere(
          (element) => element.id == item.product,
        );

        // Remove item from cart if it doesn't exist in the product list
        if (existingItemIndex == -1) {
          cartprovider.cartItems.remove(cartprovider.cartItems[item.product]);
        }
      }

      // Get the list of favorite items
      List<CartItem> myfav = cartprovider.FavItems;

      // Loop through favorite items and remove if they no longer exist
      for (var item in myfav) {
        final existingItemIndex = productrovider.products.indexWhere(
          (element) => element.id == item.product,
        );
        if (existingItemIndex == -1) {
          cartprovider.FavItems.remove(cartprovider.FavItems[item.product]);
        }
      }

      // Mark the data as loaded
      loaddata = true;
    }
  }

  // Function to display a home popup to the user
  void showhompopup() {
    // Check if the popup should be displayed
    if ((homePopupData["id"] != userdata["popupID"] ||
            homePopupData["isAlwaysShow"] == 1) &&
        homePopupData.isNotEmpty) {
      // Show the popup based on the user's language preference
      if (lang == "en") {
        _homePopup(context, "pop");
      } else if (lang == "ar") {
        _homePopup(context, "pop");
      } else {
        _homePopup(context, "pop");
      }

      // If the popup hasn't been seen, mark it as seen
      if (homePopupData["id"] != userdata["popupID"] && userdata.isNotEmpty) {
        var data = {"id": userdata["id"], "popId": homePopupData["id"]};
        Network(false).postData("seen", data, context).then((value) {
          if (value != "") {
            if (value["code"] == "201") {
              userdata["popupID"] = homePopupData["id"];
            }
          }
        });
      }

      // Mark the popup as seen
      seenHomepopup = true;
    }
  }

  @override
  void initState() {
    // Access the product provider to load initial data
    final productrovider = Provider.of<productProvider>(context, listen: false);

    // Set a timer to execute after a 1-second delay
    Timer(
      const Duration(seconds: 1),
      () {
        // Check if the user is logged in and handle specific actions
        if (isLogin &&
            productrovider.showuser &&
            productrovider.location.isEmpty) {
          // If location data is missing, prompt the user to enter it
          locationempty();
        } else if (isLogin &&
            productrovider.Orders.isNotEmpty &&
            productrovider.Orders.last.status == 5 &&
            productrovider.Orders.last.rating == null) {
          // Prompt user for feedback if they haven't rated their last order
          feedbackmMdal(context, productrovider);
        } else {
          // Show the home popup if it hasn't been seen
          if (!seenHomepopup) {
            showhompopup();
          }
        }
      },
    );

    // Check the internet connection
    checkinternet();

    // Start listening for connectivity changes
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    super.initState();
  }

  // Function to update the internet connection status based on the result
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    final pro = Provider.of<productProvider>(context, listen: false);

    // If there is no internet connection, update the provider state
    if (result[0] == ConnectivityResult.none) {
      pro.setnointernetcheck(true);
    } else {
      // If internet connection is restored, update the provider state
      if (pro.nointernetCheck) {
        pro.updatePost(false);
        pro.setnointernetcheck(false);
      }
    }

    // Update the connection status state variable
    setState(() {
      _connectionStatus = result;
    });
  }

  /// Builds the main UI of the page, with an AppBar and a body that changes based on network status.
  /// Displays a "no internet" widget if the internet is unavailable; otherwise, shows the content.
  Widget build(BuildContext context) {
    // Accesses the product provider to get the current state and data.
    final productrovider = Provider.of<productProvider>(context, listen: true);

    // Checks if there is no internet connection. If true, it shows a noInternetWidget.
    return productrovider.nointernetCheck
        ? noInternetWidget(context) // Shows a widget indicating no internet.
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading:
                  false, // Disables the default leading widget, like the back button.
              centerTitle: false, // Aligns the title to the start.
              title: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 4), // Adds horizontal padding to the title.
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .start, // Aligns content to the start vertically.
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Aligns content to the start horizontally.
                  children: [
                    Text(
                      "Welcome to"
                          .tr, // Translates "Welcome to" based on the current locale.
                      style: TextStyle(
                          fontSize: 12, // Font size for the welcome text.
                          fontFamily:
                              mainFontnormal), // Font style for the welcome text.
                    ),
                    RichText(
                      // Displays rich text with multiple styles in a single text widget.
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Dlly Las'.tr +
                                " ", // Translates "Dlly Las" based on the current locale.
                            style: TextStyle(
                                fontSize:
                                    16, // Font size for the first part of the text.
                                color:
                                    mainColorGrey, // Grey color for "Dlly Las".
                                fontWeight:
                                    FontWeight.bold, // Bold font weight.
                                fontFamily:
                                    mainFontnormal), // Font style for "Dlly Las".
                          ),
                          TextSpan(
                            text: 'Supermarket'
                                .tr, // Translates "Supermarket" based on the current locale.
                            style: TextStyle(
                                fontSize:
                                    11, // Smaller font size for "Supermarket".
                                color:
                                    mainColorRed, // Red color for "Supermarket".
                                fontWeight:
                                    FontWeight.bold, // Bold font weight.
                                fontFamily:
                                    mainFontnormal), // Font style for "Supermarket".
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal:
                          8), // Adds horizontal padding to the notification icon.
                  child: IconButton.filledTonal(
                    // Icon button for notifications.
                    style: IconButton.styleFrom(
                        backgroundColor:
                            mainColorlightGrey), // Sets the background color for the icon button.
                    icon: Icon(
                      Icons.notifications, // Notification bell icon.
                      color: mainColorGrey2, // Sets the color of the icon.
                      size: 25, // Sets the size of the icon.
                    ),
                    onPressed: () {
                      // Navigates to the notification page when pressed.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NotificationPage()), // Opens the notification page.
                      );
                    },
                  ),
                ),
              ],
            ),

            /// Builds the main body of the page, containing a scrollable view with categories and a search bar.
            /// Uses SingleChildScrollView to handle vertical scrolling and displays a carousel, categories,
            /// and various elements like loading skeletons and placeholder images.
            body: SingleChildScrollView(
              child: Padding(
                // Adds padding around the content, adjusting dynamically based on screen width.
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Aligns items to the left.
                  children: [
                    GestureDetector(
                      // Wraps a tapable widget to navigate to the Search screen.
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Search()), // Opens the Search screen.
                        );
                      },
                      child: Container(
                        // Search bar container with rounded corners and padding.
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context, 1)),
                        decoration: BoxDecoration(
                          color: mainColorlightGrey,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: mainColorlightGrey),
                        ),
                        height: getHeight(context, 6),
                        child: Row(
                          children: [
                            Icon(
                              Ionicons.search_outline, // Search icon.
                              color: mainColorGrey2,
                              size: 22,
                            ),
                            SizedBox(
                                width: getWidth(context,
                                    2)), // Space between icon and divider.
                            Container(
                              height: 20,
                              width: 2,
                              color: mainColorGrey2, // Vertical divider.
                            ),
                            SizedBox(
                                width: getWidth(context,
                                    2)), // Space between divider and text.
                            Text(
                              "What are you searching for?"
                                  .tr, // Placeholder text, translated.
                              style: TextStyle(
                                fontFamily: mainFontnormal,
                                color: mainColorGrey2,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Space
                    SizedBox(height: getHeight(context, 2)),

                    // Displays a carousel widget showing products from the provider.
                    Carousel(productrovider),

                    // Space
                    SizedBox(height: getHeight(context, 2)),

                    // Displays the "Categories" header.
                    Text(
                      "Categories".tr, // Translates "Categories".
                      style: TextStyle(
                          color: mainColorBlack,
                          fontSize: 20,
                          fontFamily: mainFontbold),
                    ),

                    // The Visibility widget controls whether its child is visible or not based on the 'visible' property.
                    Visibility(
                      visible: productrovider
                          .show, // Condition to show the child widget or replacement.
                      replacement: Skeletonizer(
                        enabled: true, // Enables the Skeletonizer effect.
                        effect: ShimmerEffect.raw(
                          colors: [
                            // Colors for the shimmer effect.
                            mainColorGrey.withOpacity(0.1),
                            mainColorWhite,
                            // mainColorRed.withOpacity(0.1),
                          ],
                        ),
                        // Row widget for horizontal layout
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Space between children
                          children: [
                            // Container for a box with rounded corners
                            Container(
                              width: getWidth(context, 55),
                              height: getHeight(context, 22),
                              decoration: BoxDecoration(
                                color: mainColorlightGrey,
                                borderRadius: BorderRadius.circular(
                                    10), // Rounded corners
                              ),
                              child: Container(
                                width: getWidth(context, 55),
                                height: getHeight(context, 22),
                                color: mainColorlightGrey,
                              ),
                            ),
                            // Another container with a PageView
                            Container(
                              width: getWidth(context, 35),
                              height: getHeight(context, 22),
                              decoration: BoxDecoration(
                                color: mainColorlightGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                alignment: lang == "en"
                                    ? Alignment.centerRight
                                    : Alignment
                                        .centerLeft, // Alignment based on language
                                children: [
                                  // PageView to display pages vertically
                                  PageView.builder(
                                    controller: _pageController,
                                    onPageChanged: (int
                                        page) {}, // Event when the page changes
                                    scrollDirection:
                                        Axis.vertical, // Vertical scrolling
                                    itemCount: 10, // Number of items
                                    itemBuilder: (context, index) {
                                      // Each item is a GestureDetector widget
                                      return GestureDetector(
                                        onTap: () {}, // Action on tap
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              8.0), // Padding around the item
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center, // Align items in the center
                                            children: [
                                              Text(
                                                "Hello baby njas",
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: mainColorBlack,
                                                  fontFamily: mainFontbold,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Expanded(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(
                                                        10), // Rounded top corners
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/category.png", // Placeholder image
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: getHeight(context, 2.5),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                  color: mainColorGrey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5), // Rounded corners
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween, // Space between text and icon
                                                  children: [
                                                    Text(
                                                      "See More",
                                                      style: TextStyle(
                                                        color: mainColorWhite,
                                                        fontFamily:
                                                            mainFontnormal,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: mainColorWhite,
                                                      size: 15,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Space between children
                        children: [
                          // GestureDetector for handling taps
                          GestureDetector(
                            onTap: () {
                              !productrovider.show
                                  ? const SizedBox()
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Categories(),
                                      ),
                                    );
                            },
                            child: Stack(
                              alignment: lang == "en"
                                  ? Alignment.centerRight
                                  : Alignment
                                      .centerLeft, // Alignment based on language
                              children: [
                                Stack(
                                  alignment: lang == "en"
                                      ? Alignment.bottomLeft
                                      : Alignment
                                          .bottomRight, // Alignment for stacked children
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(
                                          8), // Padding inside the container
                                      width: getWidth(context, 55),
                                      height: getHeight(context, 22),
                                      decoration: BoxDecoration(
                                        color: mainColorlightGrey,
                                        borderRadius: BorderRadius.circular(
                                            10), // Rounded corners
                                      ),
                                      child: Text(
                                        'All Categories'
                                            .tr, // Text with translation
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: mainColorGrey,
                                          fontFamily: mainFontbold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Image.asset(
                                        "assets/images/category.png",
                                        width: getHeight(context, 15),
                                        height: getHeight(context, 15),
                                      ),
                                    ),
                                  ],
                                ),
                                // Column of images
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Image.asset(
                                        "assets/images/meat.png",
                                        width: getHeight(context, 7),
                                        height: getHeight(context, 7),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Image.asset(
                                        "assets/images/baby.png",
                                        width: getHeight(context, 7),
                                        height: getHeight(context, 7),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Image.asset(
                                        "assets/images/care.png",
                                        width: getHeight(context, 7),
                                        height: getHeight(context, 7),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Container with a Stack and PageView
                          Container(
                            width: getWidth(context, 35),
                            height: getHeight(context, 22),
                            decoration: BoxDecoration(
                              color: mainColorlightGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              alignment: lang == "en"
                                  ? Alignment.centerRight
                                  : Alignment
                                      .centerLeft, // Alignment for children
                              children: [
                                // PageView builder for categories
                                PageView.builder(
                                  controller: _pageController,
                                  onPageChanged: (int page) {
                                    // Updates the active page based on swipe
                                    setState(() {
                                      if (_activePage == 5) {
                                        if (_oldPage < page) {
                                          _oldPage = page;
                                          _activePage = 1;
                                        } else {
                                          _oldPage = page;
                                          _activePage = 4;
                                        }
                                      } else {
                                        if (_oldPage < page) {
                                          _oldPage = page;
                                          _activePage++;
                                        } else {
                                          if (_activePage == 1) {
                                            _oldPage = page;
                                            _activePage = 5;
                                          } else {
                                            _oldPage = page;
                                            _activePage--;
                                          }
                                        }
                                      }
                                    });
                                  },
                                  scrollDirection:
                                      Axis.vertical, // Vertical scrolling
                                  itemCount: productrovider
                                      .categores.length, // Number of categories
                                  itemBuilder: (context, index) {
                                    final category = productrovider
                                        .categores[index]; // Get category
                                    return GestureDetector(
                                      onTap: () {
                                        productrovider.setcatetype(category
                                            .id!); // Set selected category
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                itemCategories(), // Navigate to item categories
                                          ),
                                        ).then((value) {
                                          productrovider.setsubcateSelect(
                                              0); // Reset subcategory selection
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                            8.0), // Padding around each category item
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center, // Align center
                                          children: [
                                            Text(
                                              lang == "en"
                                                  ? category.nameEn!
                                                  : lang == "ar"
                                                      ? category.nameAr!
                                                      : category
                                                          .nameKu!, // Display category name based on language
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: mainColorBlack,
                                                fontFamily: mainFontbold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Expanded(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(
                                                      10), // Rounded top corners
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: dotenv.env[
                                                          'imageUrlServer']! +
                                                      category
                                                          .img!, // Load image from network
                                                  placeholder: (context, url) =>
                                                      Image.asset(
                                                          "assets/images/Logo-Type-2.png"), // Placeholder image
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Image.asset(
                                                          "assets/images/Logo-Type-2.png"), // Error image
                                                  filterQuality: FilterQuality
                                                      .low, // Image quality
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: getHeight(context, 2.5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: mainColorGrey,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        5), // Rounded corners
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween, // Space between text and icon
                                                children: [
                                                  Text(
                                                    "See More"
                                                        .tr, // Text with translation
                                                    style: TextStyle(
                                                      color: mainColorWhite,
                                                      fontFamily:
                                                          mainFontnormal,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: mainColorWhite,
                                                    size: 15,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                // Container with indicators for page navigation
                                Container(
                                  height: getHeight(context, 10),
                                  width: getWidth(context, 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly, // Even spacing for indicators
                                      children: [
                                        CircleAvatar(
                                          radius: 3,
                                          backgroundColor: _activePage == 1
                                              ? mainColorGrey
                                              : mainColorGrey2, // Active page indicator
                                        ),
                                        CircleAvatar(
                                          radius: 3,
                                          backgroundColor: _activePage == 2
                                              ? mainColorGrey
                                              : mainColorGrey2,
                                        ),
                                        CircleAvatar(
                                          radius: 3,
                                          backgroundColor: _activePage == 3
                                              ? mainColorGrey
                                              : mainColorGrey2,
                                        ),
                                        CircleAvatar(
                                          radius: 3,
                                          backgroundColor: _activePage == 4
                                              ? mainColorGrey
                                              : mainColorGrey2,
                                        ),
                                        CircleAvatar(
                                          radius: 3,
                                          backgroundColor: _activePage == 5
                                              ? mainColorGrey
                                              : mainColorGrey2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Space
                    SizedBox(height: getHeight(context, 2)),

                    // Conditional rendering based on the visibility of `productrovider.show`.
                    // Displays a skeleton loader if `productrovider.show` is false.
                    Visibility(
                      visible: productrovider.show,
                      replacement: Skeletonizer(
                        child: Stack(
                          alignment: lang == "en"
                              ? Alignment.bottomRight
                              : Alignment.bottomLeft,
                          children: [
                            Container(
                              width: getWidth(context, 100),
                              height: getHeight(context, 11),
                              decoration: BoxDecoration(
                                  color: mainColorlightGrey,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'Hi'.tr + " ",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: mainColorGrey,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: mainFontnormal),
                                              ),
                                              TextSpan(
                                                text:
                                                    "sdjjsdkjd", // Placeholder text; replace with dynamic content if needed.
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: mainColorRed,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: mainFontnormal),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "You are doing so well",
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: mainColorRed,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: mainFontnormal),
                                        ),
                                        Row(
                                          children: [
                                            Skeleton.keep(
                                              child: Image.asset(
                                                "assets/images/star.png",
                                                width: getWidth(context, 6),
                                                height: getWidth(context, 6),
                                              ),
                                            ),
                                            Text(
                                              "5000", // Placeholder points; replace with dynamic content if needed.
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: mainColorRed,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: mainFontbold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "data "), // Placeholder text; replace with dynamic content if needed.
                                        Text(
                                            "data sdjj dhhdhd d dhdh"), // Placeholder text; replace with dynamic content if needed.
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: mainColorRed),
                              iconAlignment: IconAlignment.end,
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ),
                              label: Text(
                                "See More",
                                style: TextStyle(
                                    color: mainColorRed,
                                    fontFamily: mainFontnormal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11),
                              ),
                              onPressed: productrovider.show
                                  ? () {}
                                  : null, // No action if `productrovider.show` is false.
                            )
                          ],
                        ),
                      ),
                      child: Stack(
                        alignment: lang == "en"
                            ? Alignment.bottomRight
                            : Alignment.bottomLeft,
                        children: [
                          Container(
                            width: getWidth(context, 100),
                            height: getHeight(context, 12),
                            decoration: BoxDecoration(
                                color: mainColorlightGrey,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Hi'.tr + " ",
                                              style: TextStyle(
                                                  fontSize:
                                                      userdata["name"] == null
                                                          ? 12
                                                          : 16,
                                                  color: mainColorGrey,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: mainFontnormal),
                                            ),
                                            TextSpan(
                                              text: userdata["name"] == null
                                                  ? "Dear Guest".tr
                                                  : userdata["name"]
                                                      .toString()
                                                      .split(" ")[0],
                                              style: TextStyle(
                                                  fontSize:
                                                      userdata["name"] == null
                                                          ? 12
                                                          : 16,
                                                  color: mainColorRed,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: mainFontnormal),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/images/star.png",
                                            width: getWidth(context, 7),
                                            height: getWidth(context, 7),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            (userdata["point"] ?? "0")
                                                .toString(), // Displays user points.
                                            style: TextStyle(
                                                fontSize: getHeight(context, 3),
                                                color: mainColorRed,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: mainFontbold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    "assets/images/gobuy.png",
                                    width: getWidth(context, 45),
                                    height: getHeight(context, 6),
                                  )
                                ],
                              ),
                            ),
                          ),
                          TextButton.icon(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: mainColorRed),
                            iconAlignment: IconAlignment.end,
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            ),
                            label: Text(
                              "See More".tr, // Translated text.
                              style: TextStyle(
                                  color: mainColorRed,
                                  fontFamily: mainFontnormal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                            ),
                            onPressed: productrovider.show && isLogin
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const coinReward()), // Navigates to the coin reward page.
                                    );
                                  }
                                : null, // Disables button if `productrovider.show` is false or if the user is not logged in.
                          )
                        ],
                      ),
                    ),

                    // Conditional rendering based on the presence of order items and discounted products.
                    // Displays recent orders if available.
                    productrovider.Orderitems.isNotEmpty &&
                            productrovider
                                .getProductsByIds2(
                                  productrovider.listOrderProductIds(),
                                )
                                .isNotEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                  height: getHeight(context,
                                      1)), // Adds space before the recent orders section.
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Spreads text and view all button.
                                children: [
                                  Text(
                                    "Recent Order"
                                        .tr, // Section title, translated.
                                    style: TextStyle(
                                        color: mainColorBlack,
                                        fontSize: 16,
                                        fontFamily: mainFontbold),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (productrovider.show) {
                                            productrovider.settype("orders");
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AllItem()), // Navigates to all items page.
                                            );
                                          }
                                        },
                                        child: Text(
                                          "View All"
                                              .tr, // View all button text, translated.
                                          style: TextStyle(color: mainColorRed),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: getHeight(context,
                                      1)), // Adds space before the list of recent orders.
                              listItemsSmall(
                                  context,
                                  productrovider.getProductsByIds2(
                                    productrovider.listOrderProductIds(),
                                  ),
                                  false), // Displays recent order items.
                            ],
                          )
                        : const SizedBox(), // Displays an empty container if no recent orders are available.

// Displays discounted products if available.
                    productrovider.getProductsByDiscount().isNotEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                  height: getHeight(context,
                                      1)), // Adds space before the discounts section.
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Spreads text and view all button.
                                children: [
                                  Text(
                                    "Discount".tr, // Section title, translated.
                                    style: TextStyle(
                                        color: mainColorBlack,
                                        fontSize: 16,
                                        fontFamily: mainFontbold),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (productrovider.show) {
                                        productrovider.settype("discount");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AllItem()), // Navigates to all items page.
                                        );
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "View All"
                                              .tr, // View all button text, translated.
                                          style: TextStyle(color: mainColorRed),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: getHeight(context,
                                      1)), // Adds space before the list of discounted products.
                              listItemsSmall(
                                  context,
                                  productrovider.getProductsByDiscount(),
                                  true), // Displays discounted items.
                            ],
                          )
                        : const SizedBox(), // Displays an empty container if no discounts are available.

                    // Space
                    SizedBox(height: getHeight(context, 1)),
                    // Section for displaying product highlights.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Highlight".tr, // Translated section title.
                          style: TextStyle(
                              color: mainColorBlack,
                              fontSize: 16,
                              fontFamily: mainFontbold),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (productrovider.show) {
                              productrovider.settype("Highlight");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AllItem()), // Navigates to all items page for highlights.
                              );
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                "View All".tr, // Translated button text.
                                style: TextStyle(color: mainColorRed),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                        height: getHeight(context,
                            1)), // Adds space between highlight section and items list.

                    listItemsSmall(
                        context,
                        productrovider.getProductsByHighlight(),
                        false), // Displays the list of highlighted products.

                    SizedBox(
                        height: getHeight(context,
                            1)), // Adds space between highlight items and brands section.

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Brands".tr, // Translated section title.
                          style: TextStyle(
                              color: mainColorBlack,
                              fontSize: 16,
                              fontFamily: mainFontbold),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (productrovider.show) {
                                  productrovider.settype("best");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const allBrands()), // Navigates to all brands page.
                                  );
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "View All".tr, // Translated button text.
                                    style: TextStyle(color: mainColorRed),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                        height: getHeight(context,
                            1)), // Adds space between brands section and brands list.

                    listitemsBrands(context,
                        productrovider.brands), // Displays the list of brands.

                    SizedBox(
                        height: getHeight(context,
                            1)), // Adds space between brands list and best-sell section.

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Best Sell".tr, // Translated section title.
                            style: TextStyle(
                                color: mainColorBlack,
                                fontSize: 16,
                                fontFamily: mainFontbold)),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (productrovider.show) {
                                  productrovider.settype("best");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AllItem()), // Navigates to all items page for best-selling products.
                                  );
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "View All".tr, // Translated button text.
                                    style: TextStyle(color: mainColorRed),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    listItemsSmall(
                        context,
                        productrovider.getProductsByBestsell(),
                        false), // Displays the list of best-selling products.

                    SizedBox(
                        height: getHeight(context,
                            2)), // Adds space before the advertisement section.

                    Visibility(
                      visible: productrovider
                          .show, // Shows the content if `productrovider.show` is true.
                      replacement: Skeletonizer(
                        effect: ShimmerEffect.raw(colors: [
                          mainColorGrey.withOpacity(0.1),
                          mainColorWhite,
                        ]),
                        child: Container(
                          height: getHeight(context, 22),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/images/Reklam.jpg", // Placeholder image.
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      child: productrovider.tops.isEmpty
                          ? SizedBox() // Displays an empty container if `productrovider.tops` is empty.
                          : GestureDetector(
                              onTap: () {
                                productrovider.settype("brand");
                                productrovider.setidbrand(productrovider
                                    .tops
                                    .first
                                    .brandId!); // Sets brand type and id for navigation.
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AllItem()), // Navigates to all items page for the selected brand.
                                );
                              },
                              child: Container(
                                height: getHeight(context, 22),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: dotenv.env['imageUrlServer']! +
                                        productrovider.tops.first
                                            .imgEn!, // Displays brand advertisement image.
                                    placeholder: (context, url) => Image.asset(
                                        "assets/images/Logo-Type-2.png"), // Placeholder image.
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            "assets/images/Logo-Type-2.png"), // Error image.
                                    filterQuality: FilterQuality.low,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                    ),

                    SizedBox(
                        height: getHeight(context,
                            2)), // Adds space after the advertisement section.
                  ],
                ),
              ),
            ),
          );
  }

  /// Displays a popup dialog with different content based on the [type] parameter.
  /// The dialog may show information about a product, brand, discount, or item details.
  Future<void> _homePopup(
    BuildContext context,
    String type,
  ) {
    return showDialog(
      context: context, // The context of the widget to display the dialog over.
      builder: (BuildContext context) {
        // Access the product provider.
        final productrovider =
            Provider.of<productProvider>(context, listen: false);
        return AlertDialog(
          actionsPadding:
              EdgeInsets.all(0), // Removes padding for dialog actions.
          contentPadding:
              EdgeInsets.all(0), // Removes padding for dialog content.
          content: Directionality(
            textDirection: lang == "en"
                ? TextDirection.ltr
                : TextDirection.rtl, // Sets text direction based on language.
            child: Stack(
              alignment: lang == "en"
                  ? Alignment.topRight
                  : Alignment.topLeft, // Aligns elements based on language.
              children: [
                Stack(
                  alignment: Alignment
                      .bottomCenter, // Aligns content at the bottom center.
                  children: [
                    SizedBox(
                      width: getWidth(
                          context, 100), // Width of the image container.
                      height: getHeight(
                          context, 45), // Height of the image container.
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            15.0), // Rounded corners for the image.
                        child: CachedNetworkImage(
                          imageUrl: dotenv.env['imageUrlServer']! +
                              homePopupData[
                                  "img"], // Displays an image from the network.
                          placeholder: (context, url) => Image.asset(
                              "assets/images/Logo-Type-2.png"), // Placeholder image while loading.
                          errorWidget: (context, url, error) => Image.asset(
                              "assets/images/Logo-Type-2.png"), // Error image if loading fails.
                          filterQuality: FilterQuality
                              .low, // Low quality for performance reasons.
                          fit: BoxFit
                              .cover, // Ensures the image covers the entire area.
                        ),
                      ),
                    ),
                    FadeInUp(
                      // Fade-in animation for the button.
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 5), // Adds spacing below the button.
                        child: TextButton(
                          onPressed: () async {
                            // Handles different actions based on the popup type.
                            if (homePopupData["type"] == "attention") {
                              Navigator.pop(context); // Close the dialog.
                            } else if (homePopupData["type"] == "brand") {
                              productrovider.settype("brand");
                              productrovider
                                  .setidbrand(homePopupData["brand_id"]);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AllItem()), // Navigate to the AllItem page.
                              );
                            } else if (homePopupData["type"] == "discount") {
                              productrovider.settype("discount");
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AllItem()), // Navigate to the AllItem page with discount filtering.
                              );
                            } else if (homePopupData["type"] == "onItem") {
                              print(homePopupData[
                                  "barcode"]); // Logs the barcode.
                              productrovider.setidItem(productrovider
                                  .getoneProductByBarcode(
                                      homePopupData["barcode"])
                                  .id!);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsPage(
                                        color:
                                            5)), // Navigate to the item details page.
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            fixedSize: Size(
                                getWidth(context, 45),
                                getHeight(context,
                                    5)), // Sets the size of the button.
                          ),
                          // Sets the button text based on the popup type.
                          child: Text(
                            homePopupData["type"] == "attention"
                                ? "OK"
                                    .tr // Translates "OK" based on the current locale.
                                : "tap View"
                                    .tr, // Translates "tap View" based on the current locale.
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                    // Icon to close the dialog.
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog.
                    },
                    icon: Icon(
                      Icons.close, // Close icon.
                      color: mainColorRed, // Red color for the close icon.
                      size: 35, // Size of the close icon.
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  /// Displays a bottom sheet for selecting or adding a location.
  /// If no locations are found, the user is prompted to add a new location.
  Future<void> locationempty() {
    return showModalBottomSheet(
      isScrollControlled: true, // Allows the sheet to scroll with content.
      isDismissible:
          false, // Prevents the sheet from being dismissed by tapping outside.
      enableDrag: false, // Disables drag-to-dismiss functionality.
      context:
          context, // The context of the widget to display the bottom sheet over.
      backgroundColor: Colors.white, // Sets the background color of the sheet.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(25), // Rounded top corners of the sheet.
          topStart: Radius.circular(25), // Rounded top corners of the sheet.
        ),
      ),
      builder: (context) => Directionality(
        textDirection: lang == "en"
            ? TextDirection.ltr
            : TextDirection.rtl, // Sets text direction based on language.
        child: PopScope(
          canPop:
              false, // Disables the back button functionality for this sheet.
          onPopInvoked: (didPop) {},
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter mystate) {
            final productrovider = Provider.of<productProvider>(context,
                listen: true); // Listens to the product provider.
            return Stack(
              alignment:
                  Alignment.topCenter, // Aligns the content at the top center.
              children: [
                SizedBox(
                  width: getWidth(context, 100), // Width of the content area.
                  height: productrovider.location.isEmpty
                      ? getHeight(
                          context, 40) // Height when there are no locations.
                      : getHeight(
                          context, 50), // Height when locations are available.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Center the content horizontally.
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Center the content vertically.
                    children: <Widget>[
                      productrovider.location.isEmpty
                          ? Column(
                              // Prompts the user to add a location when the list is empty.
                              children: [
                                SizedBox(
                                  height: getHeight(context,
                                      5), // Spacing before the location prompt.
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    LocationPermission permission = await Geolocator
                                        .requestPermission(); // Requests location permission from the user.
                                    if (permission ==
                                        LocationPermission.denied) {
                                      // Handle case where the user denied access to their location.
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Map_screen()), // Navigate to the map screen.
                                    );
                                  },
                                  child: SizedBox(
                                    width: getWidth(
                                        context, 100), // Width of the image.
                                    height: getHeight(
                                        context, 15), // Height of the image.
                                    child: Image.asset(lang == "en"
                                        ? "assets/Victors/location.png" // Location image for English.
                                        : lang == "ar"
                                            ? "assets/Victors/locationAr.png" // Location image for Arabic.
                                            : "assets/Victors/locationKu.png"), // Location image for Kurdish.
                                  ),
                                ),
                                SizedBox(
                                  height: getHeight(context,
                                      5), // Spacing after the location image.
                                ),
                              ],
                            )
                          : Container(
                              width: getWidth(
                                  context, 100), // Width of the list container.
                              height: getHeight(
                                  context, 35), // Height of the list container.
                              child: ListView.builder(
                                  // Displays the list of locations.
                                  itemCount: productrovider.location.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final location = productrovider
                                            .location.reversed
                                            .toList()[
                                        index]; // Retrieves the reversed list of locations.

                                    return Padding(
                                      padding: const EdgeInsets.all(
                                          8.0), // Padding around each list item.
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              15), // Rounded corners for each list item.
                                          border: Border.all(
                                            color: mainColorGrey.withOpacity(
                                                0.5), // Border color with opacity.
                                            width: 1, // Border width.
                                            style: BorderStyle
                                                .solid, // Solid border style.
                                          ),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            // Handles selecting a location.
                                            if (productrovider.defultlocation ==
                                                location.id!) {
                                            } else {
                                              mystate(() {
                                                productrovider
                                                    .setdefultlocation(location
                                                        .id!); // Sets the default location.
                                              });
                                              Navigator.pop(
                                                  context); // Closes the sheet after selection.
                                            }
                                          },
                                          title: Text(
                                            location
                                                .name!, // Displays the location name.
                                            maxLines: 1, // Limits to one line.
                                            style: TextStyle(
                                                fontFamily:
                                                    mainFontbold, // Bold font for the location name.
                                                color:
                                                    mainColorBlack, // Black text color.
                                                fontSize: 16), // Font size.
                                          ),
                                          subtitle: Text(
                                            location
                                                .area!, // Displays the location area.
                                            style: TextStyle(
                                                fontFamily:
                                                    mainFontnormal, // Normal font for the area name.
                                                color:
                                                    mainColorGrey, // Grey text color.
                                                fontSize: 12), // Font size.
                                          ),
                                          trailing: Icon(
                                            productrovider.defultlocation ==
                                                    location.id!
                                                ? Icons
                                                    .check_box // Checked box for selected location.
                                                : Icons
                                                    .check_box_outline_blank, // Unchecked box for non-selected location.
                                            color: mainColorGrey, // Icon color.
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                      TextButton(
                        // Button to add a new location.
                        onPressed: () async {
                          LocationPermission permission = await Geolocator
                              .requestPermission(); // Requests location permission.
                          if (permission == LocationPermission.denied) {
                            // Handle case where the user denied access to their location.
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Map_screen()), // Navigate to the map screen.
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: productrovider.location.length > 0
                              ? mainColorGrey // Grey color when locations exist.
                              : mainColorRed, // Red color when no locations exist.
                          fixedSize: Size(getWidth(context, 70),
                              getHeight(context, 5)), // Sets the button size.
                        ),
                        child: Text(
                          "Add location"
                              .tr, // Translates "Add location" based on the current locale.
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0), // Spacing for the draggable indicator.
                    child: Container(
                      width: 65, // Width of the draggable indicator.
                      height: 5, // Height of the draggable indicator.
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            100), // Circular corners for the draggable indicator.
                        color:
                            mainColorGrey, // Grey color for the draggable indicator.
                      ),
                    ))
              ],
            );
          }),
        ),
      ),
    ).then((value) {});
  }

  // This function displays a feedback modal for users to rate their experience with an order
  void feedbackmMdal(BuildContext context, productProvider pro) {
    // Show a modal bottom sheet that slides up from the bottom of the screen
    showModalBottomSheet(
      backgroundColor: mainColorWhite,
      context: context,
      isScrollControlled:
          true, // Allow the modal to adjust when the keyboard is shown
      enableDrag: true, // Allow the modal to be draggable by the user
      builder: (BuildContext context) {
        // Use StatefulBuilder to allow state changes within the modal
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return GestureDetector(
              onTap: () {
                // Unfocus any input fields when the user taps outside of them
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: AnimatedContainer(
                duration:
                    Duration(milliseconds: 400), // Animate the height change
                height: isExpanded
                    ? MediaQuery.of(context).size.height -
                        150 // Expanded state height
                    : MediaQuery.of(context).size.height *
                        0.35, // Collapsed state height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15), // Round top left corner
                    topRight: Radius.circular(15), // Round top right corner
                  ),
                ),
                child: Stack(
                  children: [
                    // Main content of the modal in a scrollable view
                    SingleChildScrollView(
                      child: Directionality(
                        textDirection: lang == "en"
                            ? TextDirection.ltr // Left-to-right for English
                            : TextDirection
                                .rtl, // Right-to-left for other languages
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Stack(
                              alignment: lang == "en"
                                  ? Alignment
                                      .topRight // Align elements to the top right for English
                                  : Alignment
                                      .topLeft, // Align elements to the top left for others
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Spacing
                                    SizedBox(height: getHeight(context, 4)),
                                    // Image of the app logo or main image
                                    Image.asset(
                                      'assets/images/Dlly Las Main.png',
                                      width: getWidth(context, 35),
                                    ),
                                    // Additional spacing
                                    SizedBox(height: getHeight(context, 2)),
                                    // Rating description text
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: getWidth(context, 6)),
                                      child: Text(
                                        "rating detail text"
                                            .tr, // Translated rating detail text
                                        style: TextStyle(
                                          color: mainColorBlack,
                                          fontFamily: mainFontbold,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    // Additional spacing
                                    SizedBox(height: getHeight(context, 2)),
                                    // Rating bar widget
                                    RatingBar(
                                      filledIcon:
                                          LineIcons.starAlt, // Filled star icon
                                      emptyIcon:
                                          LineIcons.star, // Empty star icon
                                      key: Key(
                                          'rating_bar'), // Key for the rating bar
                                      onRatingChanged: (value) {
                                        // Update state when rating changes
                                        setState(() {
                                          selectedRating = int.parse(value
                                              .toString()
                                              .substring(0,
                                                  1)); // Extract rating value
                                          isExpanded = true; // Expand the modal
                                        });
                                      },
                                      initialRating:
                                          0, // Initial rating set to 0
                                      alignment: Alignment.center,
                                      size: 50, // Size of the rating bar icons
                                    ),
                                    // Additional spacing
                                    SizedBox(height: getHeight(context, 2)),
                                    // Display selected rating description if modal is expanded
                                    isExpanded
                                        ? Text(
                                            ratestar[selectedRating! - 1]
                                                .tr, // Translated rating description
                                            style: TextStyle(
                                              color: mainColorBlack,
                                              fontFamily: mainFontnormal,
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        : SizedBox(),
                                    // Show feedback form if modal is expanded
                                    isExpanded
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  height:
                                                      getHeight(context, 3)),
                                              // Feedback text field for user input
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.0),
                                                child: TextFormField(
                                                  maxLines:
                                                      5, // Allow multiple lines of feedback
                                                  controller:
                                                      feedbackController, // Controller for the feedback input
                                                  cursorColor:
                                                      mainColorGrey, // Cursor color
                                                  keyboardType: TextInputType
                                                      .text, // Text input type
                                                  onChanged: (value) {},
                                                  validator: (value) {
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide: BorderSide(
                                                        color:
                                                            mainColorGrey, // Focused border color
                                                        width:
                                                            1.0, // Border width
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      borderSide: BorderSide(
                                                        color: mainColorGrey
                                                            .withOpacity(
                                                                0.5), // Enabled border color
                                                        width:
                                                            1.0, // Border width
                                                      ),
                                                    ),
                                                    labelText: "Feedback"
                                                        .tr, // Translated label text
                                                    labelStyle: TextStyle(
                                                        color: mainColorGrey
                                                            .withOpacity(0.8),
                                                        fontSize: 20,
                                                        fontFamily:
                                                            mainFontbold),
                                                    hintText: "Add your Feedback"
                                                        .tr, // Translated hint text
                                                    hintStyle: TextStyle(
                                                        color: mainColorBlack
                                                            .withOpacity(0.5),
                                                        fontSize: 14,
                                                        fontFamily:
                                                            mainFontnormal),
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .always,
                                                  ),
                                                ),
                                              ),
                                              // Additional spacing
                                              SizedBox(
                                                  height:
                                                      getHeight(context, 20)),
                                              // Submit feedback button
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        getWidth(context, 4)),
                                                child: TextButton(
                                                  onPressed: () async {
                                                    var data = {
                                                      "oid": pro.Orders.last
                                                          .id, // Order ID
                                                      "feedback": feedbackController
                                                          .text, // User feedback
                                                      "rating":
                                                          selectedRating // User rating
                                                    };
                                                    // Send feedback data to the server
                                                    Network(false)
                                                        .postData(
                                                            "orderFeedback",
                                                            data,
                                                            context)
                                                        .then((value) {
                                                      if (value != "") {
                                                        if (value["code"] ==
                                                            "201") {
                                                          setState(() {
                                                            waitingFeedback =
                                                                true; // Show loading indicator
                                                            pro.Orders.last
                                                                    .rating =
                                                                selectedRating; // Update order rating
                                                            Navigator.pop(
                                                                context); // Close modal
                                                          });
                                                        } else {
                                                          setState(() {
                                                            waitingFeedback =
                                                                false; // Hide loading indicator
                                                          });
                                                        }
                                                      } else {
                                                        setState(() {
                                                          waitingFeedback =
                                                              false; // Hide loading indicator
                                                        });
                                                      }
                                                    });
                                                  },
                                                  style: TextButton.styleFrom(
                                                    fixedSize: Size(
                                                        getWidth(context, 90),
                                                        getHeight(context, 6)),
                                                  ),
                                                  child: Text("Send Feedback"
                                                      .tr), // Translated button text
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                                // Close button for the modal
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context); // Close the modal
                                    },
                                    icon: Icon(
                                      Icons.close, // Close icon
                                      color: mainColorGrey,
                                      size: 30,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // Modal handle bar at the top of the sheet
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                width: 65,
                                height: 5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: mainColorGrey, // Handle bar color
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Show loading indicator if waiting for feedback submission
                    waitingFeedback
                        ? Center(child: waitingWiget(context))
                        : SizedBox(),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((value) {
      // If the feedback submission was cancelled or incomplete
      if (!waitingFeedback) {
        var data = {
          "oid": pro.Orders.last.id, // Order ID
          "feedback": "", // No feedback provided
          "rating": -1 // No rating provided
        };
        // Send data indicating no feedback or rating was submitted
        Network(false).postData("orderFeedback", data, context).then((value) {
          if (value != "") {
            if (value["code"] == "201") {
              setState(() {
                pro.Orders.last.rating = -1; // Reset the rating
              });
            }
          }
        });
      }
      // Reset the modal state after it closes
      setState(() {
        isExpanded = false; // Collapse the modal
        feedbackController.clear(); // Clear the feedback input
        selectedRating = 0; // Reset the rating
      });
    });
  }
}
