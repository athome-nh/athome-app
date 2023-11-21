import 'dart:async';
import 'dart:convert';

import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/local_data.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Landing/disableaccount.dart';
import 'package:athome/Network/Network.dart';

import 'package:athome/landing/splash_screen.dart';
import 'package:athome/main.dart';
import 'package:athome/model/brandmodel/brandmodel.dart';
import 'package:athome/model/category_model/category_model.dart';
import 'package:athome/model/location/location.dart';
import 'package:athome/model/order_items/order_items.dart';
import 'package:athome/model/order_model/order_model.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:athome/model/productitems/productitems.dart';
import 'package:athome/model/products_image/products_image.dart';
import 'package:athome/model/slidemodel/slidemodel.dart';
import 'package:athome/model/sub_category/sub_category.dart';
import 'package:athome/model/topmodel/topmodel.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class productProvider extends ChangeNotifier {
  productProvider() {
    // loadPostData();
    //  updatePost();
  }
  getproductitems(int id) {
    productitems.clear();
    String ids = listOrderitemsId(id).substring(2);
    Network(false)
        .postData(
            "getProductInOrder",
            {
              "data": ids,
            },
            navigatorKey.currentContext!)
        .then((value) {
      if (value != "") {
        if (value["code"] != 200) {
          setProductitems((value['products'] as List)
              .map((x) => Productitems.fromMap(x))
              .toList());
        } else {}
      }
    });
  }

  getDataAll(bool user) {
    print("Start");
    Network(false).getData("showData").then((value) async {
      if (value != "") {
        if (value["code"] != 200) {
          setProducts((json.decode(decryptAES(value["products"])) as List)
              .map((x) => ProductModel.fromMap(x))
              .toList());
          setCategorys((value['category'] as List)
              .map((x) => CategoryModel.fromMap(x))
              .toList());
          setsubCategorys((value['subCategory'] as List)
              .map((x) => SubCategory.fromMap(x))
              .toList());
          setproductimages((value['productsImage'] as List)
              .map((x) => ProductsImage.fromMap(x))
              .toList());
          setslides((value['slide'] as List)
              .map((x) => Slidemodel.fromMap(x))
              .toList());
          settops((value['top_image'] as List)
              .map((x) => Topmodel.fromMap(x))
              .toList());
          setbrands((value['brands'] as List)
              .map((x) => Brandmodel.fromMap(x))
              .toList());
          setMinimumOrder(value['minimum_order']);
          if (user) {
            getDataUser(userdata["id"].toString());
          }

          setshow(true);

          print("end");
        } else {}
      } else {}
    });
  }

  getDataUser(String id) {
    Network(false).getData("showDataUser/" + id).then((value) async {
      if (value != "") {
        if (value["code"] != 200) {
          setlocation((value['locations'] as List)
              .map((x) => Locationuser.fromMap(x))
              .toList());
          setOrders((value['orders'] as List)
              .map((x) => OrderModel.fromMap(x))
              .toList());
          setOrderItems((value['orders_item'] as List)
              .map((x) => OrderItems.fromMap(x))
              .toList());

          setshow(true);
        } else {}
      } else {}
    });
  }

  updatePost(bool user) async {
    if (isLogin) {
      Network(false).getDatauser("userInfo", token).then((valueuser) {
        if (valueuser != "") {
          if (valueuser["code"] == "201") {
            userdata = json.decode(decryptAES(valueuser["data"]));
            if (userdata["isActive"] == 0) {
              userdata.clear();
              Network(false)
                  .postData("logout", {}, navigatorKey.currentContext!);
              isLogin = false;
              token = "";
              setStringPrefs("token", "");
              Timer(
                const Duration(seconds: 5),
                () {
                  showDialog(
                    context: navigatorKey.currentContext!,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Stack(
                          alignment: lang == "en"
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          children: [
                            Container(
                              width: getWidth(context, 70),
                              height: getHeight(context, 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/Victors/disabled.png",
                                    width: getWidth(context, 40),
                                    height: getWidth(context, 40),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Account Disabled".tr,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: mainColorGrey,
                                      fontFamily: mainFontbold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Account is disable please contact athome admin"
                                        .tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: mainColorGrey,
                                      fontFamily: mainFontnormal,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(getWidth(context, 70),
                                          getHeight(context, 5)),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(color: mainColorGrey),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: Text(
                                      "OK".tr,
                                      style: TextStyle(
                                        color: mainColorGrey,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close))
                          ],
                        ),
                      );
                    },
                  );
                },
              );

              getDataAll(false);
              return;
            }
            getDataAll(user);
          }
        }
      });
    } else {
      getDataAll(user);
    }
  }

  updateUser() async {
    if (isLogin) {
      Network(false).getDatauser("userInfo", token).then((valueuser) {
        if (valueuser != "") {
          if (valueuser["code"] == "201") {
            userdata = valueuser["data"][0];
          }
        }
      });
    }
  }

  // List to store your products

  List<Topmodel> _tops = [];
  List<Slidemodel> _slides = [];
  List<Brandmodel> _brands = [];
  List<ProductModel> _products = [];
  List<Productitems> _productitems = [];

  List<CategoryModel> _categores = [];
  List<SubCategory> _subCategores = [];
  List<ProductsImage> _productimages = [];
  List<OrderModel> _Orders = [];
  List<OrderItems> _Orderitems = [];
  List<Locationuser> _location = [];
  int _defultlocation = 0;
  String _searchproduct = "";
  String _allitemType = "";
  int _cateType = 0;
  int _minimumOrder = 0;
  int _idItem = 0;
  int _subcateSelect = 0;
  bool show = false;
  bool activeUser = false;
  bool nointernetCheck = false;

  // Getter to access the list of products
  List<Topmodel> get tops => _tops;

  List<Slidemodel> get slides => _slides;
  List<Brandmodel> get brands => _brands;
  List<OrderItems> get Orderitems => _Orderitems;
  List<Locationuser> get location => _location;
  List<OrderModel> get Orders => _Orders;
  List<ProductModel> get products => _products;
  List<Productitems> get productitems => _productitems;

  List<CategoryModel> get categores => _categores;
  List<SubCategory> get subCategores => _subCategores;
  List<ProductsImage> get productimages => _productimages;
  String get searchproduct => _searchproduct;

  String get allitemType => _allitemType;
  int get cateType => _cateType;
  int get minimumOrder => _minimumOrder;
  int get idItem => _idItem;
  int get subcateSelect => _subcateSelect;
  int get defultlocation => _defultlocation;

  List<ProductModel> getProductsBySubCategory(int subcategory) {
    return _products
        .where((product) => product.subCategoryId == subcategory)
        .toList();
  }

  List<ProductModel> getProductsBySubCategory2(int subcategory, int Pid) {
    return _products
        .where((product) =>
            product.subCategoryId == subcategory && product.id != Pid)
        .toList();
  }

  List<ProductModel> getProductsByCategory(int category) {
    return _products
        .where((product) => product.categoryId == category)
        .toList();
  }

  List<ProductModel> getProductsByDiscount() {
    return _products.where((product) => checkOferPrice(product)).toList();
  }

  List<ProductModel> getProductsByBrand(int brand) {
    return _products.where((product) => product.brandId! == brand).toList();
  }

  List<ProductsImage> getproductimages(int id) {
    return _productimages.where((product) => product.productId! == id).toList();
  }

  List<ProductModel> getProductsByBestsell() {
    return _products
        .where((product) => product.bestSell == 1 && !checkOferPrice(product))
        .toList();
  }

  List<ProductModel> getProductsByBestsell2() {
    return _products.where((product) => product.bestSell == 1).toList();
  }

  List<ProductModel> getProductsBySearch(String value) {
    return _products
        .where((product) =>
            // lang == "en"
            //         ? product.nameEn!.toLowerCase().contains(value.toLowerCase()) ==
            //             true
            //         : lang == "ar"
            //             ? product.nameAr!
            //                     .toLowerCase()
            //                     .contains(value.toLowerCase()) ==
            //                 true
            //             : product.nameKu!
            //                     .toLowerCase()
            //                     .contains(value.toLowerCase()) ==
            //                 true
            (product.nameEn! + product.nameAr! + product.nameKu!)
                .toLowerCase()
                .contains(value.toLowerCase()) ==
            true)
        .toList();
  }

  List<ProductModel> getProductsByHighlight() {
    return _products
        .where((product) => product.highlight == 1 && !checkOferPrice(product))
        .toList();
  }

  List<ProductModel> getProductsByHighlight2() {
    return _products.where((product) => product.highlight == 1).toList();
  }

  List<ProductModel> getProductsByIds2(List<int> idsToRetrieve) {
    return _products
        .where((product) =>
            !checkOferPrice(product) && idsToRetrieve.contains(product.id))
        .toList();
  }

  List<ProductModel> getProductsByIds(List<int> idsToRetrieve) {
    return _products
        .where((product) => idsToRetrieve.contains(product.id))
        .toList();
  }

  List<SubCategory> getsubcateById(int idToRetrieve) {
    return _subCategores
        .where((subcate) => subcate.categoryId == idToRetrieve)
        .toList();
  }

  List<OrderModel> getOrderOngoing() {
    return _Orders.where((subcate) => subcate.status! < 5).toList();
  }

  List<OrderModel> getOrderHistory() {
    return _Orders.where((subcate) => subcate.status! >= 5).toList();
  }

  String getCategoryNameById(int categoryId) {
    final CategoryModel? category = _categores.firstWhere(
      (cat) => cat.id == categoryId,
    );

    return lang == "en"
        ? category!.nameEn.toString()
        : lang == "ar"
            ? category!.nameAr.toString()
            : category!.nameKu.toString() ?? 'Category Not Found';
  }

  ProductModel getoneProductById(int itemId) {
    final ProductModel? item = _products.firstWhere(
      (element) => element.id == itemId,
    );

    if (item == null) {
      throw Exception('Item with ID $itemId not found');
    }

    return item;
  }

  Productitems getoneProductItemsById(int itemId) {
    final Productitems? item = _productitems.firstWhere(
      (element) => element.id == itemId,
    );

    if (item == null) {
      throw Exception('Item with ID $itemId not found');
    }

    return item;
  }

  Brandmodel getonebrandById(int itemId) {
    final Brandmodel? item = _brands.firstWhere(
      (element) => element.id == itemId,
    );

    if (item == null) {
      throw Exception('Item with ID $itemId not found');
    }

    return item;
  }

  List<OrderItems> getordersbyOrderId(String order_id) {
    return _Orderitems.where(
        (product) => order_id.contains(product.orderId.toString())).toList();
  }

  void updateOrder(int oid, int status) {
    final index = Orders.indexWhere((product) => product.id == oid);
    if (index != -1) {
      Orders[index].status = status;
      notifyListeners();
    } else {
      // Handle the case where the product with the specified ID is not found.
      print('Product with ID ${oid} not found.');
    }
  }

  OrderItems getorderitemsOnebyId(int id) {
    final OrderItems? item = _Orderitems.firstWhere(
      (element) => element.productId == id,
    );

    if (item == null) {
      throw Exception('Item with ID $_Orders not found');
    }

    return item;
  }

  int calculateTotalPriceOrder(int id) {
    int totalPrice = 0;
    int i = 0;
    for (var order in _Orderitems) {
      if (order.id == id) {
        totalPrice += order.sellPrice! * order.qt!;
      }
      i++;
    }

    return totalPrice;
  }

  String listOrderitemsId(int id) {
    String orderItemsId = "";

    _Orderitems.forEach((element) {
      if (element.orderId == id) {
        orderItemsId += ",," + element.productId.toString();
      }
    });

    return orderItemsId;
  }

  List<int> listOrderId() {
    List<int> orderPakageId = [];

    _Orders.forEach((element) {
      orderPakageId.add(element.id!);
    });

    return orderPakageId.toSet().toList();
  }

  List<int> listOrderProductIds() {
    List<int> OrderProductId = [];
    _Orderitems.forEach((element) {
      OrderProductId.add(element.productId!);
    });

    return OrderProductId.toSet().toList();
  }

  // Add a product to the list
  void setProducts(List<ProductModel> products) {
    _products = products;

    notifyListeners();
  }

  void setProductitems(List<Productitems> products) {
    _productitems = products;

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

  void setOrders(List<OrderModel> orders) {
    _Orders = orders;

    notifyListeners();
  }

  void setslides(List<Slidemodel> slide) {
    _slides = slide;

    notifyListeners();
  }

  void settops(List<Topmodel> top) {
    _tops = top;

    notifyListeners();
  }

  void setbrands(List<Brandmodel> brand) {
    _brands = brand;

    notifyListeners();
  }

  void setOrderItems(List<OrderItems> orderitems) {
    _Orderitems = orderitems;

    notifyListeners();
  }

  void setproductimages(List<ProductsImage> productimages) {
    _productimages = productimages;
    notifyListeners();
  }

  void setlocation(List<Locationuser> location) {
    _location = location;
    notifyListeners();
  }

  void addlocation(Locationuser location) {
    _location.add(location);
    notifyListeners();
  }

  Locationuser getonelocationById(int itemId) {
    Locationuser item = _location.firstWhere(
      (element) => element.id == itemId,
    );

    if (item == null) {
      throw Exception('Item with ID $itemId not found');
    }

    return item;
  }

  void deletelocation(int location) {
    final existingItemIndex = _location.indexWhere(
      (item) => item.id == location,
    );
    _location.removeAt(existingItemIndex);

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

  void setidItem(int idItem) {
    _idItem = idItem;
    notifyListeners();
  }

  void setdefultlocation(int id) {
    if (id >= 0) {
      _defultlocation = id;
    }

    notifyListeners();
  }

  void setsubcateSelect(int subcateSelect) {
    _subcateSelect = subcateSelect;
    notifyListeners();
  }

  void setshow(bool value) {
    show = value;

    notifyListeners();
  }

  void setActiveUser(bool value) {
    activeUser = value;

    notifyListeners();
  }

  void setnointernetcheck(bool value) {
    nointernetCheck = value;
    notifyListeners();
  }

  void setMinimumOrder(int value) {
    _minimumOrder = value;
    notifyListeners();
  }
}
