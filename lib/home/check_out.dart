import 'package:animate_do/animate_do.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/successScreen.dart';
import 'package:dllylas/landing/splash_screen.dart';
import 'package:dllylas/map/map_screen.dart';
import 'package:dllylas/model/product_model/product_model.dart';
import 'package:dllylas/model/schedule_model/schedule_model.dart';
import 'package:flutter/cupertino.dart';
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
  bool waitingcheckout = false;
  int locationID = 0;
  String orderCode = "";
  int deleveryType = 1;

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

    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: getWidth(context, 4),
                    right: getWidth(context, 4),
                    top: getWidth(context, 1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Address".tr,
                          style: TextStyle(
                              color: mainColorBlack,
                              fontFamily: mainFontnormal,
                              fontSize: 16),
                        ),
                        IconButton(
                            onPressed: () async {
                              LocationPermission permission =
                                  await Geolocator.requestPermission();
                              if (permission == LocationPermission.denied) {
                                // Handle case where the user denied access to their location
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Map_screen()),
                              );
                            },
                            icon: Icon(
                              Icons.add_location_alt_outlined,
                              color: mainColorRed,
                              size: 30,
                            )),
                      ],
                    ),
                    SizedBox(
                      width: getWidth(context, 100),
                      height: getHeight(context, 10),
                      child: productrovider.location.isEmpty
                          ? GestureDetector(
                              onTap: () async {
                                LocationPermission permission =
                                    await Geolocator.requestPermission();
                                if (permission == LocationPermission.denied) {
                                  // Handle case where the user denied access to their location
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Map_screen()),
                                );
                              },
                              child: SizedBox(
                                width: getWidth(context, 100),
                                height: getHeight(context, 15),
                                child: Image.asset(lang == "en"
                                    ? "assets/Victors/location.png"
                                    : lang == "ar"
                                        ? "assets/Victors/locationAr.png"
                                        : "assets/Victors/locationKu.png"),
                              ),
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: 10,
                                );
                              },
                              scrollDirection: Axis.horizontal,
                              itemCount: productrovider.location.length,
                              itemBuilder: (BuildContext context, int index) {
                                final location = productrovider
                                    .location.reversed
                                    .toList()[index];

                                return Container(
                                    width: getWidth(context, 55),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: locationID == location.id!
                                                ? mainColorRed
                                                : mainColorGrey
                                                    .withOpacity(0.5)),
                                        color: locationID == location.id!
                                            ? mainColorGrey.withOpacity(0.1)
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ListTile(
                                      onTap: () {
                                        if (locationID == location.id!) {
                                          setState(() {
                                            locationID = 0;
                                          });
                                        } else {
                                          setState(() {
                                            locationID = location.id!;
                                          });
                                        }
                                      },
                                      title: Text(
                                        location.name!,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontFamily: mainFontbold,
                                            color: mainColorBlack,
                                            fontSize: 14),
                                      ),
                                      subtitle: Text(
                                        location.area!,
                                        style: TextStyle(
                                            fontFamily: mainFontnormal,
                                            color: mainColorGrey,
                                            fontSize: 11),
                                      ),
                                      trailing: Icon(
                                        locationID == location.id!
                                            ? Icons.check_circle
                                            : Icons.check_circle_outline,
                                        color: locationID == location.id!
                                            ? mainColorRed
                                            : mainColorGrey,
                                      ),
                                    ));
                              }),
                    ),
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Type".tr,
                          style: TextStyle(
                              color: mainColorBlack,
                              fontFamily: mainFontnormal,
                              fontSize: 16),
                        ),
                        IconButton(
                            onPressed: () async {},
                            icon: Icon(
                              Icons.calendar_today_outlined,
                              color: mainColorRed,
                              size: 25,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: mainColorGrey.withOpacity(0.5)),
                          ),
                          child: RadioMenuButton(
                              value: deleveryType,
                              groupValue: 1,
                              onChanged: (value) {
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
                              },
                              child: Text(
                                "Delevery now".tr,
                                style: TextStyle(
                                    color: mainColorBlack,
                                    fontFamily: mainFontnormal,
                                    fontSize: 14),
                              )),
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: mainColorGrey.withOpacity(0.5)),
                          ),
                          child: RadioMenuButton(
                              value: deleveryType,
                              groupValue: 2,
                              onChanged: !showDate
                                  ? null
                                  : (value) {
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
                                              BorderRadiusDirectional.only(
                                            topEnd: Radius.circular(25),
                                            topStart: Radius.circular(25),
                                          ),
                                        ),
                                        builder: (context) => Directionality(
                                          textDirection: lang == "en"
                                              ? TextDirection.ltr
                                              : TextDirection.rtl,
                                          child: Container(
                                            padding: EdgeInsetsDirectional.only(
                                              start: 20,
                                              end: 20,
                                              bottom: 30,
                                              top: 8,
                                            ),
                                            child: StatefulBuilder(builder:
                                                (BuildContext context,
                                                    StateSetter mystate) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        getHeight(context, 4),
                                                  ),
                                                  FadeInUp(
                                                    delay: const Duration(
                                                        milliseconds: 200),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Center(
                                                          child: Container(
                                                            width: getWidth(
                                                                context, 100),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              border: Border.all(
                                                                  color: deleveryType ==
                                                                          1
                                                                      ? mainColorBlack
                                                                          .withOpacity(
                                                                              0.2)
                                                                      : mainColorGrey
                                                                          .withOpacity(
                                                                              0.5)),
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
                                                                        BorderSide
                                                                            .none,
                                                                  ),
                                                                ),
                                                                icon: Icon(
                                                                  Icons
                                                                      .calendar_today_outlined,
                                                                  color: deleveryType ==
                                                                          1
                                                                      ? mainColorBlack
                                                                          .withOpacity(
                                                                              0.2)
                                                                      : mainColorGrey
                                                                          .withOpacity(
                                                                              0.5),
                                                                ),
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            15),
                                                                value:
                                                                    currentDateSelectedIndex,
                                                                onChanged:
                                                                    (newIndex) {
                                                                  mystate(() {
                                                                    currentTimeSelectedIndex =
                                                                        -1;
                                                                    currentDateSelectedIndex =
                                                                        newIndex!;

                                                                    if (newIndex ==
                                                                        0) {
                                                                      mystate(
                                                                          () {
                                                                        showTime =
                                                                            false;
                                                                      });
                                                                    } else {
                                                                      selectedDateorder = Datetimenow.add(Duration(
                                                                              days: newIndex -
                                                                                  1))
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              10);
                                                                      selectedDate =
                                                                          Datetimenow.add(
                                                                              Duration(days: newIndex - 1));
                                                                      mystate(
                                                                          () {
                                                                        selectedTime =
                                                                            "";
                                                                        Etime =
                                                                            false;
                                                                        showTime =
                                                                            true;
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
                                                                          time.weekId ==
                                                                              getWeekdayName(Datetimenow.add(Duration(days: index - 1))
                                                                                  .weekday) &&
                                                                          Datetimenow.add(Duration(hours: 1)).isBefore(DateTime.parse(Datetimenow.add(Duration(days: index - 1)).toString().substring(0, 10) +
                                                                              " " +
                                                                              time.from.toString())))
                                                                      .isNotEmpty;

                                                                  return DropdownMenuItem<
                                                                          int>(
                                                                      enabled:
                                                                          hasAvailableSchedule,
                                                                      value:
                                                                          index,
                                                                      child: index ==
                                                                              0
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
                                                          height: getHeight(
                                                              context, 2),
                                                        ),
                                                        // Assuming productrovider.scheduleData is a List<ScheduleModel>

                                                        !showTime
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            20.0),
                                                                child: Center(
                                                                    child: Text(
                                                                        "Select Day to show time deleverys"
                                                                            .tr)),
                                                              )
                                                            : SizedBox(
                                                                height:
                                                                    getHeight(
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
                                                                          time.weekId ==
                                                                              getWeekdayName(selectedDate
                                                                                  .weekday) &&
                                                                          Datetimenow.add(Duration(hours: 1)).isBefore(DateTime.parse(selectedDate.toString().substring(0, 10) +
                                                                              " " +
                                                                              time.from.toString())))
                                                                      .length,
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    ScheduleModel time = productrovider
                                                                        .scheduleData
                                                                        .where((time2) =>
                                                                            time2.weekId == getWeekdayName(selectedDate.weekday) &&
                                                                            Datetimenow.add(Duration(hours: 1)).isBefore(DateTime.parse(selectedDate.toString().substring(0, 10) +
                                                                                " " +
                                                                                time2.from.toString())))
                                                                        .toList()[index];

                                                                    return OutlinedButton(
                                                                      onPressed:
                                                                          () {
                                                                        mystate(
                                                                            () {
                                                                          Etime =
                                                                              false;
                                                                          selectedTime = time.from.toString() +
                                                                              "||" +
                                                                              time.to.toString();
                                                                          currentTimeSelectedIndex =
                                                                              index;
                                                                        });
                                                                      },
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(10)),
                                                                        backgroundColor: currentTimeSelectedIndex ==
                                                                                index
                                                                            ? mainColorGrey
                                                                            : mainColorWhite,
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        convertTo12HourFormat(time.from.toString()) +
                                                                            " - " +
                                                                            convertTo12HourFormat(time.to.toString()),
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              mainFontnormal,
                                                                          fontSize:
                                                                              12,
                                                                          color: currentTimeSelectedIndex == index
                                                                              ? mainColorWhite
                                                                              : mainColorBlack,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),

                                                        Etime
                                                            ? Center(
                                                                child: Text(
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
                                                          height: getHeight(
                                                              context, 2),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      getWidth(
                                                                          context,
                                                                          4)),
                                                          child: TextButton(
                                                            onPressed: () {
                                                              if (selectedTime
                                                                  .isEmpty) {
                                                                mystate(() {
                                                                  Etime = true;
                                                                });
                                                              } else {
                                                                mystate(() {
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
                              child: Text(
                                "Delevery schedule".tr,
                                style: TextStyle(
                                    color: mainColorBlack,
                                    fontFamily: mainFontnormal,
                                    fontSize: 14),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getHeight(context, 2),
                    ),
                    Text(
                      "Pyment Method".tr,
                      style: TextStyle(
                          color: mainColorBlack,
                          fontFamily: mainFontnormal,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: getHeight(context, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xffF2F2F2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cash on delivery".tr,
                                style: TextStyle(
                                    color: mainColorBlack,
                                    fontFamily: mainFontnormal,
                                    fontSize: 14),
                              ),
                              Icon(
                                Icons.check_circle_sharp,
                                color: Colors.green,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    GestureDetector(
                      onTap: () {
                        toastShort("Coming soon".tr);
                      },
                      child: Container(
                        height: getHeight(context, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xffF2F2F2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/images/fib.png"),
                              Text(
                                "Coming soon".tr,
                                style: TextStyle(
                                    color: mainColorBlack,
                                    fontFamily: mainFontnormal,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 1),
                    ),
                    GestureDetector(
                      onTap: () {
                        toastShort("Coming soon".tr);
                      },
                      child: Container(
                        height: getHeight(context, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xffF2F2F2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/images/fast.png"),
                              Text(
                                "Coming soon".tr,
                                style: TextStyle(
                                    color: mainColorBlack,
                                    fontFamily: mainFontnormal,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getHeight(context, 3),
                    ),
                    TextFormField(
                      maxLines: 2,
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
                            color: mainColorGrey, // Customize border color
                            width: 1.0, // Customize border width
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: mainColorGrey
                                .withOpacity(0.5), // Customize border color
                            width: 1.0, // Customize border width
                          ),
                        ),
                        labelText: "Note".tr,
                        labelStyle: TextStyle(
                            color: mainColorGrey.withOpacity(0.8),
                            fontSize: 20,
                            fontFamily: mainFontbold),
                        hintText: "Add your note".tr,
                        hintStyle: TextStyle(
                            color: mainColorBlack.withOpacity(0.5),
                            fontSize: 14,
                            fontFamily: mainFontnormal),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
                      ),
                    ),
                  ],
                ),
              ),
              waitingcheckout ? waitingWiget(context) : const SizedBox()
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: getHeight(context, 24),
          decoration: BoxDecoration(
            color: mainColorWhite,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                child: Row(
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
              ),
              SizedBox(
                height: getHeight(context, 1),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                child: Row(
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
                              : addCommasToPrice(productrovider.deleveryCost)
                          : "Free Delivery".tr,
                      style: TextStyle(
                          color:
                              deleveryType == 1 ? mainColorBlack : Colors.green,
                          fontFamily: mainFontnormal,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                child: const Divider(thickness: 1),
              ),
              SizedBox(
                height: getHeight(context, 1),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                child: Row(
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
                      addCommasToPrice(widget.total),
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
                padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                child: TextButton(
                  onPressed: waitingcheckout
                      ? null
                      : () {
                          if (locationID != 0) {
                            setState(() {
                              waitingcheckout = true;
                            });

                            String data = "";
                            for (var element in cartProvider.cartItems) {
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
                              "location": locationID,
                              "order_data": data.substring(2),
                              "note": NoteController.text,
                              "cost": deleveryType == 1
                                  ? productrovider.deleveryCost
                                  : 0,
                              "schedule": deleveryType == 1
                                  ? "now"
                                  : selectedDateorder + "||" + selectedTime,
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
                                      Provider.of<productProvider>(context,
                                          listen: false);

                                  productrovider
                                      .getuserdata(userdata["id"].toString());

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
                          } else {
                            showDialog(
                                context: context,
                                builder: (ctx) => StatefulBuilder(
                                      builder: (context, setState1) {
                                        return AlertDialog(
                                          content: Directionality(
                                            textDirection: lang == "en"
                                                ? TextDirection.ltr
                                                : TextDirection.rtl,
                                            child: Stack(
                                              alignment: lang == "en"
                                                  ? Alignment.topLeft
                                                  : Alignment.topRight,
                                              children: [
                                                SizedBox(
                                                  width: getWidth(context, 70),
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
                                                      Text(
                                                        productrovider.location
                                                                .isEmpty
                                                            ? "Please Delivery Address"
                                                                .tr
                                                            : "Please select Address"
                                                                .tr,
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
                                                            context, 60),
                                                        height: getHeight(
                                                            context, 30),
                                                        child: productrovider
                                                                .location
                                                                .isEmpty
                                                            ? GestureDetector(
                                                                onTap:
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
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const Map_screen()),
                                                                  );
                                                                },
                                                                child: SizedBox(
                                                                  width: getWidth(
                                                                      context,
                                                                      100),
                                                                  height:
                                                                      getHeight(
                                                                          context,
                                                                          15),
                                                                  child: Image.asset(lang ==
                                                                          "en"
                                                                      ? "assets/Victors/location.png"
                                                                      : lang ==
                                                                              "ar"
                                                                          ? "assets/Victors/locationAr.png"
                                                                          : "assets/Victors/locationKu.png"),
                                                                ),
                                                              )
                                                            : ListView.builder(
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

                                                                  return Column(
                                                                    children: [
                                                                      ListTile(
                                                                        onTap:
                                                                            () {
                                                                          if (locationID ==
                                                                              location.id!) {
                                                                            setState1(() {
                                                                              locationID = 0;
                                                                            });
                                                                          } else {
                                                                            setState1(() {
                                                                              locationID = location.id!;
                                                                            });
                                                                          }
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        title:
                                                                            Text(
                                                                          location
                                                                              .name!,
                                                                          maxLines:
                                                                              1,
                                                                          style: TextStyle(
                                                                              fontFamily: mainFontbold,
                                                                              color: mainColorBlack,
                                                                              fontSize: 16),
                                                                        ),
                                                                        subtitle:
                                                                            Text(
                                                                          location
                                                                              .area!,
                                                                          style: TextStyle(
                                                                              fontFamily: mainFontnormal,
                                                                              color: mainColorGrey,
                                                                              fontSize: 12),
                                                                        ),
                                                                        trailing:
                                                                            Icon(
                                                                          locationID == location.id!
                                                                              ? Icons.check_circle
                                                                              : Icons.check_circle_outline,
                                                                          color: locationID == location.id!
                                                                              ? mainColorRed
                                                                              : mainColorGrey,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: getWidth(
                                                                            context,
                                                                            45),
                                                                        child:
                                                                            Divider(
                                                                          color:
                                                                              mainColorGrey.withOpacity(0.1),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  );
                                                                }),
                                                      ),
                                                      TextButton(
                                                        onPressed:
                                                            productrovider
                                                                    .location
                                                                    .isEmpty
                                                                ? () async {
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
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              const Map_screen()),
                                                                    );
                                                                  }
                                                                : () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              productrovider
                                                                          .location
                                                                          .length >
                                                                      0
                                                                  ? mainColorGrey
                                                                  : mainColorRed,
                                                          fixedSize: Size(
                                                              getWidth(
                                                                  context, 70),
                                                              getHeight(
                                                                  context, 5)),
                                                        ),
                                                        child: Text(
                                                          productrovider
                                                                  .location
                                                                  .isEmpty
                                                              ? "Add location"
                                                                  .tr
                                                              : "Confirm".tr,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon:
                                                        const Icon(Icons.close))
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ));
                          }
                        },
                  style: TextButton.styleFrom(
                    fixedSize:
                        Size(getWidth(context, 85), getHeight(context, 6)),
                  ),
                  child: Text(
                    "Send Order".tr,
                  ),
                ),
              ),
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
