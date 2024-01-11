import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/model/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class AllItem extends StatefulWidget {
  const AllItem({super.key});

  @override
  State<AllItem> createState() => _AllItemState();
}

class _AllItemState extends State<AllItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productPro = Provider.of<productProvider>(context, listen: true);
    String type = productPro.allitemType;
    String name = type == "brand"
        ? lang == "en"
            ? productPro.getonebrandById(productPro.idBrand).nameEn!
            : lang == "ar"
                ? productPro.getonebrandById(productPro.idBrand).nameAr!
                : productPro.getonebrandById(productPro.idBrand).nameKu!
        : "";

    late List<ProductModel> products = type == "discount"
        ? productPro.getProductsByDiscount()
        : type == "Highlight"
            ? productPro.getProductsByHighlight2()
            : type == "orders"
                ? productPro.getProductsByIds(productPro.listOrderProductIds())
                : type == "brand"
                    ? productPro.getProductsByBrand(productPro.idBrand)
                    : productPro.getProductsByBestsell2();

    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            type == "discount"
                ? "Discount".tr
                : type == "Highlight"
                    ? "Highlight".tr
                    : type == "orders"
                        ? "Recent Order".tr
                        : type == "brand"
                            ? name
                            : "Best Sell".tr,
          ),

          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              )),

          // Change the color of the unselected tab labels
        ),
        body: listItemsShow(context, products),
        //floatingActionButton: buildFAB(context),
      ),
    );
  }
}
