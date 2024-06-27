  // Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text(
  //                             "Your Voucher Code".tr,
  //                             style: TextStyle(
  //                                 color: mainColorBlack,
  //                                 fontFamily: mainFontnormal,
  //                                 fontSize: 16),
  //                           ),
  //                           TextButton(
  //                             onPressed: () async {
  //                               // setState(() {
  //                               //   VoucherE = "";
  //                               //   voucherCode.clear();
  //                               // });
  //                               showDialog(
  //                                 context: context,
  //                                 builder: (ctx) => StatefulBuilder(
  //                                   builder: (context, setState1) {
  //                                     return AlertDialog(
  //                                       content: Directionality(
  //                                         textDirection: lang == "en"
  //                                             ? TextDirection.ltr
  //                                             : TextDirection.rtl,
  //                                         child: Stack(
  //                                           alignment: lang == "en"
  //                                               ? Alignment.topLeft
  //                                               : Alignment.topRight,
  //                                           children: [
  //                                             SizedBox(
  //                                               width: getWidth(context, 70),
  //                                               height: getHeight(context, 50),
  //                                               child: SingleChildScrollView(
  //                                                 child: Column(
  //                                                   crossAxisAlignment:
  //                                                       CrossAxisAlignment
  //                                                           .center,
  //                                                   mainAxisAlignment:
  //                                                       MainAxisAlignment
  //                                                           .center,
  //                                                   children: <Widget>[
  //                                                     // Title
  //                                                     Text(
  //                                                       "Voucher Code",
  //                                                       textAlign:
  //                                                           TextAlign.center,
  //                                                       maxLines: 1,
  //                                                       style: TextStyle(
  //                                                         color: mainColorBlack,
  //                                                         fontFamily:
  //                                                             mainFontbold,
  //                                                         fontSize: 15,
  //                                                       ),
  //                                                     ),

  //                                                     SizedBox(
  //                                                         height: getHeight(
  //                                                             context, 4)),

  //                                                     // TextField
  //                                                     Container(
  //                                                       width: getWidth(
  //                                                           context, 90),
  //                                                       height: getWidth(
  //                                                           context, 12),
  //                                                       child: TextFormField(
  //                                                         controller:
  //                                                             voucherCode,
  //                                                         decoration:
  //                                                             InputDecoration(
  //                                                           focusedBorder:
  //                                                               OutlineInputBorder(
  //                                                             borderRadius:
  //                                                                 BorderRadius
  //                                                                     .circular(
  //                                                                         15),
  //                                                             borderSide:
  //                                                                 BorderSide(
  //                                                               color:
  //                                                                   mainColorGrey,
  //                                                               width: 1.0,
  //                                                             ),
  //                                                           ),
  //                                                           enabledBorder:
  //                                                               OutlineInputBorder(
  //                                                             borderRadius:
  //                                                                 BorderRadius
  //                                                                     .circular(
  //                                                                         15),
  //                                                             borderSide:
  //                                                                 BorderSide(
  //                                                               color: mainColorGrey
  //                                                                   .withOpacity(
  //                                                                       0.8),
  //                                                               width: 1.0,
  //                                                             ),
  //                                                           ),
  //                                                           focusedErrorBorder:
  //                                                               OutlineInputBorder(
  //                                                             borderRadius:
  //                                                                 BorderRadius
  //                                                                     .circular(
  //                                                                         15),
  //                                                             borderSide:
  //                                                                 BorderSide(
  //                                                               color:
  //                                                                   Colors.red,
  //                                                               width: 1.0,
  //                                                             ),
  //                                                           ),
  //                                                           labelText:
  //                                                               "Enter Voucher Code",
  //                                                           hintStyle: TextStyle(
  //                                                               color: mainColorBlack
  //                                                                   .withOpacity(
  //                                                                       0.5),
  //                                                               fontSize: 14,
  //                                                               fontFamily:
  //                                                                   mainFontnormal),
  //                                                           floatingLabelBehavior:
  //                                                               FloatingLabelBehavior
  //                                                                   .always,
  //                                                         ),
  //                                                       ),
  //                                                     ),
  //                                                     SizedBox(
  //                                                       height: 5,
  //                                                     ),
  //                                                     VoucherE.isNotEmpty
  //                                                         ? Text(
  //                                                             VoucherE,
  //                                                             style: TextStyle(
  //                                                                 fontFamily:
  //                                                                     mainFontnormal,
  //                                                                 color:
  //                                                                     mainColorRed,
  //                                                                 fontSize: 14),
  //                                                           )
  //                                                         : SizedBox(),

  //                                                     SizedBox(
  //                                                         height: getHeight(
  //                                                             context, 2)),

  //                                                     // ListView
  //                                                     Container(
  //                                                       width: getWidth(
  //                                                           context, 100),
  //                                                       height: getHeight(
  //                                                           context, 25),
  //                                                       child: ListView.builder(
  //                                                           itemCount:
  //                                                               productrovider
  //                                                                   .unusedVouchers
  //                                                                   .length,
  //                                                           itemBuilder:
  //                                                               (BuildContextcontext,
  //                                                                   int index) {
  //                                                             final voucher =
  //                                                                 productrovider
  //                                                                         .unusedVouchers[
  //                                                                     index];

  //                                                             return Column(
  //                                                               children: [
  //                                                                 ListTile(
  //                                                                     title: Text(
  //                                                                         voucher
  //                                                                             .code!,
  //                                                                         maxLines:
  //                                                                             1,
  //                                                                         style:
  //                                                                             TextStyle(
  //                                                                           fontFamily:
  //                                                                               mainFontbold,
  //                                                                           color:
  //                                                                               mainColorBlack,
  //                                                                           fontSize:
  //                                                                               16,
  //                                                                         )),
  //                                                                     subtitle:
  //                                                                         Column(
  //                                                                       crossAxisAlignment:
  //                                                                           CrossAxisAlignment.start,
  //                                                                       children: [
  //                                                                         Text(
  //                                                                           addCommasToPrice(voucher.discountAmount!),
  //                                                                           style: TextStyle(
  //                                                                               fontFamily: mainFontnormal,
  //                                                                               color: Colors.green,
  //                                                                               fontSize: 12),
  //                                                                         ),
  //                                                                         widget.total < voucher.mimimumAmount!
  //                                                                             ? Text(
  //                                                                                 "must order by " + voucher.mimimumAmount.toString(),
  //                                                                                 style: TextStyle(fontFamily: mainFontnormal, color: mainColorRed, fontSize: 12),
  //                                                                               )
  //                                                                             : SizedBox(),
  //                                                                       ],
  //                                                                     ),
  //                                                                     trailing:
  //                                                                         SizedBox(
  //                                                                       width: getWidth(
  //                                                                           context,
  //                                                                           15),
  //                                                                       height: getHeight(
  //                                                                           context,
  //                                                                           4),
  //                                                                       child:
  //                                                                           TextButton(
  //                                                                         style:
  //                                                                             TextButton.styleFrom(
  //                                                                           foregroundColor: widget.total >= voucher.mimimumAmount!
  //                                                                               ? mainColorWhite
  //                                                                               : mainColorBlack,
  //                                                                           backgroundColor: widget.total >= voucher.mimimumAmount!
  //                                                                               ? mainColorGrey
  //                                                                               : Colors.grey[300],
  //                                                                           fixedSize:
  //                                                                               Size(
  //                                                                             getWidth(context, 5),
  //                                                                             getHeight(context, 2),
  //                                                                           ),
  //                                                                         ),
  //                                                                         onPressed: widget.total >= voucher.mimimumAmount!
  //                                                                             ? () {
  //                                                                                 voucherCode.text = voucher.code!;
  //                                                                               }
  //                                                                             : null,
  //                                                                         child:
  //                                                                             Text(
  //                                                                           "Apply",
  //                                                                           style:
  //                                                                               TextStyle(fontFamily: mainFontnormal, fontSize: 10),
  //                                                                         ),
  //                                                                       ),
  //                                                                     )),
  //                                                                 SizedBox(
  //                                                                   width: getWidth(
  //                                                                       context,
  //                                                                       60),
  //                                                                   child:
  //                                                                       Divider(
  //                                                                     color: mainColorGrey
  //                                                                         .withOpacity(
  //                                                                             0.1),
  //                                                                   ),
  //                                                                 )
  //                                                               ],
  //                                                             );
  //                                                           }),
  //                                                     ),

  //                                                     TextButton(
  //                                                       onPressed: () {
  //                                                         var data = {
  //                                                           "id":
  //                                                               userdata["id"],
  //                                                           "amount":
  //                                                               widget.total,
  //                                                           "code": voucherCode
  //                                                               .text,
  //                                                         };
  //                                                         Network(false)
  //                                                             .postData(
  //                                                                 "checkvoucher",
  //                                                                 data,
  //                                                                 context)
  //                                                             .then((value) {
  //                                                           print(value);

  //                                                           if (value != "") {
  //                                                             if (value[
  //                                                                     "code"] ==
  //                                                                 "200") {
  //                                                               if (value[
  //                                                                       "data"] ==
  //                                                                   "not_found") {
  //                                                                 setState1(() {
  //                                                                   VoucherE = value[
  //                                                                           "data"]
  //                                                                       .toString();
  //                                                                 });
  //                                                               } else if (value[
  //                                                                       "data"] ==
  //                                                                   "expired") {
  //                                                                 setState1(() {
  //                                                                   VoucherE = value[
  //                                                                           "data"]
  //                                                                       .toString();
  //                                                                 });
  //                                                               } else if (value[
  //                                                                       "data"] ==
  //                                                                   "minimum") {
  //                                                                 setState1(() {
  //                                                                   VoucherE = value[
  //                                                                           "data"]
  //                                                                       .toString();
  //                                                                 });
  //                                                               } else if (value[
  //                                                                       "data"] ==
  //                                                                   "limit") {
  //                                                                 setState1(() {
  //                                                                   VoucherE = value[
  //                                                                           "data"]
  //                                                                       .toString();
  //                                                                 });
  //                                                               } else if (value[
  //                                                                       "data"] ==
  //                                                                   "used") {
  //                                                                 setState1(() {
  //                                                                   VoucherE = value[
  //                                                                           "data"]
  //                                                                       .toString();
  //                                                                 });
  //                                                               } else if (value[
  //                                                                       "data"] ==
  //                                                                   "success") {
  //                                                                 setState1(() {
  //                                                                   VoucherE = value[
  //                                                                           "data"]
  //                                                                       .toString();

  //                                                                   VoucherID =
  //                                                                       value[
  //                                                                           "id"];
  //                                                                   VoucherAmount =
  //                                                                       value[
  //                                                                           "amount"];
  //                                                                 });
  //                                                                 Navigator.pop(
  //                                                                     context);
  //                                                                 productrovider
  //                                                                     .notifyListeners();
  //                                                               }
  //                                                             } else {}
  //                                                           } else {
  //                                                             setState(() {});
  //                                                           }
  //                                                         });
  //                                                       },
  //                                                       child: Text("Submit"),
  //                                                     ),
  //                                                   ],
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     );
  //                                   },
  //                                 ),
  //                               );
  //                             },
  //                             child: Text("Add Voucher"),
  //                           ),
  //                         ],
  //                       ),
  //                       SizedBox(
  //                         height: getHeight(context, 2),
  //                       ),