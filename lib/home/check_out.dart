// Import necessary packages and libraries
import 'package:animate_do/animate_do.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/successScreen.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as map;
import '../Landing/splash_screen.dart';
import 'package:dllylas/map/map_screen.dart';
import 'package:dllylas/model/product_model/product_model.dart';
import 'package:dllylas/model/schedule_model/schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:dllylas/Config/property.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Config/athome_functions.dart';
import '../main.dart';
import 'nav_switch.dart';

/// A [CheckOut] widget represents the checkout screen where users can finalize their order.
///
/// The total amount for the order is passed as an argument and displayed on the screen.
class CheckOut extends StatefulWidget {
  int total = 0; // The total amount for the checkout
  CheckOut(this.total, {super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  // Controls the scrollable widget's position
  final ScrollController _scrollController = ScrollController();
  // Manages the pages of a page view
  final PageController controller = PageController(initialPage: 0);
  // Controller for the note input field
  TextEditingController NoteController = TextEditingController();
  // Controller for the voucher code input field
  TextEditingController voucherCode = TextEditingController();
  // A flag to indicate if the checkout process is in progress
  bool waitingcheckout = false;
  // Mapbox map controller for handling map actions
  map.MapboxMap? _mapController;
  // Stores the order code generated for the order
  String orderCode = "";
  // The type of delivery selected by the user (1 by default)
  int deleveryType = 1;
  String VoucherE = ""; // Stores the voucher code entered by the user
  int VoucherID = -1; // The ID of the voucher applied
  int VoucherAmount = 0; // The amount of discount from the voucher
  // A flag to indicate if the app is waiting for a process to complete
  bool waiting = false;
  // A list of days of the week used for scheduling
  List<String> listOfDays = [
    "Select Day",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  late DateTime selectedDate; // The date selected by the user
  late DateTime Datetimenow; // Stores the current date and time from the server
  String selectedTime = ""; // The time selected by the user
  String selectedDateorder = ""; // The formatted date for the order
  bool Etime = false; // A flag to indicate if a specific time is selected
  bool showTime = false; // A flag to show the time selection widget
  bool showDate = false; // A flag to show the date selection widget
  bool isSchedule = false; // A flag to indicate if the order is scheduled
  int currentDateSelectedIndex = 0; // The index of the selected date
  int currentTimeSelectedIndex = -1; // The index of the selected time

  @override
  void initState() {
    // Fetch the current server time and update the UI to show the date selection once the time is retrieved
    getServerTime().then((value) {
      Datetimenow = DateTime.parse(value);
      setState(() {
        showDate = true;
      });
    });

    super.initState();
  }

  /// Scrolls to a specific item in the list based on the index provided.
  ///
  /// The function calculates the position in the scroll view and smoothly scrolls to it.
  void _scrollToSelectedItem(int index) {
    // Calculate the position to scroll to; assuming each item has a height of 65
    double position = index * 65.0;
    _scrollController.animateTo(
      position,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController
        .dispose(); // Dispose of the scroll controller to free resources
    super.dispose();
  }

  /// The function uses a `Directionality` widget to support both left-to-right (LTR) and
  /// right-to-left (RTL) text directions based on the selected language. It sets up
  /// the `Scaffold` for the checkout page with an `AppBar` that includes a back button.
  @override
  Widget build(BuildContext context) {
    // Obtain the cart provider without listening to updates (useful for actions like adding/removing items)
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    // Obtain the product provider with automatic updates (useful for displaying dynamic product info)
    final productrovider = Provider.of<productProvider>(context, listen: true);

    // The directionality widget controls text flow based on the selected language (LTR for "en" or RTL otherwise)
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFE5E5E5),
        
        appBar: AppBar(
          title: Text(
            "Checkout"
                .tr, // Display the translated "Checkout" title in the AppBar
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(
                  context); // Navigate back to the previous screen when the back button is pressed
            },
            icon: const Icon(
              Icons.arrow_back_ios, // Back arrow icon
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// The map is embedded inside a `SizedBox` to control its height and width, and
                  /// annotations such as a marker are added to the map at the user's default location.
                  SizedBox(
                    height: getHeight(
                        context, 15), // Adjusts the height of the map widget
                    width: getWidth(
                        context, 100), // Adjusts the width of the map widget
                    child: map.MapWidget(
                      cameraOptions: map.CameraOptions(
                        // Center the camera on the default location using latitude and longitude
                        center: map.Point(
                          coordinates: map.Position(
                              productrovider
                                  .getonelocationById(
                                      productrovider.defultlocation)
                                  .longitude!,
                              productrovider
                                  .getonelocationById(
                                      productrovider.defultlocation)
                                  .latitude!),
                        ),
                        zoom: 17.0, // Set the initial zoom level of the map
                      ),
                      key: const ValueKey(
                          "mapWidget"), // Unique key for the map widget

                      // Handle tap events on the map (currently does nothing)
                      onTapListener: (coordinate) {},

                      // Initialize the map and add a marker at the default location
                      onMapCreated: (controller) {
                        _mapController = controller;

                        // Create an annotation (marker) manager for the map
                        controller.annotations
                            .createPointAnnotationManager()
                            .then((pointAnnotationManager) async {
                          // Load the marker image from assets
                          final ByteData bytes =
                              await rootBundle.load('assets/images/PIN@2x.png');
                          final Uint8List list = bytes.buffer.asUint8List();

                          // Prepare options for adding a point annotation (marker) at the default location
                          var options = <map.PointAnnotationOptions>[];
                          options.add(
                            map.PointAnnotationOptions(
                              geometry: map.Point(
                                coordinates: map.Position(
                                  productrovider
                                      .getonelocationById(
                                          productrovider.defultlocation)
                                      .longitude!,
                                  productrovider
                                      .getonelocationById(
                                          productrovider.defultlocation)
                                      .latitude!,
                                ),
                              ),
                              image: list, // Set the marker image
                              iconSize: 0.5, // Set the size of the marker icon
                            ),
                          );

                          // Add the marker to the map
                          pointAnnotationManager.createMulti(options);
                        });

                        // Disable certain map gestures for a more controlled experience
                        controller.gestures.updateSettings(
                          map.GesturesSettings(
                            rotateEnabled: false, // Disable map rotation
                            quickZoomEnabled: false, // Disable quick zooming
                            doubleTapToZoomInEnabled:
                                false, // Disable zooming in on double tap
                            doubleTouchToZoomOutEnabled:
                                false, // Disable zooming out on double touch
                            pinchToZoomEnabled: false, // Disable pinch to zoom
                            scrollDecelerationEnabled:
                                false, // Disable deceleration after scrolling
                            scrollEnabled: false, // Disable map scrolling
                            focalPoint: map.ScreenCoordinate(
                              // Set the focal point of the map to the default location
                              x: productrovider
                                  .getonelocationById(
                                      productrovider.defultlocation)
                                  .latitude!,
                              y: productrovider
                                  .getonelocationById(
                                      productrovider.defultlocation)
                                  .longitude!,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  /// The widget includes a header with delivery options, a divider, and the current selected location's details
                  /// (if available). It also handles the selection and addition of delivery locations.
                  Container(
                    color: mainColorWhite, // Background color of the container
                    child: Padding(
                      padding: const EdgeInsets.all(
                          16.0), // Padding around the content
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Aligns children to the start of the column
                        children: [
                          // Row for "Delivery to" text and "Change" or "Add location" button
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Space between the text and button
                            children: [
                              Text(
                                'Delivery to'
                                    .tr, // Translated "Delivery to" text
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              // Button to either add a new location or change the current location
                              GestureDetector(
                                onTap: productrovider.location.isEmpty
                                    ? () async {
                                        // Request location permission if no location is selected
                                        geolocator.LocationPermission
                                            permission = await geolocator
                                                .Geolocator.requestPermission();
                                        if (permission ==
                                            geolocator
                                                .LocationPermission.denied) {
                                          // Handle case where the user denied access to their location
                                        }
                                        // Navigate to map screen to add a new location
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Map_screen()),
                                        );
                                      }
                                    : () {
                                        // Show a modal bottom sheet to change the current location
                                        showModalBottomSheet(
                                          isScrollControlled:
                                              true, // Allow scrolling in the modal
                                          context: context,
                                          backgroundColor: Colors
                                              .white, // Background color of the modal
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadiusDirectional.only(
                                              topEnd: Radius.circular(25),
                                              topStart: Radius.circular(25),
                                            ),
                                          ),
                                          builder: (context) => Directionality(
                                            textDirection: lang == "en"
                                                ? TextDirection.ltr
                                                : TextDirection.rtl,
                                            child: StatefulBuilder(builder:
                                                (BuildContext context,
                                                    StateSetter mystate) {
                                              return Stack(
                                                alignment: Alignment
                                                    .topCenter, // Aligns children to the top center
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        getWidth(context, 100),
                                                    height:
                                                        getHeight(context, 50),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        // Text prompting the user to select an address
                                                        Text(
                                                          "Please select Address"
                                                              .tr,
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            color:
                                                                mainColorBlack,
                                                            fontFamily:
                                                                mainFontbold,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        // List of available locations for the user to select
                                                        Container(
                                                          width: getWidth(
                                                              context, 100),
                                                          height: getHeight(
                                                              context, 35),
                                                          child:
                                                              ListView.builder(
                                                            controller:
                                                                _scrollController,
                                                            itemCount:
                                                                productrovider
                                                                    .location
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              final location =
                                                                  productrovider
                                                                      .location
                                                                      .reversed
                                                                      .toList()[index];
                                                              if (location.id ==
                                                                  productrovider
                                                                      .defultlocation) {
                                                                _scrollToSelectedItem(
                                                                    index); // Scroll to the selected item
                                                              }
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: mainColorGrey
                                                                          .withOpacity(
                                                                              0.5),
                                                                      width: 1,
                                                                      style: BorderStyle
                                                                          .solid,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      ListTile(
                                                                    onTap: () {
                                                                      if (productrovider
                                                                              .defultlocation !=
                                                                          location
                                                                              .id!) {
                                                                        // Update the map and set the new default location
                                                                        _mapController
                                                                            ?.annotations
                                                                            .createPointAnnotationManager()
                                                                            .then((pointAnnotationManager) async {
                                                                          final ByteData
                                                                              bytes =
                                                                              await rootBundle.load('assets/images/PIN@2x.png');
                                                                          final Uint8List
                                                                              list =
                                                                              bytes.buffer.asUint8List();
                                                                          var options =
                                                                              <map.PointAnnotationOptions>[];
                                                                          options
                                                                              .add(
                                                                            map.PointAnnotationOptions(
                                                                              geometry: map.Point(
                                                                                coordinates: map.Position(location.longitude!, location.latitude!),
                                                                              ),
                                                                              image: list,
                                                                              iconSize: 0.5,
                                                                            ),
                                                                          );
                                                                          pointAnnotationManager
                                                                              .createMulti(options);
                                                                        });
                                                                        // Fly to the new location on the map
                                                                        _mapController!
                                                                            .flyTo(
                                                                          map.CameraOptions(
                                                                            center:
                                                                                map.Point(
                                                                              coordinates: map.Position(location.longitude!, location.latitude!),
                                                                            ),
                                                                            zoom:
                                                                                18,
                                                                            bearing:
                                                                                0,
                                                                            pitch:
                                                                                15,
                                                                          ),
                                                                          map.MapAnimationOptions(
                                                                            duration:
                                                                                3000,
                                                                            startDelay:
                                                                                0,
                                                                          ),
                                                                        );
                                                                        mystate(
                                                                            () {
                                                                          productrovider
                                                                              .setdefultlocation(location.id!);
                                                                        });
                                                                        Navigator.pop(
                                                                            context);
                                                                      }
                                                                    },
                                                                    // Display the location name and area
                                                                    title: Text(
                                                                      location
                                                                          .name!,
                                                                      maxLines:
                                                                          1,
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            mainFontbold,
                                                                        color:
                                                                            mainColorBlack,
                                                                        fontSize:
                                                                            16,
                                                                      ),
                                                                    ),
                                                                    subtitle:
                                                                        Text(
                                                                      location
                                                                          .area!,
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            mainFontnormal,
                                                                        color:
                                                                            mainColorGrey,
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                    ),
                                                                    trailing:
                                                                        Icon(
                                                                      productrovider.defultlocation ==
                                                                              location
                                                                                  .id!
                                                                          ? Icons
                                                                              .check_box
                                                                          : Icons
                                                                              .check_box_outline_blank,
                                                                      color:
                                                                          mainColorGrey,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        // Button to add a new location
                                                        TextButton(
                                                          onPressed: () async {
                                                            geolocator
                                                                .LocationPermission
                                                                permission =
                                                                await geolocator
                                                                        .Geolocator
                                                                    .requestPermission();
                                                            if (permission ==
                                                                geolocator
                                                                    .LocationPermission
                                                                    .denied) {
                                                              // Handle case where the user denied access to their location
                                                            }
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const Map_screen()),
                                                            );
                                                          },
                                                          style: TextButton
                                                              .styleFrom(
                                                            backgroundColor: productrovider
                                                                        .location
                                                                        .length >
                                                                    0
                                                                ? mainColorGrey
                                                                : mainColorRed,
                                                            fixedSize: Size(
                                                                getWidth(
                                                                    context,
                                                                    70),
                                                                getHeight(
                                                                    context,
                                                                    5)),
                                                          ),
                                                          child: Text(
                                                            "Add location".tr,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Decorative handle at the top of the modal sheet
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Container(
                                                      width: 65,
                                                      height: 5,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: mainColorGrey,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                          ),
                                        ).then((value) {});
                                      },
                                child: Text(
                                  // Text prompting the user to add or change the location
                                  productrovider.location.isEmpty
                                      ? "Add location".tr
                                      : 'Change'.tr,
                                  style: TextStyle(
                                    color: mainColorRed,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child:
                                Divider(), // Divider separating the location options from the details
                          ),
                          // Display location details if a location has been selected
                          productrovider.location.isEmpty
                              ? SizedBox() // Display nothing if no location is selected
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color:
                                          mainColorRed, // Red location pin icon
                                    ),
                                    SizedBox(width: 8),
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                        ),
                                        children: <TextSpan>[
                                          // Display the area and location details
                                          TextSpan(
                                            text: productrovider
                                                    .getonelocationById(
                                                        productrovider
                                                            .defultlocation!)
                                                    .area! +
                                                "\n",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: mainFontnormal),
                                          ),
                                          TextSpan(
                                            text: productrovider
                                                    .getonelocationById(
                                                        productrovider
                                                            .defultlocation!)
                                                    .name! +
                                                " : " +
                                                productrovider
                                                    .getonelocationById(
                                                        productrovider
                                                            .defultlocation!)
                                                    .number! +
                                                "\n",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: mainFontnormal),
                                          ),
                                          TextSpan(
                                            text: productrovider
                                                .getonelocationById(
                                                    productrovider
                                                        .defultlocation!)
                                                .phone!,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: mainFontnormal),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),

                  // Spacer to create vertical space
                  SizedBox(height: getHeight(context, 1)),

                  // container for Delivery Type section
                  Container(
                    color: mainColorWhite, // Background color of the container
                    child: Padding(
                      padding: const EdgeInsets.all(
                          16.0), // Padding around the child widget
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Align children to the start of the column
                        children: [
                          Text(
                            "Delivery Type"
                                .tr, // Text for the delivery type label, translated
                            style: TextStyle(
                              fontWeight: FontWeight.bold, // Bold text
                              color: mainColorBlack, // Text color
                              fontFamily: mainFontnormal, // Font family
                              fontSize: 16, // Font size
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal:
                                    16.0), // Horizontal padding for the divider
                            child:
                                Divider(), // Divider widget for visual separation
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Space between row children
                            children: [
                              Text(
                                "Delevery now"
                                    .tr, // Text for "Delivery now" option, translated
                                style: TextStyle(
                                  color: mainColorBlack, // Text color
                                  fontFamily: mainFontnormal, // Font family
                                  fontSize: 14, // Font size
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // Update state when "Delivery now" is selected
                                    deleveryType =
                                        1; // Set delivery type to "now"
                                    currentDateSelectedIndex =
                                        0; // Reset date index
                                    currentTimeSelectedIndex =
                                        -1; // Reset time index
                                    showTime = false; // Hide time options
                                    selectedDate = DateTime
                                        .now(); // Set selected date to now
                                    selectedDateorder =
                                        ""; // Clear selected date order
                                    selectedTime = ""; // Clear selected time
                                    isSchedule = false; // Reset schedule flag
                                  });
                                },
                                child: Icon(
                                  deleveryType == 1
                                      ? Icons
                                          .check_box // Checked icon if deliveryType is "now"
                                      : Icons
                                          .check_box_outline_blank, // Unchecked icon otherwise
                                  color: mainColorGrey, // Icon color
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10, // Spacer height
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Space between row children
                            children: [
                              Text(
                                "Delevery schedule"
                                    .tr, // Text for "Delivery schedule" option, translated
                                style: TextStyle(
                                  color: mainColorBlack, // Text color
                                  fontFamily: mainFontnormal, // Font family
                                  fontSize: 14, // Font size
                                ),
                              ),
                              GestureDetector(
                                onTap:
                                    !showDate // Disable if date selection is not available
                                        ? null
                                        : () {
                                            setState(() {
                                              deleveryType =
                                                  2; // Set delivery type to "schedule"
                                            });
                                            showModalBottomSheet(
                                              isScrollControlled:
                                                  true, // Allow scrolling in the bottom sheet
                                              context: context,
                                              backgroundColor: Colors
                                                  .white, // Bottom sheet background color
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .only(
                                                  topEnd: Radius.circular(
                                                      25), // Rounded top end corner
                                                  topStart: Radius.circular(
                                                      25), // Rounded top start corner
                                                ),
                                              ),
                                              builder: (context) =>
                                                  Directionality(
                                                textDirection: lang == "en"
                                                    ? TextDirection
                                                        .ltr // Left-to-right text direction for English
                                                    : TextDirection
                                                        .rtl, // Right-to-left text direction for other languages
                                                child: Container(
                                                  padding: EdgeInsetsDirectional
                                                      .only(
                                                    start: 20,
                                                    end: 20,
                                                    bottom: 30,
                                                    top:
                                                        8, // Padding inside the modal
                                                  ),
                                                  child: StatefulBuilder(
                                                    builder: (BuildContext
                                                            context,
                                                        StateSetter mystate) {
                                                      return Column(
                                                        mainAxisSize: MainAxisSize
                                                            .min, // Minimize column height
                                                        children: [
                                                          SizedBox(
                                                            height: getHeight(
                                                                context,
                                                                4), // Spacer height
                                                          ),
                                                          FadeInUp(
                                                            delay: const Duration(
                                                                milliseconds:
                                                                    200), // Animation delay
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start, // Align children to the start
                                                              children: [
                                                                Center(
                                                                  child:
                                                                      Container(
                                                                    width: getWidth(
                                                                        context,
                                                                        100), // Container width
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15), // Rounded corners
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: deleveryType ==
                                                                                1
                                                                            ? mainColorBlack.withOpacity(0.2) // Light border if deliveryType is "now"
                                                                            : mainColorGrey.withOpacity(0.5), // Darker border otherwise
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child: DropdownButtonFormField<
                                                                          int>(
                                                                        decoration:
                                                                            InputDecoration(
                                                                          border:
                                                                              UnderlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide.none, // No underline
                                                                          ),
                                                                        ),
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .calendar_today_outlined,
                                                                          color: deleveryType == 1
                                                                              ? mainColorBlack.withOpacity(0.2) // Icon color if deliveryType is "now"
                                                                              : mainColorGrey.withOpacity(0.5), // Icon color otherwise
                                                                        ),
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 15), // Padding inside dropdown
                                                                        value:
                                                                            currentDateSelectedIndex, // Currently selected date index
                                                                        onChanged:
                                                                            (newIndex) {
                                                                          mystate(
                                                                              () {
                                                                            currentTimeSelectedIndex =
                                                                                -1; // Reset time index
                                                                            currentDateSelectedIndex =
                                                                                newIndex!; // Update date index
                                                                            if (newIndex ==
                                                                                0) {
                                                                              mystate(() {
                                                                                showTime = false; // Hide time options if today is selected
                                                                              });
                                                                            } else {
                                                                              selectedDateorder = Datetimenow.add(Duration(days: newIndex - 1)).toString().substring(0, 10); // Set selected date order
                                                                              selectedDate = Datetimenow.add(Duration(days: newIndex - 1)); // Set selected date
                                                                              mystate(() {
                                                                                selectedTime = ""; // Clear selected time
                                                                                Etime = false; // Clear time error flag
                                                                                showTime = true; // Show time options
                                                                              });
                                                                            }
                                                                          });
                                                                        },
                                                                        items: List
                                                                            .generate(
                                                                          listOfDays
                                                                              .length, // Generate dropdown items based on days list
                                                                          (index) {
                                                                            bool
                                                                                hasAvailableSchedule =
                                                                                productrovider.scheduleData.where((time) => time.weekId == getWeekdayName(Datetimenow.add(Duration(days: index - 1)).weekday) && Datetimenow.add(Duration(hours: 1)).isBefore(DateTime.parse(Datetimenow.add(Duration(days: index - 1)).toString().substring(0, 10) + " " + time.from.toString()))).isNotEmpty; // Check if there is an available schedule
                                                                            return DropdownMenuItem<int>(
                                                                              enabled: hasAvailableSchedule, // Enable item only if schedule is available
                                                                              value: index,
                                                                              child: index == 0
                                                                                  ? Text(
                                                                                      listOfDays[index].tr, // Text for today
                                                                                      style: TextStyle(
                                                                                        fontFamily: mainFontnormal, // Font family
                                                                                        color: hasAvailableSchedule
                                                                                            ? mainColorBlack // Text color if schedule is available
                                                                                            : mainColorBlack.withOpacity(0.4), // Dimmed text color otherwise
                                                                                      ),
                                                                                    )
                                                                                  : Row(
                                                                                      children: [
                                                                                        Text(
                                                                                          Datetimenow.add(Duration(days: index - 1)).toString().substring(0, 10), // Date text
                                                                                          style: TextStyle(
                                                                                            fontFamily: mainFontnormal, // Font family
                                                                                            color: hasAvailableSchedule
                                                                                                ? mainColorBlack // Text color if schedule is available
                                                                                                : mainColorBlack.withOpacity(0.4), // Dimmed text color otherwise
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(width: 15), // Spacer
                                                                                        Text(
                                                                                          Datetimenow.add(Duration(days: index - 1)).day == Datetimenow.day
                                                                                              ? "Today".tr // Text for today
                                                                                              : getWeekdayName(Datetimenow.add(Duration(days: index - 1)).weekday).tr, // Weekday name text
                                                                                          style: TextStyle(
                                                                                            fontFamily: mainFontnormal, // Font family
                                                                                            color: hasAvailableSchedule
                                                                                                ? mainColorBlack // Text color if schedule is available
                                                                                                : mainColorBlack.withOpacity(0.4), // Dimmed text color otherwise
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height: getHeight(
                                                                        context,
                                                                        2)), // Spacer height
                                                                !showTime
                                                                    ? Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            top:
                                                                                20.0), // Padding for message
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "Select Day to show time deleverys".tr, // Message for no time selection
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : SizedBox(
                                                                        height: getHeight(
                                                                            context,
                                                                            20), // Height of the grid view
                                                                        child: GridView
                                                                            .builder(
                                                                          shrinkWrap:
                                                                              true, // Shrink to fit content
                                                                          gridDelegate:
                                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                                            crossAxisCount:
                                                                                2, // Two columns in grid
                                                                            mainAxisSpacing:
                                                                                10, // Space between rows
                                                                            crossAxisSpacing:
                                                                                10, // Space between columns
                                                                            childAspectRatio:
                                                                                4, // Aspect ratio of each item
                                                                          ),
                                                                          itemCount: productrovider
                                                                              .scheduleData
                                                                              .where((time) => time.weekId == getWeekdayName(selectedDate.weekday) && Datetimenow.add(Duration(hours: 1)).isBefore(DateTime.parse(selectedDate.toString().substring(0, 10) + " " + time.from.toString())))
                                                                              .length, // Number of available time slots
                                                                          scrollDirection:
                                                                              Axis.vertical, // Vertical scroll direction
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            ScheduleModel
                                                                                time =
                                                                                productrovider.scheduleData.where((time2) => time2.weekId == getWeekdayName(selectedDate.weekday) && Datetimenow.add(Duration(hours: 1)).isBefore(DateTime.parse(selectedDate.toString().substring(0, 10) + " " + time2.from.toString()))).toList()[index]; // Get time slot

                                                                            return OutlinedButton(
                                                                              onPressed: () {
                                                                                mystate(() {
                                                                                  Etime = false; // Clear time error flag
                                                                                  selectedTime = time.from.toString() + "||" + time.to.toString(); // Set selected time
                                                                                  currentTimeSelectedIndex = index; // Update time index
                                                                                });
                                                                              },
                                                                              style: TextButton.styleFrom(
                                                                                fixedSize: Size(
                                                                                    getWidth(context, 70), // Button width
                                                                                    getHeight(context, 5)), // Button height
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(10), // Rounded button corners
                                                                                ),
                                                                                backgroundColor: currentTimeSelectedIndex == index
                                                                                    ? mainColorGrey // Highlight background for selected time
                                                                                    : mainColorWhite, // Default background color
                                                                              ),
                                                                              child: Text(
                                                                                convertTo12HourFormat(time.from.toString()) + " - " + convertTo12HourFormat(time.to.toString()), // Time range text
                                                                                style: TextStyle(
                                                                                  fontFamily: mainFontnormal, // Font family
                                                                                  fontSize: 12, // Font size
                                                                                  color: currentTimeSelectedIndex == index
                                                                                      ? mainColorWhite // Text color for selected time
                                                                                      : mainColorBlack, // Default text color
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                Etime
                                                                    ? Center(
                                                                        child:
                                                                            Text(
                                                                          "Select the Time please"
                                                                              .tr, // Error message if no time selected
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                mainColorRed, // Error color
                                                                            fontFamily:
                                                                                mainFontnormal, // Font family
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : SizedBox(), // Spacer if no error
                                                                SizedBox(
                                                                    height: getHeight(
                                                                        context,
                                                                        2)), // Spacer height
                                                                Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal: getWidth(
                                                                          context,
                                                                          4)), // Horizontal padding for button
                                                                  child:
                                                                      TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      if (selectedTime
                                                                          .isEmpty) {
                                                                        mystate(
                                                                            () {
                                                                          Etime =
                                                                              true; // Show error if no time selected
                                                                        });
                                                                      } else {
                                                                        mystate(
                                                                            () {
                                                                          isSchedule =
                                                                              true; // Set schedule flag
                                                                        });
                                                                        Navigator.pop(
                                                                            context); // Close the modal
                                                                      }
                                                                    },
                                                                    style: TextButton
                                                                        .styleFrom(
                                                                      fixedSize: Size(
                                                                          getWidth(context, 85), // Button width
                                                                          getHeight(context, 6)), // Button height
                                                                    ),
                                                                    child: Text(
                                                                      "Select"
                                                                          .tr, // Button text, translated
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ).then((value) {
                                              if (isSchedule) {
                                                setState(() {
                                                  isSchedule =
                                                      true; // Set schedule flag if selected
                                                });
                                              } else {
                                                setState(() {
                                                  isSchedule =
                                                      false; // Reset schedule flag
                                                  currentDateSelectedIndex =
                                                      0; // Reset date index
                                                  currentTimeSelectedIndex =
                                                      -1; // Reset time index
                                                  showTime =
                                                      false; // Hide time options
                                                  deleveryType =
                                                      1; // Reset delivery type to "now"
                                                  selectedDate =
                                                      Datetimenow; // Set current date
                                                  selectedDateorder =
                                                      ""; // Clear selected date order
                                                  selectedTime =
                                                      ""; // Clear selected time
                                                });
                                              }
                                            });
                                          },
                                child: Icon(
                                  deleveryType == 1
                                      ? Icons
                                          .check_box_outline_blank // Display unchecked box if deliveryType is "schedule"
                                      : Icons
                                          .check_box, // Display checked box otherwise
                                  color: mainColorGrey, // Icon color
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Spacer to create vertical space
                  SizedBox(height: getHeight(context, 1)),

                  // container for voucher code section
                  Container(
                    color: mainColorWhite,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row containing the voucher label and 'Select' button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Label for voucher code
                              Text(
                                'Voucher Code'.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              // Button to open voucher selection modal
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusDirectional.only(
                                        topEnd: Radius.circular(25),
                                        topStart: Radius.circular(25),
                                      ),
                                    ),
                                    builder: (context) => Directionality(
                                      textDirection: lang == "en"
                                          ? TextDirection.ltr
                                          : TextDirection.rtl,
                                      child: StatefulBuilder(builder:
                                          (BuildContext context,
                                              StateSetter mystate) {
                                        return Stack(
                                          alignment: Alignment.topCenter,
                                          children: [
                                            // Container for the modal content
                                            Container(
                                              width: getWidth(context, 100),
                                              height: getHeight(context, 40),
                                              child: Column(
                                                children: [
                                                  const SizedBox(height: 30),
                                                  // Header text in the modal
                                                  Text(
                                                    "Please select Your Voucher"
                                                        .tr,
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: mainColorBlack,
                                                      fontFamily: mainFontbold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  // ListView to display unused vouchers
                                                  Expanded(
                                                    child: ListView.builder(
                                                      itemCount: productrovider
                                                          .unusedVouchers
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        final voucher =
                                                            productrovider
                                                                    .unusedVouchers[
                                                                index];

                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              border:
                                                                  Border.all(
                                                                color: mainColorGrey
                                                                    .withOpacity(
                                                                        0.5),
                                                                width: 1,
                                                                style:
                                                                    BorderStyle
                                                                        .solid,
                                                              ),
                                                            ),
                                                            child: ListTile(
                                                              title: Text(
                                                                voucher.code!,
                                                                maxLines: 1,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      mainFontbold,
                                                                  color:
                                                                      mainColorBlack,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                              subtitle: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  // Display discount amount
                                                                  Text(
                                                                    addCommasToPrice(
                                                                        voucher
                                                                            .discountAmount!),
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          mainFontnormal,
                                                                      color: Colors
                                                                          .green,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                  // Display minimum order requirement if applicable
                                                                  widget.total <
                                                                          voucher
                                                                              .mimimumAmount!
                                                                      ? Text(
                                                                          "must order by".tr +
                                                                              ": " +
                                                                              addCommasToPrice(voucher.mimimumAmount!),
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                mainFontnormal,
                                                                            color:
                                                                                mainColorRed,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        )
                                                                      : SizedBox(),
                                                                ],
                                                              ),
                                                              trailing:
                                                                  SizedBox(
                                                                width: getWidth(
                                                                    context,
                                                                    15),
                                                                height:
                                                                    getHeight(
                                                                        context,
                                                                        4),
                                                                child:
                                                                    TextButton(
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    foregroundColor: widget.total >=
                                                                            voucher.mimimumAmount!
                                                                        ? mainColorWhite
                                                                        : mainColorBlack,
                                                                    backgroundColor: widget.total >=
                                                                            voucher
                                                                                .mimimumAmount!
                                                                        ? mainColorGrey
                                                                        : Colors
                                                                            .grey[300],
                                                                  ),
                                                                  onPressed: widget
                                                                              .total >=
                                                                          voucher
                                                                              .mimimumAmount!
                                                                      ? () {
                                                                          mystate(
                                                                              () {
                                                                            VoucherE =
                                                                                "";
                                                                            voucherCode.text =
                                                                                voucher.code!;
                                                                          });

                                                                          Navigator.pop(
                                                                              context);
                                                                        }
                                                                      : null,
                                                                  child: Text(
                                                                    "Apply".tr,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          mainFontnormal,
                                                                      fontSize:
                                                                          10,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Indicator at the top of the modal
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Container(
                                                width: 65,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: mainColorGrey,
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      }),
                                    ),
                                  ).then((value) {
                                    setState(() {});
                                    FocusScope.of(context).unfocus();
                                  });
                                },
                                child: Text(
                                  'Select'.tr,
                                  style: TextStyle(
                                    color: mainColorRed,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Divider to separate the label and input field
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Divider(),
                          ),
                          // TextField for entering voucher code
                          TextField(
                            controller: voucherCode,
                            onChanged: (value) {
                              setState(() {
                                VoucherE = "";
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.confirmation_num_outlined),
                              hintText: "Voucher".tr,
                              hintStyle: TextStyle(
                                color: mainColorBlack.withOpacity(0.5),
                                fontSize: 14,
                                fontFamily: mainFontnormal,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: mainColorGrey.withOpacity(0.5),
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: mainColorGrey.withOpacity(0.5),
                                  width: 1.0,
                                ),
                              ),
                              suffixIcon: waiting
                                  ? Container(
                                      width: getHeight(context, 3),
                                      height: getHeight(context, 3),
                                      child: waitingWiget(context))
                                  : TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                      ),
                                      child: VoucherID != -1
                                          ? Icon(
                                              Icons.check,
                                              color: green,
                                            )
                                          : Text(
                                              "Submit".tr,
                                              style: TextStyle(
                                                color: voucherCode.text.isEmpty
                                                    ? mainColorGrey
                                                        .withOpacity(0.5)
                                                    : mainColorGrey,
                                              ),
                                            ),
                                      onPressed: voucherCode.text.isEmpty
                                          ? () {}
                                          : () {
                                              setState(() {
                                                waiting = true;
                                              });
                                              var data = {
                                                "id": userdata["id"],
                                                "amount": widget.total,
                                                "code": voucherCode.text,
                                              };
                                              Network(false)
                                                  .postData("checkvoucher",
                                                      data, context)
                                                  .then((value) {
                                                if (value != "") {
                                                  if (value["code"] == "200") {
                                                    // Handle voucher validation responses
                                                    if (value["data"] ==
                                                        "not_found") {
                                                      setState(() {
                                                        waiting = false;
                                                        VoucherE =
                                                            "the voucher code not found";
                                                        VoucherID = -1;
                                                        VoucherAmount = 0;
                                                      });
                                                    } else if (value["data"] ==
                                                        "expired") {
                                                      setState(() {
                                                        waiting = false;
                                                        VoucherE =
                                                            "the voucher code is expired";
                                                        VoucherID = -1;
                                                        VoucherAmount = 0;
                                                      });
                                                    } else if (value["data"] ==
                                                        "minimum") {
                                                      setState(() {
                                                        waiting = false;
                                                        VoucherE =
                                                            "you must order by " +
                                                                addCommasToPrice(
                                                                    value[
                                                                        "money"]);
                                                        VoucherID = -1;
                                                        VoucherAmount = 0;
                                                      });
                                                    } else if (value["data"] ==
                                                        "limit") {
                                                      setState(() {
                                                        waiting = false;
                                                        VoucherE =
                                                            "the voucher code is out of limit";
                                                        VoucherID = -1;
                                                        VoucherAmount = 0;
                                                      });
                                                    } else if (value["data"] ==
                                                        "used") {
                                                      setState(() {
                                                        waiting = false;
                                                        VoucherE =
                                                            "the voucher code was used before";
                                                        VoucherID = -1;
                                                        VoucherAmount = 0;
                                                      });
                                                    } else if (value["data"] ==
                                                        "success") {
                                                      setState(() {
                                                        waiting = false;
                                                        VoucherID = value["id"];
                                                        VoucherAmount =
                                                            value["amount"];
                                                      });
                                                      productrovider
                                                          .notifyListeners();
                                                    }
                                                  } else {
                                                    setState(() {
                                                      waiting = false;
                                                    });
                                                  }
                                                } else {
                                                  setState(() {
                                                    waiting = false;
                                                  });
                                                }
                                              });
                                            },
                                    ),
                            ),
                          ),
                          // Spacer for error message
                          SizedBox(
                            height: VoucherE.isNotEmpty ? 5 : 0,
                          ),
                          // Error message display
                          VoucherE.isNotEmpty
                              ? Text(
                                  VoucherE,
                                  style: TextStyle(
                                    fontFamily: mainFontnormal,
                                    color: mainColorRed,
                                    fontSize: 14,
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ),

                  // Spacer to create vertical space
                  SizedBox(height: getHeight(context, 1)),

                  // Container for adding a note section
                  Container(
                    color: mainColorWhite,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header text for note input
                          Text(
                            "Add your note".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: mainColorBlack,
                              fontFamily: mainFontbold,
                              fontSize: 16,
                            ),
                          ),
                          // Divider to separate header from text field
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Divider(),
                          ),
                          // Multi-line text field for user to add notes
                          TextFormField(
                            maxLines: null, // Allows for multi-line input
                            controller:
                                NoteController, // Controller for managing text input
                            cursorColor: mainColorGrey,
                            keyboardType:
                                TextInputType.text, // Specifies text input type
                            onChanged: (value) {},
                            validator: (value) {
                              return null; // No validation logic for this field
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: mainColorGrey.withOpacity(0.5),
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: mainColorGrey.withOpacity(0.5),
                                  width: 1.0,
                                ),
                              ),
                              hintText: "Note".tr,
                              hintStyle: TextStyle(
                                color: mainColorBlack.withOpacity(0.5),
                                fontSize: 14,
                                fontFamily: mainFontnormal,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Spacer to create vertical space
                  SizedBox(height: getHeight(context, 1)),

                  // Container for payment details section
                  Container(
                    color: mainColorWhite,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header for payment details section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payment details".tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          // Divider to separate header from payment details
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Divider(),
                          ),
                          // Row for displaying sub-total
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sub Total".tr,
                                style: TextStyle(
                                  color: mainColorBlack,
                                  fontFamily: mainFontnormal,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                textAlign: TextAlign.end,
                                addCommasToPrice(widget.total),
                                style: TextStyle(
                                  color: mainColorBlack,
                                  fontFamily: mainFontnormal,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          // Spacer for voucher details if applicable
                          SizedBox(
                            height: VoucherID != -1 ? 10 : 0,
                          ),
                          // Conditionally display voucher amount if a voucher is applied
                          VoucherID != -1
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Voucher Amount".tr,
                                      style: TextStyle(
                                        color: mainColorBlack,
                                        fontFamily: mainFontnormal,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      textAlign: TextAlign.end,
                                      addCommasToPrice(-VoucherAmount),
                                      style: TextStyle(
                                        color: mainColorRed,
                                        fontFamily: mainFontnormal,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 10,
                          ),
                          // Row for displaying delivery cost
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery Cost".tr,
                                style: TextStyle(
                                  color: mainColorBlack,
                                  fontFamily: mainFontnormal,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                textAlign: TextAlign.end,
                                !isSchedule
                                    ? productrovider.deleveryCost == 0
                                        ? "Free Delivery".tr
                                        : addCommasToPrice(
                                            productrovider.deleveryCost)
                                    : "Free Delivery".tr,
                                style: TextStyle(
                                  color: deleveryType == 1
                                      ? mainColorBlack
                                      : Colors.green,
                                  fontFamily: mainFontnormal,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Row for displaying payment method
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payment Method".tr,
                                style: TextStyle(
                                  color: mainColorBlack,
                                  fontFamily: mainFontnormal,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                textAlign: TextAlign.end,
                                "Cash".tr,
                                style: TextStyle(
                                  color: mainColorBlack,
                                  fontFamily: mainFontnormal,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          // Divider to separate payment details from total
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Divider(),
                          ),
                          // Row for displaying total amount
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                textAlign: TextAlign.start,
                                "Total".tr,
                                style: TextStyle(
                                  color: mainColorBlack,
                                  fontFamily: mainFontbold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                textAlign: TextAlign.end,
                                deleveryType == 1
                                    ? addCommasToPrice(widget.total -
                                        VoucherAmount +
                                        productrovider.deleveryCost)
                                    : addCommasToPrice(
                                        widget.total - VoucherAmount),
                                style: TextStyle(
                                  color: Colors.green,
                                  fontFamily: mainFontbold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Spacer to create vertical space
                  SizedBox(height: getHeight(context, 1)),
                ],
              ),
              waitingcheckout ? waitingWiget(context) : const SizedBox()
            ],
          ),
        ),

        bottomNavigationBar: Container(
          height: getHeight(context, 10), // Height of the bottom navigation bar
          color:
              mainColorWhite, // Background color of the bottom navigation bar
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getWidth(context, 6), // Horizontal padding
                vertical: getHeight(context, 1.5) // Vertical padding
                ),
            child: TextButton(
              onPressed:
                  waitingcheckout // If waiting for checkout, button is disabled
                      ? null
                      : () {
                          // Set waitingcheckout to true when button is pressed
                          setState(() {
                            waitingcheckout = true;
                          });

                          String data =
                              ""; // Initialize empty string for order data
                          // Iterate over cart items to build order data string
                          for (var element in cartProvider.cartItems) {
                            ProductModel Item = productrovider
                                .getoneProductById(element.product);
                            String price = Item.price2! > -1
                                ? Item.price2!
                                    .toString() // Use price2 if available
                                : Item.price.toString(); // Otherwise use price
                            data +=
                                "!&${Item.id},,,${Item.purchasePrice},,,$price,,,${Item.offerPrice},,,${element.quantity}";
                          }

                          // Prepare data for the order request
                          var data2 = {
                            "customerid": userdata["id"], // Customer ID
                            "total": widget.total, // Total amount
                            "location":
                                productrovider.defultlocation!, // Location
                            "order_data": data.substring(2), // Order data
                            "note": NoteController.text, // Note from the user
                            "voucher_id":
                                VoucherID == -1 ? "" : VoucherID, // Voucher ID
                            "cost": deleveryType == 1
                                ? productrovider.deleveryCost
                                : 0, // Delivery cost
                            "schedule": deleveryType == 1
                                ? "now" // Immediate delivery
                                : selectedDateorder +
                                    "||" +
                                    selectedTime, // Scheduled delivery
                          };

                          // Send order data to server
                          Network(false)
                              .postData("order", data2, context)
                              .then((value) {
                            if (value != "") {
                              if (value["code"] == "201") {
                                // If order is successfully placed
                                setState(() {
                                  waitingcheckout =
                                      false; // Reset waiting state
                                });
                                cartProvider.clearCart(); // Clear cart items
                                final productrovider =
                                    Provider.of<productProvider>(context,
                                        listen: false);

                                productrovider
                                    .refreshOrderData(); // Refresh order data

                                // Handle order timing and navigate to the success screen
                                DateTime timecheck =
                                    DateTime.parse(value["now"].toString());
                                DateTime ST = DateTime.parse(
                                    "2023-11-09 ${productrovider.startTime}:00");

                                DateTime DT = DateTime.parse(
                                    "2023-11-09 ${productrovider.endTime}:00");

                                DateTime NW = DateTime.parse(
                                    "2023-11-09 ${timecheck.hour}:00");

                                if ((NW.isAfter(ST) && NW.isBefore(DT)) ||
                                    NW.isAtSameMomentAs(ST) ||
                                    isSchedule) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => successScreen(
                                            value["total"].toString(),
                                            value["id"].toString(),
                                            value["time"].toString(),
                                            false,
                                            isSchedule,
                                            selectedDateorder +
                                                "" +
                                                selectedTime,
                                            deleveryType == 1
                                                ? productrovider.deleveryCost
                                                : 0)),
                                  ).then((value) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NavSwitch()),
                                    );
                                  });
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => successScreen(
                                            value["total"].toString(),
                                            value["id"].toString(),
                                            value["time"].toString(),
                                            true,
                                            isSchedule,
                                            selectedDateorder +
                                                "" +
                                                selectedTime,
                                            deleveryType == 1
                                                ? productrovider.deleveryCost
                                                : 0)),
                                  ).then((value) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NavSwitch()),
                                    );
                                  });
                                }
                              } else {
                                // If an error occurs, show error message
                                setState(() {
                                  waitingcheckout =
                                      false; // Reset waiting state
                                });
                                toastShort(
                                    "unknown occurred error please try again later"
                                        .tr);
                              }
                            } else {
                              // If no response from server, show error message
                              setState(() {
                                waitingcheckout = false; // Reset waiting state
                              });
                              toastShort(
                                  "unknown occurred error please try again later"
                                      .tr);
                            }
                          });
                        },
              style: TextButton.styleFrom(
                  textStyle: TextStyle(fontSize: 18, fontFamily: mainFontbold)),
              child: Text(
                "Send Order".tr, // Translated button text
              ),
            ),
          ),
        ),
      
      ),
    );
  }

  String convertTo12HourFormat(String time24) {
    // Splitting the time string into hours and minutes
    List<String> parts = time24.split(":");
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    // Determining AM or PM
    String period = hour < 12 ? 'AM'.tr : 'PM'.tr;

    // Converting hour to 12-hour format
    hour = hour > 12 ? hour - 12 : hour;

    // If hour becomes 0, convert it to 12
    hour = hour == 0 ? 12 : hour;

    // Constructing the 12-hour format time string
    String time12 = '$hour:$minute $period';

    return time12;
  }

  /// Returns the name of the weekday as a string based on the provided weekday integer.
  String getWeekdayName(int weekday) {
    // Use a switch statement to map the integer value of [weekday] to the corresponding weekday name
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        // Return an empty string if [weekday] doesn't match a valid weekday
        return '';
    }
  }
}
