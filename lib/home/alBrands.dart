// Import necessary packages and libraries
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

/// The `allBrands` widget displays a list of all brands.
/// It retrieves the list of brands from the `productProvider` and displays them in a list using `listitemsBigBrands`.

class allBrands extends StatefulWidget {
  const allBrands({super.key});

  @override
  State<allBrands> createState() => _allBrandsState();
}

class _allBrandsState extends State<allBrands> {
  @override
  Widget build(BuildContext context) {
    /// Access the product provider to retrieve the list of brands.
    final productrovider = Provider.of<productProvider>(context, listen: true);

    return Scaffold(
      /// An AppBar that displays the title "Brands" and a back button.
      appBar: AppBar(
        title: Text("Brands".tr),  // Localized title for "Brands"
        leading: IconButton(
          onPressed: () {
            /// Navigate back to the previous page when the back button is pressed.
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      
      /// Displays a list of brands using the `listitemsBigBrands` widget.
      body: listitemsBigBrands(context, productrovider.brands),
    );
  }
}
