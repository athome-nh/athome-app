import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class allBrands extends StatefulWidget {
  const allBrands({super.key});

  @override
  State<allBrands> createState() => _allBrandsState();
}

class _allBrandsState extends State<allBrands> {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("Brands"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
            )),
      ),
      body: listitemsBigBrands(context, productrovider.brands),
    );
  }
}
