import 'package:athome/model/category_model/category_model.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:athome/model/sub_category/sub_category.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class productProvider extends ChangeNotifier {
  // List to store your products
  List<ProductModel> _products = [];
  List<CategoryModel> _categores = [];
  List<SubCategory> _subCategores = [];
  String _searchproduct = "";
  String _allitemType = "";
  int _cateType = 0;
  // Getter to access the list of products
  List<ProductModel> get products => _products;
  List<CategoryModel> get categores => _categores;
  List<SubCategory> get subCategores => _subCategores;
  String get searchproduct => _searchproduct;
  String get allitemType => _allitemType;
  int get cateType => _cateType;
  List<ProductModel> getProductsByCategory(int category) {
    return _products
        .where((product) => product.categoryId == category)
        .toList();
  }

  List<ProductModel> getProductsByDiscount() {
    return _products.where((product) => product.offerPrice! > 0).toList();
  }

  List<ProductModel> getProductsByBestsell() {
    return _products.where((product) => product.bestSell == true).toList();
  }

  List<ProductModel> getProductsBySearch(String value) {
    return _products
        .where((product) => lang == "en"
            ? product.nameEn!.toLowerCase().contains(value.toLowerCase()) ==
                true
            : lang == "ar"
                ? product.nameAr!.toLowerCase().contains(value.toLowerCase()) ==
                    true
                : product.nameKu!.toLowerCase().contains(value.toLowerCase()) ==
                    true)
        .toList();
  }

  List<ProductModel> getProductsByHighlight() {
    return _products.where((product) => product.highlight == true).toList();
  }

  List<ProductModel> getProductsByIds(List<int> idsToRetrieve) {
    return products
        .where((product) => idsToRetrieve.contains(product.id))
        .toList();
  }

  List<SubCategory> getsubcateById(int idToRetrieve) {
    return subCategores
        .where((subcate) => subcate.categoryId == idToRetrieve)
        .toList();
  }

  // Add a product to the list
  void setProducts(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  void setCategorys(List<CategoryModel> categores) {
    _categores = categores;
    notifyListeners();
  }

  void setsubCategorys(List<SubCategory> subCategores) {
    _subCategores = subCategores;
    notifyListeners();
  }

  void setsearch(String searchproduct) {
    _searchproduct = searchproduct;
    notifyListeners();
  }

  void settype(String allitemType) {
    _allitemType = allitemType;
    notifyListeners();
  }

  void setcatetype(int cateType) {
    _cateType = cateType;
    notifyListeners();
  }
}
