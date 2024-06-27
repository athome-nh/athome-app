import 'package:animate_do/animate_do.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/successScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import '../Landing/splash_screen.dart';
import 'package:dllylas/map/map_screen.dart';
import 'package:dllylas/model/product_model/product_model.dart';
import 'package:dllylas/model/schedule_model/schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:dllylas/Config/property.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Config/athome_functions.dart';
import '../main.dart';
import 'nav_switch.dart';

class CheckOut extends StatefulWidget {
  int total = 0;
  CheckOut(this.total, {super.key});
  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final PageController controller = PageController(initialPage: 0);
  TextEditingController NoteController = TextEditingController();
  TextEditingController voucherCode = TextEditingController();
  bool waitingcheckout = false;

  String orderCode = "";
  int deleveryType = 1;
  String VoucherE = "";
  int VoucherID = -1;
  int VoucherAmount = 0;
  List<String> listOfDays = [
    "Select Day".tr,
    "Monday".tr,
    "Tuesday".tr,
    "Wednesday".tr,
    "Thursday".tr,
    "Friday".tr,
    "Saturday".tr,
    "Sunday".tr
  ];
  bool Etime = false;
  late DateTime selectedDate;
  String selectedTime = "";
  String selectedDateorder = "";

  late DateTime Datetimenow;
  bool showTime = false;
  bool showDate = false;
  bool isSchedule = false;

  int currentDateSelectedIndex = 0;
  int currentTimeSelectedIndex = -1;
  @override
  void initState() {
    getServerTime().then((value) {
      Datetimenow = DateTime.parse(value);
      setState(() {
        showDate = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final productrovider = Provider.of<productProvider>(context, listen: true);
    List<ProductModel> cardItemshow =
        productrovider.getProductsByIds(cartProvider.ListId());
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        // appbar
        appBar: AppBar(
          title: Text(
            "Checkout".tr,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              )),
        ),

        // body
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: getWidth(context, 1),
                  right: getWidth(context, 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Delivery to',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: productrovider.location.isEmpty
                                      ? () async {
                                          LocationPermission permission =
                                              await Geolocator
                                                  .requestPermission();
                                          if (permission ==
                                              LocationPermission.denied) {
                                            // Handle case where the user denied access to their location
                                          }
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Map_screen()),
                                          );
                                        }
                                      : () {
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
                                            builder: (context) =>
                                                Directionality(
                                              textDirection: lang == "en"
                                                  ? TextDirection.ltr
                                                  : TextDirection.rtl,
                                              child: StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      StateSetter mystate) {
                                                return Stack(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  children: [
                                                    SizedBox(
                                                      width: getWidth(
                                                          context, 100),
                                                      height: getHeight(
                                                          context, 50),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(
                                                            "Please select Address"
                                                                .tr,
                                                            textAlign: TextAlign
                                                                .center,
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
                                                          Container(
                                                            width: getWidth(
                                                                context, 100),
                                                            height: getHeight(
                                                                context, 35),
                                                            child: ListView
                                                                .builder(
                                                                    itemCount: productrovider
                                                                        .location
                                                                        .length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      final location = productrovider
                                                                          .location
                                                                          .reversed
                                                                          .toList()[index];

                                                                      return Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            border:
                                                                                Border.all(
                                                                              color: mainColorGrey.withOpacity(0.5),
                                                                              width: 1,
                                                                              style: BorderStyle.solid,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              ListTile(
                                                                            onTap:
                                                                                () {
                                                                              if (productrovider.defultlocation == location.id!) {
                                                                              } else {
                                                                                mystate(() {
                                                                                  productrovider.setdefultlocation(location.id!);
                                                                                });
                                                                                Navigator.pop(context);
                                                                              }
                                                                            },
                                                                            title:
                                                                                Text(
                                                                              location.name!,
                                                                              maxLines: 1,
                                                                              style: TextStyle(fontFamily: mainFontbold, color: mainColorBlack, fontSize: 16),
                                                                            ),
                                                                            subtitle:
                                                                                Text(
                                                                              location.area!,
                                                                              style: TextStyle(fontFamily: mainFontnormal, color: mainColorGrey, fontSize: 12),
                                                                            ),
                                                                            trailing:
                                                                                Icon(
                                                                              productrovider.defultlocation == location.id! ? Icons.check_box : Icons.check_box_outline_blank,
                                                                              color: mainColorGrey,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              LocationPermission
                                                                  permission =
                                                                  await Geolocator
                                                                      .requestPermission();
                                                              if (permission ==
                                                                  LocationPermission
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
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: Container(
                                                          width: 65,
                                                          height: 5,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            color:
                                                                mainColorGrey,
                                                          ),
                                                        ))
                                                  ],
                                                );
                                              }),
                                            ),
                                          ).then((value) {});
                                        },
                                  child: Text(
                                    productrovider.location.isEmpty
                                        ? "Add location"
                                        : 'Change',
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
                              child: Divider(),
                            ),
                            productrovider.location.isEmpty
                                ? SizedBox()
                                : Row(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        color: mainColorRed,
                                      ),
                                      SizedBox(width: 8),
                                      RichText(
                                        text: new TextSpan(
                                          // Note: Styles for TextSpans must be explicitly defined.
                                          // Child text spans will inherit styles from parent
                                          style: new TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                          ),
                                          children: <TextSpan>[
                                            new TextSpan(
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
                                            new TextSpan(
                                              text: productrovider
                                                  .getonelocationById(
                                                      productrovider
                                                          .defultlocation!)
                                                  .name!,
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
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery Type".tr,
                              style: TextStyle(
                                  color: mainColorBlack,
                                  fontFamily: mainFontnormal,
                                  fontSize: 16),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Divider(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delevery now".tr,
                                  style: TextStyle(
                                      color: mainColorBlack,
                                      fontFamily: mainFontnormal,
                                      fontSize: 14),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        deleveryType = 1;
                                        currentDateSelectedIndex = 0;
                                        currentTimeSelectedIndex = -1;
                                        showTime = false;
                                        selectedDate = DateTime.now();
                                        selectedDateorder = "";
                                        selectedTime = "";
                                      });
                                    },
                                    child: Icon(
                                      deleveryType == 1
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank,
                                      color: mainColorGrey,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delevery schedule".tr,
                                  style: TextStyle(
                                      color: mainColorBlack,
                                      fontFamily: mainFontnormal,
                                      fontSize: 14),
                                ),
                                GestureDetector(
                                    onTap: !showDate
                                        ? null
                                        : () {
                                            setState(() {
                                              deleveryType = 2;
                                            });
                                            showModalBottomSheet(
                                              // enableDrag: false,
                                              // isDismissible: false,
                                              isScrollControlled: true,
                                              context: context,
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .only(
                                                  topEnd: Radius.circular(25),
                                                  topStart: Radius.circular(25),
                                                ),
                                              ),
                                              builder: (context) =>
                                                  Directionality(
                                                textDirection: lang == "en"
                                                    ? TextDirection.ltr
                                                    : TextDirection.rtl,
                                                child: Container(
                                                  padding: EdgeInsetsDirectional
                                                      .only(
                                                    start: 20,
                                                    end: 20,
                                                    bottom: 30,
                                                    top: 8,
                                                  ),
                                                  child: StatefulBuilder(
                                                      builder: (BuildContext
                                                              context,
                                                          StateSetter mystate) {
                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SizedBox(
                                                          height: getHeight(
                                                              context, 4),
                                                        ),
                                                        FadeInUp(
                                                          delay: const Duration(
                                                              milliseconds:
                                                                  200),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Center(
                                                                child:
                                                                    Container(
                                                                  width: getWidth(
                                                                      context,
                                                                      100),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    border: Border.all(
                                                                        color: deleveryType ==
                                                                                1
                                                                            ? mainColorBlack.withOpacity(0.2)
                                                                            : mainColorGrey.withOpacity(0.5)),
                                                                  ),
                                                                  child: Center(
                                                                    child:
                                                                        DropdownButtonFormField<
                                                                            int>(
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            UnderlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide.none,
                                                                        ),
                                                                      ),
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .calendar_today_outlined,
                                                                        color: deleveryType ==
                                                                                1
                                                                            ? mainColorBlack.withOpacity(0.2)
                                                                            : mainColorGrey.withOpacity(0.5),
                                                                      ),
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              15),
                                                                      value:
                                                                          currentDateSelectedIndex,
                                                                      onChanged:
                                                                          (newIndex) {
                                                                        mystate(
                                                                            () {
                                                                          currentTimeSelectedIndex =
                                                                              -1;
                                                                          currentDateSelectedIndex =
                                                                              newIndex!;

                                                                          if (newIndex ==
                                                                              0) {
                                                                            mystate(() {
                                                                              showTime = false;
                                                                            });
                                                                          } else {
                                                                            selectedDateorder =
                                                                                Datetimenow.add(Duration(days: newIndex - 1)).toString().substring(0, 10);
                                                                            selectedDate =
                                                                                Datetimenow.add(Duration(days: newIndex - 1));
                                                                            mystate(() {
                                                                              selectedTime = "";
                                                                              Etime = false;
                                                                              showTime = true;
                                                                            });
                                                                          }
                                                                        });
                                                                      },
                                                                      items: List.generate(
                                                                          listOfDays
                                                                              .length,
                                                                          (index) {
                                                                        bool hasAvailableSchedule = productrovider
                                                                            .scheduleData
                                                                            .where((time) =>
                                                                                time.weekId == getWeekdayName(Datetimenow.add(Duration(days: index - 1)).weekday) &&
                                                                                Datetimenow.add(Duration(hours: 1)).isBefore(DateTime.parse(Datetimenow.add(Duration(days: index - 1)).toString().substring(0, 10) + " " + time.from.toString())))
                                                                            .isNotEmpty;

                                                                        return DropdownMenuItem<
                                                                                int>(
                                                                            enabled:
                                                                                hasAvailableSchedule,
                                                                            value:
                                                                                index,
                                                                            child: index == 0
                                                                                ? Text(
                                                                                    listOfDays[index],
                                                                                    style: TextStyle(fontFamily: mainFontnormal, color: hasAvailableSchedule ? mainColorBlack : mainColorBlack.withOpacity(0.4)),
                                                                                  )
                                                                                : Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        Datetimenow.add(Duration(days: index - 1)).toString().substring(0, 10),
                                                                                        style: TextStyle(fontFamily: mainFontnormal, color: hasAvailableSchedule ? mainColorBlack : mainColorBlack.withOpacity(0.4)),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 15,
                                                                                      ),
                                                                                      Text(
                                                                                        Datetimenow.add(Duration(days: index - 1)).day == Datetimenow.day ? "Today".tr : getWeekdayName(Datetimenow.add(Duration(days: index - 1)).weekday),
                                                                                        style: TextStyle(fontFamily: mainFontnormal, color: hasAvailableSchedule ? mainColorBlack : mainColorBlack.withOpacity(0.4)),
                                                                                      ),
                                                                                    ],
                                                                                  ));
                                                                      }),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    getHeight(
                                                                        context,
                                                                        2),
                                                              ),
                                                              // Assuming productrovider.scheduleData is a List<ScheduleModel>

                                                              !showTime
                                                                  ? Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              20.0),
                                                                      child: Center(
                                                                          child:
                                                                              Text("Select Day to show time deleverys".tr)),
                                                                    )
                                                                  : SizedBox(
                                                                      height: getHeight(
                                                                          context,
                                                                          20),
                                                                      child: GridView
                                                                          .builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        gridDelegate:
                                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                                          crossAxisCount:
                                                                              2,
                                                                          mainAxisSpacing:
                                                                              10,
                                                                          crossAxisSpacing:
                                                                              10,
                                                                          childAspectRatio:
                                                                              4,
                                                                        ),
                                                                        itemCount: productrovider
                                                                            .scheduleData
                                                                            .where((time) =>
                                                                                time.weekId == getWeekdayName(selectedDate.weekday) &&
                                                                                Datetimenow.add(Duration(hours: 1)).isBefore(DateTime.parse(selectedDate.toString().substring(0, 10) + " " + time.from.toString())))
                                                                            .length,
                                                                        scrollDirection:
                                                                            Axis.vertical,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          ScheduleModel
                                                                              time =
                                                                              productrovider.scheduleData.where((time2) => time2.weekId == getWeekdayName(selectedDate.weekday) && Datetimenow.add(Duration(hours: 1)).isBefore(DateTime.parse(selectedDate.toString().substring(0, 10) + " " + time2.from.toString()))).toList()[index];

                                                                          return OutlinedButton(
                                                                            onPressed:
                                                                                () {
                                                                              mystate(() {
                                                                                Etime = false;
                                                                                selectedTime = time.from.toString() + "||" + time.to.toString();
                                                                                currentTimeSelectedIndex = index;
                                                                              });
                                                                            },
                                                                            style:
                                                                                TextButton.styleFrom(
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                              backgroundColor: currentTimeSelectedIndex == index ? mainColorGrey : mainColorWhite,
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              convertTo12HourFormat(time.from.toString()) + " - " + convertTo12HourFormat(time.to.toString()),
                                                                              style: TextStyle(
                                                                                fontFamily: mainFontnormal,
                                                                                fontSize: 12,
                                                                                color: currentTimeSelectedIndex == index ? mainColorWhite : mainColorBlack,
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
                                                                            .tr,
                                                                        style: TextStyle(
                                                                            color:
                                                                                mainColorRed,
                                                                            fontFamily:
                                                                                mainFontnormal),
                                                                      ),
                                                                    )
                                                                  : SizedBox(),
                                                              SizedBox(
                                                                height:
                                                                    getHeight(
                                                                        context,
                                                                        2),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        getWidth(
                                                                            context,
                                                                            4)),
                                                                child:
                                                                    TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    if (selectedTime
                                                                        .isEmpty) {
                                                                      mystate(
                                                                          () {
                                                                        Etime =
                                                                            true;
                                                                      });
                                                                    } else {
                                                                      mystate(
                                                                          () {
                                                                        isSchedule =
                                                                            true;
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                    }
                                                                  },
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    fixedSize: Size(
                                                                        getWidth(
                                                                            context,
                                                                            85),
                                                                        getHeight(
                                                                            context,
                                                                            6)),
                                                                  ),
                                                                  child: Text(
                                                                    "Select".tr,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ).then((value) {
                                              if (isSchedule) {
                                                setState(() {
                                                  isSchedule = true;
                                                });
                                              } else {
                                                setState(() {
                                                  isSchedule = false;
                                                  currentDateSelectedIndex = 0;
                                                  currentTimeSelectedIndex = -1;
                                                  showTime = false;
                                                  deleveryType = 1;
                                                  selectedDate = Datetimenow;
                                                  selectedDateorder = "";
                                                  selectedTime = "";
                                                });
                                              }
                                            });
                                          },
                                    child: Icon(
                                      deleveryType == 1
                                          ? Icons.check_box_outline_blank
                                          : Icons.check_box,
                                      color: mainColorGrey,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Voucher Code',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
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
                                              Container(
                                                width: getWidth(context, 100),
                                                height: getHeight(context, 40),
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 50),
                                                    Text(
                                                      "Please select Your Voucher",
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: mainColorBlack,
                                                        fontFamily:
                                                            mainFontbold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Container(
                                                      width: getWidth(
                                                          context, 100),
                                                      height: getHeight(
                                                          context, 30),
                                                      child: ListView.builder(
                                                          itemCount:
                                                              productrovider
                                                                  .usedVouchers
                                                                  .length,
                                                          itemBuilder:
                                                              (BuildContextcontext,
                                                                  int index) {
                                                            final voucher =
                                                                productrovider
                                                                        .usedVouchers[
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
                                                                  border: Border
                                                                      .all(
                                                                    color: mainColorGrey
                                                                        .withOpacity(
                                                                            0.5),
                                                                    width: 1,
                                                                    style: BorderStyle
                                                                        .solid,
                                                                  ),
                                                                ),
                                                                child: ListTile(
                                                                    title: Text(
                                                                        voucher
                                                                            .code!,
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
                                                                        )),
                                                                    subtitle:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          addCommasToPrice(
                                                                              voucher.discountAmount!),
                                                                          style: TextStyle(
                                                                              fontFamily: mainFontnormal,
                                                                              color: Colors.green,
                                                                              fontSize: 12),
                                                                        ),
                                                                        widget.total <
                                                                                voucher.mimimumAmount!
                                                                            ? Text(
                                                                                "must order by " + voucher.mimimumAmount.toString(),
                                                                                style: TextStyle(fontFamily: mainFontnormal, color: mainColorRed, fontSize: 12),
                                                                              )
                                                                            : SizedBox(),
                                                                      ],
                                                                    ),
                                                                    trailing:
                                                                        SizedBox(
                                                                      width: getWidth(
                                                                          context,
                                                                          15),
                                                                      height: getHeight(
                                                                          context,
                                                                          4),
                                                                      child:
                                                                          TextButton(
                                                                        style: TextButton
                                                                            .styleFrom(
                                                                          foregroundColor: widget.total >= voucher.mimimumAmount!
                                                                              ? mainColorWhite
                                                                              : mainColorBlack,
                                                                          backgroundColor: widget.total >= voucher.mimimumAmount!
                                                                              ? mainColorGrey
                                                                              : Colors.grey[300],
                                                                          fixedSize:
                                                                              Size(
                                                                            getWidth(context,
                                                                                5),
                                                                            getHeight(context,
                                                                                2),
                                                                          ),
                                                                        ),
                                                                        onPressed: widget.total >=
                                                                                voucher.mimimumAmount!
                                                                            ? () {
                                                                                voucherCode.text = voucher.code!;
                                                                              }
                                                                            : null,
                                                                        child:
                                                                            Text(
                                                                          "Apply",
                                                                          style: TextStyle(
                                                                              fontFamily: mainFontnormal,
                                                                              fontSize: 10),
                                                                        ),
                                                                      ),
                                                                    )),
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                  ))
                                            ],
                                          );
                                        }),
                                      ),
                                    ).then((value) {});
                                  },
                                  child: Text(
                                    'Select',
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
                              child: Divider(),
                            ),
                            Container(
                              height: getHeight(context, 6),
                              child: TextField(
                                controller: voucherCode,
                                onChanged: (value) {
                                  setState(() {
                                    VoucherE = "";
                                  });
                                },
                                decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.confirmation_num_outlined),
                                  hintText: "Voucher",
                                  hintStyle: TextStyle(
                                      color: mainColorBlack.withOpacity(0.5),
                                      fontSize: 14,
                                      fontFamily: mainFontnormal),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: mainColorGrey.withOpacity(0.5),
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  suffixIcon: Container(
                                    margin: EdgeInsets.all(8),
                                    child: TextButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent),
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(
                                            color: voucherCode.text.isEmpty
                                                ? mainColorGrey.withOpacity(0.5)
                                                : mainColorGrey),
                                      ),
                                      onPressed: voucherCode.text.isEmpty
                                          ? () {}
                                          : () {
                                              var data = {
                                                "id": userdata["id"],
                                                "amount": widget.total,
                                                "code": voucherCode.text,
                                              };
                                              Network(false)
                                                  .postData("checkvoucher",
                                                      data, context)
                                                  .then((value) {
                                                print(value);

                                                if (value != "") {
                                                  if (value["code"] == "200") {
                                                    if (value["data"] ==
                                                        "not_found") {
                                                      setState(() {
                                                        VoucherE = value["data"]
                                                            .toString();
                                                      });
                                                    } else if (value["data"] ==
                                                        "expired") {
                                                      setState(() {
                                                        VoucherE = value["data"]
                                                            .toString();
                                                      });
                                                    } else if (value["data"] ==
                                                        "minimum") {
                                                      setState(() {
                                                        VoucherE = value["data"]
                                                            .toString();
                                                      });
                                                    } else if (value["data"] ==
                                                        "limit") {
                                                      setState(() {
                                                        VoucherE = value["data"]
                                                            .toString();
                                                      });
                                                    } else if (value["data"] ==
                                                        "used") {
                                                      setState(() {
                                                        VoucherE = value["data"]
                                                            .toString();
                                                      });
                                                    } else if (value["data"] ==
                                                        "success") {
                                                      setState(() {
                                                        VoucherE = value["data"]
                                                            .toString();

                                                        VoucherID = value["id"];
                                                        VoucherAmount =
                                                            value["amount"];
                                                      });

                                                      productrovider
                                                          .notifyListeners();
                                                    }
                                                  } else {}
                                                } else {
                                                  setState(() {});
                                                }
                                              });
                                            },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            VoucherE.isNotEmpty
                                ? Center(
                                    child: Text(
                                      VoucherE,
                                      style: TextStyle(
                                          fontFamily: mainFontnormal,
                                          color: mainColorRed,
                                          fontSize: 14),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              maxLines: null,
                              controller: NoteController,
                              cursorColor: mainColorGrey,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {},
                              validator: (value) {
                                return null;
                              },
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: mainColorGrey.withOpacity(0.5),
                                    width: 1.0, // Customize border width
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: mainColorGrey.withOpacity(0.5),
                                    width: 1.0, // Customize border width
                                  ),
                                ),
                                labelText: "Add your note".tr,
                                labelStyle: TextStyle(
                                    color: mainColorGrey.withOpacity(0.8),
                                    fontSize: 20,
                                    fontFamily: mainFontbold),
                                hintText: "Note".tr,
                                hintStyle: TextStyle(
                                    color: mainColorBlack.withOpacity(0.5),
                                    fontSize: 14,
                                    fontFamily: mainFontnormal),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Payment deatils".tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                // Icon(
                                //   Icons.comment_outlined,
                                //   color: mainColorRed,
                                // )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Divider(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sub Total".tr,
                                  style: TextStyle(
                                      color: mainColorBlack,
                                      fontFamily: mainFontnormal,
                                      fontSize: 16),
                                ),
                                Text(
                                  textAlign: TextAlign.end,
                                  addCommasToPrice(widget.total),
                                  style: TextStyle(
                                      color: mainColorBlack,
                                      fontFamily: mainFontnormal,
                                      fontSize: 16),
                                ),
                              ],
                            ),
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
                                            fontSize: 16),
                                      ),
                                      Text(
                                        textAlign: TextAlign.end,
                                        addCommasToPrice(-VoucherAmount),
                                        style: TextStyle(
                                            color: mainColorRed,
                                            fontFamily: mainFontnormal,
                                            fontSize: 16),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery Cost".tr,
                                  style: TextStyle(
                                      color: mainColorBlack,
                                      fontFamily: mainFontnormal,
                                      fontSize: 16),
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
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Pyment Method".tr,
                                  style: TextStyle(
                                      color: mainColorBlack,
                                      fontFamily: mainFontnormal,
                                      fontSize: 16),
                                ),
                                Text(
                                  textAlign: TextAlign.end,
                                  "Cash",
                                  style: TextStyle(
                                      color: mainColorBlack,
                                      fontFamily: mainFontnormal,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Divider(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  textAlign: TextAlign.start,
                                  "Total".tr,
                                  style: TextStyle(
                                      color: mainColorBlack,
                                      fontFamily: mainFontbold,
                                      fontSize: 20),
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
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextButton(
                              onPressed: waitingcheckout
                                  ? null
                                  : () {
                                      setState(() {
                                        waitingcheckout = true;
                                      });

                                      String data = "";
                                      for (var element
                                          in cartProvider.cartItems) {
                                        ProductModel Item = productrovider
                                            .getoneProductById(element.product);
                                        String price = Item.price2! > -1
                                            ? Item.price2!.toString()
                                            : Item.price.toString();
                                        data +=
                                            "!&${Item.id},,,${Item.purchasePrice},,,$price,,,${Item.offerPrice},,,${element.quantity}";
                                      }

                                      var data2 = {
                                        "customerid": userdata["id"],
                                        "total": widget.total,
                                        "location":
                                            productrovider.defultlocation!,
                                        "order_data": data.substring(2),
                                        "note": NoteController.text,
                                        "voucher_id":
                                            VoucherID == -1 ? "" : VoucherID,
                                        "cost": deleveryType == 1
                                            ? productrovider.deleveryCost
                                            : 0,
                                        "schedule": deleveryType == 1
                                            ? "now"
                                            : selectedDateorder +
                                                "||" +
                                                selectedTime,
                                      };

                                      Network(false)
                                          .postData("order", data2, context)
                                          .then((value) {
                                        print(value);
                                        if (value != "") {
                                          if (value["code"] == "201") {
                                            setState(() {
                                              waitingcheckout = false;
                                            });
                                            cartProvider.clearCart();
                                            final productrovider =
                                                Provider.of<productProvider>(
                                                    context,
                                                    listen: false);

                                            productrovider.getuserdata(
                                                userdata["id"].toString());

                                            DateTime timecheck = DateTime.parse(
                                                value["now"].toString());
                                            DateTime ST = DateTime.parse(
                                                "2023-11-09 ${productrovider.startTime}:00");

                                            DateTime DT = DateTime.parse(
                                                "2023-11-09 ${productrovider.endTime}:00");

                                            DateTime NW = DateTime.parse(
                                                "2023-11-09 ${timecheck.hour}:00");

                                            if ((NW.isAfter(ST) &&
                                                    NW.isBefore(DT)) ||
                                                NW.isAtSameMomentAs(ST) ||
                                                isSchedule) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        successScreen(
                                                            value["total"]
                                                                .toString(),
                                                            value["id"]
                                                                .toString(),
                                                            value["time"]
                                                                .toString(),
                                                            false,
                                                            isSchedule,
                                                            selectedDateorder +
                                                                "" +
                                                                selectedTime,
                                                            deleveryType == 1
                                                                ? productrovider
                                                                    .deleveryCost
                                                                : 0)),
                                              ).then((value) {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NavSwitch()),
                                                );
                                              });
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        successScreen(
                                                            value["total"]
                                                                .toString(),
                                                            value["id"]
                                                                .toString(),
                                                            value["time"]
                                                                .toString(),
                                                            true,
                                                            isSchedule,
                                                            selectedDateorder +
                                                                "" +
                                                                selectedTime,
                                                            deleveryType == 1
                                                                ? productrovider
                                                                    .deleveryCost
                                                                : 0)),
                                              ).then((value) {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NavSwitch()),
                                                );
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              waitingcheckout = false;
                                            });
                                            toastShort(
                                                "unknown occurred error please try again later"
                                                    .tr);
                                          }
                                        } else {
                                          setState(() {
                                            waitingcheckout = false;
                                          });
                                          toastShort(
                                              "unknown occurred error please try again later"
                                                  .tr);
                                        }
                                      });
                                    },
                              style: TextButton.styleFrom(
                                fixedSize: Size(getWidth(context, 85),
                                    getHeight(context, 6)),
                              ),
                              child: Text(
                                "Send Order".tr,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              waitingcheckout ? waitingWiget(context) : const SizedBox()
            ],
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
    String period = hour < 12 ? 'AM' : 'PM';

    // Converting hour to 12-hour format
    hour = hour > 12 ? hour - 12 : hour;

    // If hour becomes 0, convert it to 12
    hour = hour == 0 ? 12 : hour;

    // Constructing the 12-hour format time string
    String time12 = '$hour:$minute $period';

    return time12;
  }

  String getWeekdayName(int weekday) {
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
        return '';
    }
  }

//   Future<void> alert(
//     BuildContext context,
//   ) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return StatefulBuilder(builder: (context2, state) {
//           return AlertDialog(
//               backgroundColor: mainColorGrey,
//               contentPadding: const EdgeInsets.all(0),
//               content: ClipRRect(
//                 borderRadius: BorderRadius.circular(5),
//                 child: ClipRect(
//                   child: Container(
//                     width: getWidth(context, 90),
//                     height: getHeight(context, 30),
//                     decoration: BoxDecoration(
//                         color: mainColorGrey.withOpacity(0.1),
//                         border:
//                             Border.all(color: mainColorWhite.withOpacity(0.1)),
//                         borderRadius: BorderRadius.circular(5)),
//                     padding: const EdgeInsets.all(10),
//                     child: ConstrainedBox(
//                       constraints: BoxConstraints(
//                         maxHeight: getHeight(context, 30),
//                       ),
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             const SizedBox(),
//                             Text(
//                               "sorryWeDoNotHaveDelivery".tr,
//                               textAlign: TextAlign.justify,
//                               style: TextStyle(
//                                 color: mainColorWhite.withOpacity(0.7),
//                                 fontFamily: mainFontnormal,
//                                 fontSize: 18,
//                               ),
//                             ),
//                             const SizedBox(),
//                             const SizedBox(),
//                             const SizedBox(),
//                             const SizedBox(),
//                             ElevatedButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                                 Navigator.pop(context);
//                                 Navigator.pop(context);
//                                 Navigator.pop(context);
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: mainColorRed,
//                                 fixedSize: const Size(70, 35),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               child: Text(
//                                 "OK".tr,
//                                 style: TextStyle(
//                                     fontSize: 18, fontFamily: mainFontnormal),
//                               ),
//                             ),
//                           ]),
//                     ),
//                   ),
//                 ),
//               ));
//         });
//       },
//     );
//   }
}
