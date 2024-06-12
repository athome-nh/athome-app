import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Config/property.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Vouchers'),
          bottom: TabBar(
            tabs: [
              Tab(text: "Active"),
              Tab(text: "Used"),
              Tab(text: "Expired"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ActiveTab(),
            UsedTab(),
            ExpiredTab(),
          ],
        ),
      ),
    );
  }
}

class ActiveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: productrovider.expireVouchers.isEmpty
          ? Center(
              child: Text(
                "Don\'t have any Voucher Code",
                style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 20,
                    color: mainColorGrey,
                    ),
              ),
            )
          : ListView.builder(
              itemCount: productrovider.unusedVouchers.length,
              itemBuilder: (context, index) {
                final voucher = productrovider.unusedVouchers[index];
                return ListTile(
                  leading: Icon(Icons.confirmation_num_outlined),
                  title: Text(lang == "en"
                      ? voucher.titleEn!
                      : lang == "ar"
                          ? voucher.titleAr!
                          : voucher.titleKu!),
                  subtitle: Text(addCommasToPrice(voucher.discountAmount!)),
                  trailing: Text(voucher.expireDate!),
                );
              },
            ),
    );
  }
}

class UsedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: productrovider.expireVouchers.isEmpty
          ? Center(
              child: Text(
                "Don\'t have any Voucher Code",
                style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 20,
                    color: mainColorGrey,
                    ),
              ),
            )
          : ListView.builder(
              itemCount: productrovider.usedVouchers.length,
              itemBuilder: (context, index) {
                final voucher = productrovider.usedVouchers[index];
                return ListTile(
                  leading: Icon(Icons.confirmation_num_outlined),
                  title: Text(lang == "en"
                      ? voucher.titleEn!
                      : lang == "ar"
                          ? voucher.titleAr!
                          : voucher.titleKu!),
                  subtitle: Text(addCommasToPrice(voucher.discountAmount!)),
                  trailing: Text(voucher.expireDate!),
                );
              },
            ),
    );
  }
}

class ExpiredTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: productrovider.expireVouchers.isEmpty
          ? Center(
              child: Text(
                "Don\'t have any Voucher Code",
                style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 20,
                    color: mainColorGrey,
                    ),
              ),
            )
          : ListView.builder(
              itemCount: productrovider.expireVouchers.length,
              itemBuilder: (context, index) {
                final voucher = productrovider.expireVouchers[index];
                return ListTile(
                  leading: Icon(Icons.confirmation_num_outlined),
                  title: Text(lang == "en"
                      ? voucher.titleEn!
                      : lang == "ar"
                          ? voucher.titleAr!
                          : voucher.titleKu!),
                  subtitle: Text(addCommasToPrice(voucher.discountAmount!)),
                  trailing: Text(voucher.expireDate!),
                );
              },
            ),
    );
  }
}
